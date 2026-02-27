
module BusyTable #(
  parameter integer NUM_PREGS = 128,
  parameter integer PDST_W    = 8,
  parameter integer MASK_W    = 8
)(
  input  wire                     clock,
  input  wire                     reset,

  // wakeups: Vec(NUM_PREGS, Valid(Wakeup))
  input  wire [NUM_PREGS-1:0]     wakeups_valid,
  input  wire [NUM_PREGS*PDST_W-1:0] wakeups_uop_pdst,          // packed: [i*PDST_W +: PDST_W]
  input  wire [NUM_PREGS*MASK_W-1:0] wakeups_speculative_mask,  // packed
  input  wire [NUM_PREGS-1:0]     wakeups_rebusy,

  // ren_uops: Vec(NUM_PREGS, {pdst})
  input  wire [NUM_PREGS*PDST_W-1:0] ren_uops_pdst,             // packed

  // rebusy_reqs: Vec(NUM_PREGS, Bool)
  input  wire [NUM_PREGS-1:0]     rebusy_reqs,

  // child_rebusys: UInt(NUM_PREGS.W)
  input  wire [NUM_PREGS-1:0]     child_rebusys,

  // busy_table: UInt(NUM_PREGS.W)
  output wire [NUM_PREGS-1:0]     busy_table
);

  // ---------------------------------------------------------------------------
  // RegNext pipeline for wakeups, plus valid gating:
  // wu.valid := RegNext(w.valid) && ((RegNext(mask) & child_rebusys) === 0)
  // wu.bits  := RegNext(w.bits)
  // ---------------------------------------------------------------------------

  reg  [NUM_PREGS-1:0]        wv_q;
  reg  [NUM_PREGS*PDST_W-1:0] pdst_q;
  reg  [NUM_PREGS*MASK_W-1:0] mask_q;
  reg  [NUM_PREGS-1:0]        rebusy_q;

  integer i;
  always @(posedge clock) begin
    if (reset) begin
      wv_q     <= {NUM_PREGS{1'b0}};
      pdst_q   <= {NUM_PREGS*PDST_W{1'b0}};
      mask_q   <= {NUM_PREGS*MASK_W{1'b0}};
      rebusy_q <= {NUM_PREGS{1'b0}};
    end else begin
      wv_q     <= wakeups_valid;
      pdst_q   <= wakeups_uop_pdst;
      mask_q   <= wakeups_speculative_mask;
      rebusy_q <= wakeups_rebusy;
    end
  end

  // effective wakeup valids after child_rebusys masking
  wire [NUM_PREGS-1:0] wv_eff;
  genvar gi;
  generate
    for (gi = 0; gi < NUM_PREGS; gi = gi + 1) begin : GEN_WV_EFF
      wire [MASK_W-1:0] m = mask_q[gi*MASK_W +: MASK_W];
      assign wv_eff[gi] = wv_q[gi] && ((m & child_rebusys[MASK_W-1:0]) == {MASK_W{1'b0}});
    end
  endgenerate

  // ---------------------------------------------------------------------------
  // Busy table register (RegInit(0))
  // NOTE: Chisel code computes busy_table_next but does not update busy_table.
  // To preserve the same observable behavior, we keep busy_table_reg constant
  // unless you want it to actually latch busy_table_next each cycle.
  // ---------------------------------------------------------------------------

  reg [NUM_PREGS-1:0] busy_table_reg;

  always @(posedge clock) begin
    if (reset) begin
      busy_table_reg <= {NUM_PREGS{1'b0}};
    end else begin
      // The Chisel snippet never assigns busy_table := busy_table_next.
      // If you want the table to update, uncomment the next line:
      // busy_table_reg <= busy_table_next;
      busy_table_reg <= busy_table_reg;
    end
  end

  // ---------------------------------------------------------------------------
  // OneHot helper (UIntToOH(pdst)) for width NUM_PREGS.
  // If pdst >= NUM_PREGS, result is 0.
  // ---------------------------------------------------------------------------
  function [NUM_PREGS-1:0] to_oh;
    input [PDST_W-1:0] idx;
    integer k;
    begin
      to_oh = {NUM_PREGS{1'b0}};
      if (idx < NUM_PREGS[PDST_W-1:0]) begin
        to_oh[idx] = 1'b1;
      end
    end
  endfunction

  // ---------------------------------------------------------------------------
  // Build masks for:
  // 1) clearing on wakeups with rebusy==0
  // 2) setting on rename rebusy_reqs
  // 3) setting on wakeups with rebusy==1
  // ---------------------------------------------------------------------------

  reg [NUM_PREGS-1:0] clear_mask;
  reg [NUM_PREGS-1:0] set_mask_ren;
  reg [NUM_PREGS-1:0] set_mask_wakeup_rebusy;

  always @* begin
    clear_mask           = {NUM_PREGS{1'b0}};
    set_mask_ren         = {NUM_PREGS{1'b0}};
    set_mask_wakeup_rebusy = {NUM_PREGS{1'b0}};

    // wakeup-based clear/set
    for (i = 0; i < NUM_PREGS; i = i + 1) begin
      // pdst from registered wakeup bits
      // (bits are registered in pdst_q and rebusy_q)
      // wv_eff is the gated valid
      if (wv_eff[i]) begin
        if (!rebusy_q[i]) begin
          clear_mask = clear_mask | to_oh(pdst_q[i*PDST_W +: PDST_W]);
        end else begin
          set_mask_wakeup_rebusy = set_mask_wakeup_rebusy | to_oh(pdst_q[i*PDST_W +: PDST_W]);
        end
      end
    end

    // rename-based set
    for (i = 0; i < NUM_PREGS; i = i + 1) begin
      if (rebusy_reqs[i]) begin
        set_mask_ren = set_mask_ren | to_oh(ren_uops_pdst[i*PDST_W +: PDST_W]);
      end
    end
  end

  wire [NUM_PREGS-1:0] busy_table_wb   = busy_table_reg & ~clear_mask;
  wire [NUM_PREGS-1:0] busy_table_next = busy_table_wb | set_mask_ren | set_mask_wakeup_rebusy;

  // Output is combinational next-state, like Chisel: io.busy_table := busy_table_next
  assign busy_table = busy_table_next;

endmodule
