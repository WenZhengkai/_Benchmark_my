
module RobUopStorage #(
  parameter int NUM_ROB_ROWS       = 2,
  parameter int CORE_WIDTH         = 32,
  parameter int COMPACT_UOP_WIDTH  = 2,
  parameter int ADDR_W             = 1  // log2ceil(NUM_ROB_ROWS) = 1 for NUM_ROB_ROWS=2
) (
  input  wire                         clock,
  input  wire                         reset,

  // enq_uops: per-lane fields (RobUop). We only need valid/opcode/dst to build compact.
  input  wire [CORE_WIDTH-1:0]        enq_uops_valid,   // uop.valid
  input  wire [CORE_WIDTH*7-1:0]      enq_uops_opcode,  // uop.opcode per lane (7 bits)
  input  wire [CORE_WIDTH*5-1:0]      enq_uops_dst,     // uop.dst per lane (5 bits)

  input  wire [CORE_WIDTH-1:0]        enq_valids,       // write mask per lane
  input  wire [ADDR_W-1:0]            rob_tail,
  input  wire [ADDR_W-1:0]            next_rob_head,

  output wire [CORE_WIDTH*COMPACT_UOP_WIDTH-1:0] rob_compact_uop_rdata
);

  // rob_head register: rob_head := next_rob_head every cycle (like Chisel)
  reg [ADDR_W-1:0] rob_head;
  always @(posedge clock) begin
    if (reset) rob_head <= {ADDR_W{1'b0}};
    else       rob_head <= next_rob_head;
  end

  // ---- "uop_to_compact(u).asUInt" packing then truncation to COMPACT_UOP_WIDTH ----
  // RobCompactUop fields are: valid(1), opcode(7), dst(5) => 13 bits total.
  // Chisel asUInt will pack them and then cast to UInt(COMPACT_UOP_WIDTH.W) via assignment,
  // truncating to LSBs if COMPACT_UOP_WIDTH < 13.
  // Here we explicitly form the packed 13b and take [COMPACT_UOP_WIDTH-1:0].
  wire [CORE_WIDTH*COMPACT_UOP_WIDTH-1:0] rob_compact_uop_wdata;

  genvar i;
  generate
    for (i = 0; i < CORE_WIDTH; i++) begin : GEN_WDATA
      wire        v    = enq_uops_valid[i];
      wire [6:0]  opc  = enq_uops_opcode[i*7 +: 7];
      wire [4:0]  dst  = enq_uops_dst   [i*5 +: 5];
      wire [12:0] packed = {v, opc, dst}; // 13 bits

      assign rob_compact_uop_wdata[i*COMPACT_UOP_WIDTH +: COMPACT_UOP_WIDTH] =
        packed[COMPACT_UOP_WIDTH-1:0]; // truncate like Chisel assignment to UInt(compactUopWidth.W)
    end
  endgenerate

  // ---- 1R1W masked memory: depth=2, each row holds CORE_WIDTH lanes of COMPACT_UOP_WIDTH ----
  reg [CORE_WIDTH*COMPACT_UOP_WIDTH-1:0] mem [0:NUM_ROB_ROWS-1];

  // masked write at rob_tail
  integer w;
  always @(posedge clock) begin
    if (!reset) begin
      for (w = 0; w < CORE_WIDTH; w = w + 1) begin
        if (enq_valids[w]) begin
          mem[rob_tail][w*COMPACT_UOP_WIDTH +: COMPACT_UOP_WIDTH]
            <= rob_compact_uop_wdata[w*COMPACT_UOP_WIDTH +: COMPACT_UOP_WIDTH];
        end
      end
    end
  end

  // synchronous read: output registered one cycle after address (SyncReadMem behavior)
  reg [CORE_WIDTH*COMPACT_UOP_WIDTH-1:0] rob_compact_uop_rdata_mem;
  always @(posedge clock) begin
    rob_compact_uop_rdata_mem <= mem[next_rob_head];
  end

  // ---- Delay registers to match RegNext / ShiftRegister(...,2) in Chisel ----
  reg [ADDR_W-1:0] rob_tail_d1, rob_tail_d2;
  always @(posedge clock) begin
    if (reset) begin
      rob_tail_d1 <= {ADDR_W{1'b0}};
      rob_tail_d2 <= {ADDR_W{1'b0}};
    end else begin
      rob_tail_d1 <= rob_tail;
      rob_tail_d2 <= rob_tail_d1;
    end
  end

  reg [CORE_WIDTH-1:0] enq_valids_d1, enq_valids_d2;
  always @(posedge clock) begin
    if (reset) begin
      enq_valids_d1 <= {CORE_WIDTH{1'b0}};
      enq_valids_d2 <= {CORE_WIDTH{1'b0}};
    end else begin
      enq_valids_d1 <= enq_valids;
      enq_valids_d2 <= enq_valids_d1;
    end
  end

  reg [CORE_WIDTH*COMPACT_UOP_WIDTH-1:0] wdata_d1, wdata_d2;
  always @(posedge clock) begin
    if (reset) begin
      wdata_d1 <= {CORE_WIDTH*COMPACT_UOP_WIDTH{1'b0}};
      wdata_d2 <= {CORE_WIDTH*COMPACT_UOP_WIDTH{1'b0}};
    end else begin
      wdata_d1 <= rob_compact_uop_wdata;
      wdata_d2 <= wdata_d1;
    end
  end

  // ---- Per-lane bypass muxing (matches the Chisel Mux chain) ----
  // Chisel:
  // Mux(rob_head == RegNext(tail) && RegNext(enq_valids(w)), RegNext(wdata(w)),
  //   Mux(rob_head == ShiftRegister(tail,2) && ShiftRegister(enq_valids(w),2), ShiftRegister(wdata(w),2),
  //       mem_rdata(w)))
  wire head_eq_tail_d1 = (rob_head == rob_tail_d1);
  wire head_eq_tail_d2 = (rob_head == rob_tail_d2);

  wire [CORE_WIDTH*COMPACT_UOP_WIDTH-1:0] bypassed_flat;

  generate
    for (i = 0; i < CORE_WIDTH; i++) begin : GEN_BYPASS
      wire [COMPACT_UOP_WIDTH-1:0] mem_lane  =
        rob_compact_uop_rdata_mem[i*COMPACT_UOP_WIDTH +: COMPACT_UOP_WIDTH];
      wire [COMPACT_UOP_WIDTH-1:0] d1_lane   =
        wdata_d1[i*COMPACT_UOP_WIDTH +: COMPACT_UOP_WIDTH];
      wire [COMPACT_UOP_WIDTH-1:0] d2_lane   =
        wdata_d2[i*COMPACT_UOP_WIDTH +: COMPACT_UOP_WIDTH];

      wire use_d1 = head_eq_tail_d1 && enq_valids_d1[i];
      wire use_d2 = head_eq_tail_d2 && enq_valids_d2[i];

      assign bypassed_flat[i*COMPACT_UOP_WIDTH +: COMPACT_UOP_WIDTH] =
        use_d1 ? d1_lane :
        use_d2 ? d2_lane :
                 mem_lane;
    end
  endgenerate

  assign rob_compact_uop_rdata = bypassed_flat;

endmodule
