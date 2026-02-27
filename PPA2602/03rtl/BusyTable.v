
module BusyTable #(
  parameter integer NUMPREGS = 128,
  parameter integer PDST_W   = 8,
  parameter integer SM_W     = 8
)(
  input  wire                      clock,
  input  wire                      reset,

  // wakeups: Vec(NUMPREGS, Valid(Wakeup))
  input  wire [NUMPREGS-1:0]        wakeups_valid,
  input  wire [NUMPREGS*PDST_W-1:0] wakeups_pdst,
  input  wire [NUMPREGS*SM_W-1:0]   wakeups_spec_mask,
  input  wire [NUMPREGS-1:0]        wakeups_rebusy,

  // ren_uops: Vec(NUMPREGS, {pdst})
  input  wire [NUMPREGS*PDST_W-1:0] ren_uops_pdst,

  // rebusy_reqs: Vec(NUMPREGS, Bool)
  input  wire [NUMPREGS-1:0]        rebusy_reqs,

  // child_rebusys: UInt(NUMPREGS.W)
  input  wire [NUMPREGS-1:0]        child_rebusys,

  // busy_table output
  output wire [NUMPREGS-1:0]        busy_table
);

  // -----------------------------
  // 1-cycle pipeline of wakeups (RegNext)
  // -----------------------------
  reg  [NUMPREGS-1:0]        wv_r;
  reg  [NUMPREGS*PDST_W-1:0] pdst_r;
  reg  [NUMPREGS*SM_W-1:0]   sm_r;
  reg  [NUMPREGS-1:0]        rebusy_r;

  integer i;
  always @(posedge clock) begin
    if (reset) begin
      wv_r     <= {NUMPREGS{1'b0}};
      pdst_r   <= {(NUMPREGS*PDST_W){1'b0}};
      sm_r     <= {(NUMPREGS*SM_W){1'b0}};
      rebusy_r <= {NUMPREGS{1'b0}};
    end else begin
      wv_r     <= wakeups_valid;
      pdst_r   <= wakeups_pdst;
      sm_r     <= wakeups_spec_mask;
      rebusy_r <= wakeups_rebusy;
    end
  end

  // filtered/pipelined wakeup valids:
  // wu.valid := RegNext(w.valid) && ((RegNext(w.bits.speculative_mask) & child_rebusys) === 0.U)
  wire [NUMPREGS-1:0] wv_f;

  genvar g;
  generate
    for (g = 0; g < NUMPREGS; g = g + 1) begin : GEN_WV_F
      wire [SM_W-1:0] sm_g = sm_r[g*SM_W +: SM_W];
      assign wv_f[g] = wv_r[g] & (((sm_g & child_rebusys[SM_W-1:0]) == {SM_W{1'b0}}) ? 1'b1 : 1'b0);
    end
  endgenerate

  // -----------------------------
  // busy_table register (never updated in the Chisel)
  // -----------------------------
  reg [NUMPREGS-1:0] busy_table_reg;
  always @(posedge clock) begin
    if (reset) busy_table_reg <= {NUMPREGS{1'b0}};
    else       busy_table_reg <= busy_table_reg; // matches missing update in Chisel
  end

  // -----------------------------
  // Helpers: onehot for pdst (UIntToOH)
  // -----------------------------
  function [NUMPREGS-1:0] oh_from_pdst;
    input [PDST_W-1:0] idx;
    reg   [NUMPREGS-1:0] tmp;
    begin
      tmp = {NUMPREGS{1'b0}};
      if (idx < NUMPREGS[PDST_W-1:0])
        tmp[idx] = 1'b1;
      oh_from_pdst = tmp;
    end
  endfunction

  // -----------------------------
  // Compute:
  // busy_table_wb = busy_table & ~OR( UIntToOH(pdst) & Fill(N, valid & !rebusy) )
  // busy_table_next = busy_table_wb | OR( UIntToOH(ren_pdst) & Fill(N, req) )
  //                                | OR( UIntToOH(pdst) & Fill(N, valid & rebusy) )
  // io.busy_table := busy_table_next
  // -----------------------------
  reg [NUMPREGS-1:0] clr_mask;
  reg [NUMPREGS-1:0] set_mask_ren;
  reg [NUMPREGS-1:0] set_mask_wakeup_rebusy;

  always @* begin
    clr_mask             = {NUMPREGS{1'b0}};
    set_mask_ren         = {NUMPREGS{1'b0}};
    set_mask_wakeup_rebusy = {NUMPREGS{1'b0}};

    for (i = 0; i < NUMPREGS; i = i + 1) begin
      // wakeup fields for lane i
      // pdst is pipelined
      // rebusy is pipelined
      // valid is filtered/pipelined (wv_f)
      // ---- clear mask: valid & !rebusy
      if (wv_f[i] && !rebusy_r[i]) begin
        clr_mask = clr_mask | oh_from_pdst(pdst_r[i*PDST_W +: PDST_W]);
      end

      // ---- set mask from ren allocations: req
      if (rebusy_reqs[i]) begin
        set_mask_ren = set_mask_ren | oh_from_pdst(ren_uops_pdst[i*PDST_W +: PDST_W]);
      end

      // ---- set mask from wakeups that request rebusy: valid & rebusy
      if (wv_f[i] && rebusy_r[i]) begin
        set_mask_wakeup_rebusy = set_mask_wakeup_rebusy | oh_from_pdst(pdst_r[i*PDST_W +: PDST_W]);
      end
    end
  end

  wire [NUMPREGS-1:0] busy_table_wb   = busy_table_reg & ~clr_mask;
  wire [NUMPREGS-1:0] busy_table_next = busy_table_wb | set_mask_ren | set_mask_wakeup_rebusy;

  assign busy_table = busy_table_next;

endmodule
