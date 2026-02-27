
module RobUopStorage #(
  parameter integer NUM_ROB_ROWS      = 2,
  parameter integer CORE_WIDTH        = 32,
  parameter integer COMPACT_UOP_WIDTH = 2
)(
  input  wire                         clock,
  input  wire                         reset,

  // enq_uops: Vec(coreWidth, RobUop)
  // RobUop fields: valid(1), pc(32), opcode(7), dst(5)
  input  wire [CORE_WIDTH-1:0]        enq_uops_valid,
  input  wire [CORE_WIDTH*32-1:0]     enq_uops_pc,
  input  wire [CORE_WIDTH*7-1:0]      enq_uops_opcode,
  input  wire [CORE_WIDTH*5-1:0]      enq_uops_dst,

  input  wire [CORE_WIDTH-1:0]        enq_valids,

  input  wire [$clog2(NUM_ROB_ROWS)-1:0] rob_tail,
  input  wire [$clog2(NUM_ROB_ROWS)-1:0] next_rob_head,

  // rob_compact_uop_rdata: Vec(coreWidth, RobCompactUop)
  // RobCompactUop fields: valid(1), opcode(7), dst(5)
  output wire [CORE_WIDTH-1:0]        rob_compact_uop_rdata_valid,
  output wire [CORE_WIDTH*7-1:0]      rob_compact_uop_rdata_opcode,
  output wire [CORE_WIDTH*5-1:0]      rob_compact_uop_rdata_dst
);

  localparam integer ROW_ADDR_W = (NUM_ROB_ROWS <= 1) ? 1 : $clog2(NUM_ROB_ROWS);

  // rob_head reg, continuously updated from next_rob_head (like Chisel)
  reg [ROW_ADDR_W-1:0] rob_head;
  always @(posedge clock) begin
    if (reset) rob_head <= {ROW_ADDR_W{1'b0}};
    else       rob_head <= next_rob_head;
  end

  // Memory: numRobRows x coreWidth lanes x COMPACT_UOP_WIDTH bits
  reg [COMPACT_UOP_WIDTH-1:0] mem [0:NUM_ROB_ROWS-1][0:CORE_WIDTH-1];

  // Pack uop_to_compact(u).asUInt then truncate to COMPACT_UOP_WIDTH bits.
  // RobCompactUop asUInt order in Chisel is field declaration order:
  // {dst, opcode, valid} (valid is LSB).
  // So the full packed width would be 13 bits, but we keep only [COMPACT_UOP_WIDTH-1:0].
  wire [COMPACT_UOP_WIDTH-1:0] wdata [0:CORE_WIDTH-1];
  genvar w;
  generate
    for (w = 0; w < CORE_WIDTH; w = w + 1) begin : GEN_WDATA
      wire u_valid = enq_uops_valid[w];
      wire [6:0] u_opcode = enq_uops_opcode[w*7 +: 7];
      wire [4:0] u_dst    = enq_uops_dst[w*5 +: 5];

      wire [12:0] packed_full = {u_dst, u_opcode, u_valid}; // [12:0]
      assign wdata[w] = packed_full[COMPACT_UOP_WIDTH-1:0];
    end
  endgenerate

  // Masked write at rob_tail
  integer i;
  always @(posedge clock) begin
    for (i = 0; i < CORE_WIDTH; i = i + 1) begin
      if (enq_valids[i]) begin
        mem[rob_tail][i] <= wdata[i];
      end
    end
  end

  // Synchronous read (1-cycle latency), like SyncReadMem.read(addr)
  reg [COMPACT_UOP_WIDTH-1:0] rdata_q [0:CORE_WIDTH-1];
  always @(posedge clock) begin
    for (i = 0; i < CORE_WIDTH; i = i + 1) begin
      rdata_q[i] <= mem[next_rob_head][i];
    end
  end

  // Pipeline registers for bypass comparisons and bypass data
  reg [ROW_ADDR_W-1:0] rob_tail_d1, rob_tail_d2;
  reg [CORE_WIDTH-1:0] enq_valids_d1, enq_valids_d2;
  reg [COMPACT_UOP_WIDTH-1:0] wdata_d1 [0:CORE_WIDTH-1];
  reg [COMPACT_UOP_WIDTH-1:0] wdata_d2 [0:CORE_WIDTH-1];

  always @(posedge clock) begin
    if (reset) begin
      rob_tail_d1   <= {ROW_ADDR_W{1'b0}};
      rob_tail_d2   <= {ROW_ADDR_W{1'b0}};
      enq_valids_d1 <= {CORE_WIDTH{1'b0}};
      enq_valids_d2 <= {CORE_WIDTH{1'b0}};
      for (i = 0; i < CORE_WIDTH; i = i + 1) begin
        wdata_d1[i] <= {COMPACT_UOP_WIDTH{1'b0}};
        wdata_d2[i] <= {COMPACT_UOP_WIDTH{1'b0}};
      end
    end else begin
      rob_tail_d1   <= rob_tail;
      rob_tail_d2   <= rob_tail_d1;
      enq_valids_d1 <= enq_valids;
      enq_valids_d2 <= enq_valids_d1;
      for (i = 0; i < CORE_WIDTH; i = i + 1) begin
        wdata_d1[i] <= wdata[i];
        wdata_d2[i] <= wdata_d1[i];
      end
    end
  end

  // Bypass selection:
  // if (rob_head == RegNext(rob_tail) && RegNext(enq_valids[w])) use RegNext(wdata[w])
  // else if (rob_head == ShiftRegister(rob_tail, 2) && ShiftRegister(enq_valids[w], 2)) use ShiftRegister(wdata[w], 2)
  // else use rdata_q[w]
  wire [COMPACT_UOP_WIDTH-1:0] bypassed_bits [0:CORE_WIDTH-1];
  generate
    for (w = 0; w < CORE_WIDTH; w = w + 1) begin : GEN_BYPASS
      assign bypassed_bits[w] =
          ( (rob_head == rob_tail_d1) && enq_valids_d1[w] ) ? wdata_d1[w] :
          ( (rob_head == rob_tail_d2) && enq_valids_d2[w] ) ? wdata_d2[w] :
                                                             rdata_q[w];
    end
  endgenerate

  // Unpack COMPACT_UOP_WIDTH bits back into RobCompactUop fields.
  // Since only the LSB COMPACT_UOP_WIDTH bits exist, higher bits are 0.
  // packed_full = {dst[4:0], opcode[6:0], valid}
  // So bit0 = valid, bits[7:1]=opcode[6:0] (if available), bits[12:8]=dst[4:0] (if available)
  generate
    for (w = 0; w < CORE_WIDTH; w = w + 1) begin : GEN_UNPACK
      wire [COMPACT_UOP_WIDTH-1:0] bits = bypassed_bits[w];

      // valid is bit 0 if present
      assign rob_compact_uop_rdata_valid[w] = (COMPACT_UOP_WIDTH >= 1) ? bits[0] : 1'b0;

      // opcode uses bits[7:1]
      // Provide zero-extended opcode; only the bits that exist are driven.
      wire [6:0] opcode_zext;
      if (COMPACT_UOP_WIDTH <= 1) begin
        assign opcode_zext = 7'b0;
      end else if (COMPACT_UOP_WIDTH >= 8) begin
        assign opcode_zext = bits[7:1];
      end else begin
        // COMPACT_UOP_WIDTH is 2..7: only bits[COMPACT_UOP_WIDTH-1:1] exist
        assign opcode_zext = { {(8-COMPACT_UOP_WIDTH){1'b0}}, bits[COMPACT_UOP_WIDTH-1:1] };
      end
      assign rob_compact_uop_rdata_opcode[w*7 +: 7] = opcode_zext;

      // dst uses bits[12:8]
      wire [4:0] dst_zext;
      if (COMPACT_UOP_WIDTH <= 8) begin
        assign dst_zext = 5'b0;
      end else if (COMPACT_UOP_WIDTH >= 13) begin
        assign dst_zext = bits[12:8];
      end else begin
        // COMPACT_UOP_WIDTH is 9..12: partial dst bits exist [COMPACT_UOP_WIDTH-1:8]
        assign dst_zext = { {(13-COMPACT_UOP_WIDTH){1'b0}}, bits[COMPACT_UOP_WIDTH-1:8] };
      end
      assign rob_compact_uop_rdata_dst[w*5 +: 5] = dst_zext;
    end
  endgenerate

endmodule

