module BTB(
  input         clock,
  input         reset,
  input  [31:0] io_pc,
  input  [31:0] io_mem_pc,
  input         io_pcsrc,
  input         io_branch,
  output        io_btb_taken
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [1:0] btbTable [0:15]; // @[dut.scala 14:21]
  wire  btbTable_btbEntry_en; // @[dut.scala 14:21]
  wire [3:0] btbTable_btbEntry_addr; // @[dut.scala 14:21]
  wire [1:0] btbTable_btbEntry_data; // @[dut.scala 14:21]
  wire  btbTable_MPORT_16_en; // @[dut.scala 14:21]
  wire [3:0] btbTable_MPORT_16_addr; // @[dut.scala 14:21]
  wire [1:0] btbTable_MPORT_16_data; // @[dut.scala 14:21]
  wire  btbTable_MPORT_17_en; // @[dut.scala 14:21]
  wire [3:0] btbTable_MPORT_17_addr; // @[dut.scala 14:21]
  wire [1:0] btbTable_MPORT_17_data; // @[dut.scala 14:21]
  wire  btbTable_MPORT_19_en; // @[dut.scala 14:21]
  wire [3:0] btbTable_MPORT_19_addr; // @[dut.scala 14:21]
  wire [1:0] btbTable_MPORT_19_data; // @[dut.scala 14:21]
  wire  btbTable_MPORT_20_en; // @[dut.scala 14:21]
  wire [3:0] btbTable_MPORT_20_addr; // @[dut.scala 14:21]
  wire [1:0] btbTable_MPORT_20_data; // @[dut.scala 14:21]
  wire [1:0] btbTable_MPORT_data; // @[dut.scala 14:21]
  wire [3:0] btbTable_MPORT_addr; // @[dut.scala 14:21]
  wire  btbTable_MPORT_mask; // @[dut.scala 14:21]
  wire  btbTable_MPORT_en; // @[dut.scala 14:21]
  wire [1:0] btbTable_MPORT_1_data; // @[dut.scala 14:21]
  wire [3:0] btbTable_MPORT_1_addr; // @[dut.scala 14:21]
  wire  btbTable_MPORT_1_mask; // @[dut.scala 14:21]
  wire  btbTable_MPORT_1_en; // @[dut.scala 14:21]
  wire [1:0] btbTable_MPORT_2_data; // @[dut.scala 14:21]
  wire [3:0] btbTable_MPORT_2_addr; // @[dut.scala 14:21]
  wire  btbTable_MPORT_2_mask; // @[dut.scala 14:21]
  wire  btbTable_MPORT_2_en; // @[dut.scala 14:21]
  wire [1:0] btbTable_MPORT_3_data; // @[dut.scala 14:21]
  wire [3:0] btbTable_MPORT_3_addr; // @[dut.scala 14:21]
  wire  btbTable_MPORT_3_mask; // @[dut.scala 14:21]
  wire  btbTable_MPORT_3_en; // @[dut.scala 14:21]
  wire [1:0] btbTable_MPORT_4_data; // @[dut.scala 14:21]
  wire [3:0] btbTable_MPORT_4_addr; // @[dut.scala 14:21]
  wire  btbTable_MPORT_4_mask; // @[dut.scala 14:21]
  wire  btbTable_MPORT_4_en; // @[dut.scala 14:21]
  wire [1:0] btbTable_MPORT_5_data; // @[dut.scala 14:21]
  wire [3:0] btbTable_MPORT_5_addr; // @[dut.scala 14:21]
  wire  btbTable_MPORT_5_mask; // @[dut.scala 14:21]
  wire  btbTable_MPORT_5_en; // @[dut.scala 14:21]
  wire [1:0] btbTable_MPORT_6_data; // @[dut.scala 14:21]
  wire [3:0] btbTable_MPORT_6_addr; // @[dut.scala 14:21]
  wire  btbTable_MPORT_6_mask; // @[dut.scala 14:21]
  wire  btbTable_MPORT_6_en; // @[dut.scala 14:21]
  wire [1:0] btbTable_MPORT_7_data; // @[dut.scala 14:21]
  wire [3:0] btbTable_MPORT_7_addr; // @[dut.scala 14:21]
  wire  btbTable_MPORT_7_mask; // @[dut.scala 14:21]
  wire  btbTable_MPORT_7_en; // @[dut.scala 14:21]
  wire [1:0] btbTable_MPORT_8_data; // @[dut.scala 14:21]
  wire [3:0] btbTable_MPORT_8_addr; // @[dut.scala 14:21]
  wire  btbTable_MPORT_8_mask; // @[dut.scala 14:21]
  wire  btbTable_MPORT_8_en; // @[dut.scala 14:21]
  wire [1:0] btbTable_MPORT_9_data; // @[dut.scala 14:21]
  wire [3:0] btbTable_MPORT_9_addr; // @[dut.scala 14:21]
  wire  btbTable_MPORT_9_mask; // @[dut.scala 14:21]
  wire  btbTable_MPORT_9_en; // @[dut.scala 14:21]
  wire [1:0] btbTable_MPORT_10_data; // @[dut.scala 14:21]
  wire [3:0] btbTable_MPORT_10_addr; // @[dut.scala 14:21]
  wire  btbTable_MPORT_10_mask; // @[dut.scala 14:21]
  wire  btbTable_MPORT_10_en; // @[dut.scala 14:21]
  wire [1:0] btbTable_MPORT_11_data; // @[dut.scala 14:21]
  wire [3:0] btbTable_MPORT_11_addr; // @[dut.scala 14:21]
  wire  btbTable_MPORT_11_mask; // @[dut.scala 14:21]
  wire  btbTable_MPORT_11_en; // @[dut.scala 14:21]
  wire [1:0] btbTable_MPORT_12_data; // @[dut.scala 14:21]
  wire [3:0] btbTable_MPORT_12_addr; // @[dut.scala 14:21]
  wire  btbTable_MPORT_12_mask; // @[dut.scala 14:21]
  wire  btbTable_MPORT_12_en; // @[dut.scala 14:21]
  wire [1:0] btbTable_MPORT_13_data; // @[dut.scala 14:21]
  wire [3:0] btbTable_MPORT_13_addr; // @[dut.scala 14:21]
  wire  btbTable_MPORT_13_mask; // @[dut.scala 14:21]
  wire  btbTable_MPORT_13_en; // @[dut.scala 14:21]
  wire [1:0] btbTable_MPORT_14_data; // @[dut.scala 14:21]
  wire [3:0] btbTable_MPORT_14_addr; // @[dut.scala 14:21]
  wire  btbTable_MPORT_14_mask; // @[dut.scala 14:21]
  wire  btbTable_MPORT_14_en; // @[dut.scala 14:21]
  wire [1:0] btbTable_MPORT_15_data; // @[dut.scala 14:21]
  wire [3:0] btbTable_MPORT_15_addr; // @[dut.scala 14:21]
  wire  btbTable_MPORT_15_mask; // @[dut.scala 14:21]
  wire  btbTable_MPORT_15_en; // @[dut.scala 14:21]
  wire [1:0] btbTable_MPORT_18_data; // @[dut.scala 14:21]
  wire [3:0] btbTable_MPORT_18_addr; // @[dut.scala 14:21]
  wire  btbTable_MPORT_18_mask; // @[dut.scala 14:21]
  wire  btbTable_MPORT_18_en; // @[dut.scala 14:21]
  wire [1:0] btbTable_MPORT_21_data; // @[dut.scala 14:21]
  wire [3:0] btbTable_MPORT_21_addr; // @[dut.scala 14:21]
  wire  btbTable_MPORT_21_mask; // @[dut.scala 14:21]
  wire  btbTable_MPORT_21_en; // @[dut.scala 14:21]
  wire  _T_4 = btbTable_MPORT_16_data < 2'h3; // @[dut.scala 33:38]
  wire  _T_10 = btbTable_MPORT_19_data > 2'h0; // @[dut.scala 38:38]
  wire  _GEN_35 = io_pcsrc & _T_4; // @[dut.scala 14:21 31:28]
  wire  _GEN_41 = io_pcsrc ? 1'h0 : 1'h1; // @[dut.scala 14:21 31:28 38:20]
  wire  _GEN_44 = io_pcsrc ? 1'h0 : _T_10; // @[dut.scala 14:21 31:28]
  assign btbTable_btbEntry_en = 1'h1;
  assign btbTable_btbEntry_addr = io_pc[5:2];
  assign btbTable_btbEntry_data = btbTable[btbTable_btbEntry_addr]; // @[dut.scala 14:21]
  assign btbTable_MPORT_16_en = io_branch & io_pcsrc;
  assign btbTable_MPORT_16_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_16_data = btbTable[btbTable_MPORT_16_addr]; // @[dut.scala 14:21]
  assign btbTable_MPORT_17_en = io_branch & _GEN_35;
  assign btbTable_MPORT_17_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_17_data = btbTable[btbTable_MPORT_17_addr]; // @[dut.scala 14:21]
  assign btbTable_MPORT_19_en = io_branch & _GEN_41;
  assign btbTable_MPORT_19_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_19_data = btbTable[btbTable_MPORT_19_addr]; // @[dut.scala 14:21]
  assign btbTable_MPORT_20_en = io_branch & _GEN_44;
  assign btbTable_MPORT_20_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_20_data = btbTable[btbTable_MPORT_20_addr]; // @[dut.scala 14:21]
  assign btbTable_MPORT_data = 2'h0;
  assign btbTable_MPORT_addr = 4'h0;
  assign btbTable_MPORT_mask = 1'h1;
  assign btbTable_MPORT_en = reset;
  assign btbTable_MPORT_1_data = 2'h0;
  assign btbTable_MPORT_1_addr = 4'h1;
  assign btbTable_MPORT_1_mask = 1'h1;
  assign btbTable_MPORT_1_en = reset;
  assign btbTable_MPORT_2_data = 2'h0;
  assign btbTable_MPORT_2_addr = 4'h2;
  assign btbTable_MPORT_2_mask = 1'h1;
  assign btbTable_MPORT_2_en = reset;
  assign btbTable_MPORT_3_data = 2'h0;
  assign btbTable_MPORT_3_addr = 4'h3;
  assign btbTable_MPORT_3_mask = 1'h1;
  assign btbTable_MPORT_3_en = reset;
  assign btbTable_MPORT_4_data = 2'h0;
  assign btbTable_MPORT_4_addr = 4'h4;
  assign btbTable_MPORT_4_mask = 1'h1;
  assign btbTable_MPORT_4_en = reset;
  assign btbTable_MPORT_5_data = 2'h0;
  assign btbTable_MPORT_5_addr = 4'h5;
  assign btbTable_MPORT_5_mask = 1'h1;
  assign btbTable_MPORT_5_en = reset;
  assign btbTable_MPORT_6_data = 2'h0;
  assign btbTable_MPORT_6_addr = 4'h6;
  assign btbTable_MPORT_6_mask = 1'h1;
  assign btbTable_MPORT_6_en = reset;
  assign btbTable_MPORT_7_data = 2'h0;
  assign btbTable_MPORT_7_addr = 4'h7;
  assign btbTable_MPORT_7_mask = 1'h1;
  assign btbTable_MPORT_7_en = reset;
  assign btbTable_MPORT_8_data = 2'h0;
  assign btbTable_MPORT_8_addr = 4'h8;
  assign btbTable_MPORT_8_mask = 1'h1;
  assign btbTable_MPORT_8_en = reset;
  assign btbTable_MPORT_9_data = 2'h0;
  assign btbTable_MPORT_9_addr = 4'h9;
  assign btbTable_MPORT_9_mask = 1'h1;
  assign btbTable_MPORT_9_en = reset;
  assign btbTable_MPORT_10_data = 2'h0;
  assign btbTable_MPORT_10_addr = 4'ha;
  assign btbTable_MPORT_10_mask = 1'h1;
  assign btbTable_MPORT_10_en = reset;
  assign btbTable_MPORT_11_data = 2'h0;
  assign btbTable_MPORT_11_addr = 4'hb;
  assign btbTable_MPORT_11_mask = 1'h1;
  assign btbTable_MPORT_11_en = reset;
  assign btbTable_MPORT_12_data = 2'h0;
  assign btbTable_MPORT_12_addr = 4'hc;
  assign btbTable_MPORT_12_mask = 1'h1;
  assign btbTable_MPORT_12_en = reset;
  assign btbTable_MPORT_13_data = 2'h0;
  assign btbTable_MPORT_13_addr = 4'hd;
  assign btbTable_MPORT_13_mask = 1'h1;
  assign btbTable_MPORT_13_en = reset;
  assign btbTable_MPORT_14_data = 2'h0;
  assign btbTable_MPORT_14_addr = 4'he;
  assign btbTable_MPORT_14_mask = 1'h1;
  assign btbTable_MPORT_14_en = reset;
  assign btbTable_MPORT_15_data = 2'h0;
  assign btbTable_MPORT_15_addr = 4'hf;
  assign btbTable_MPORT_15_mask = 1'h1;
  assign btbTable_MPORT_15_en = reset;
  assign btbTable_MPORT_18_data = btbTable_MPORT_17_data + 2'h1;
  assign btbTable_MPORT_18_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_18_mask = 1'h1;
  assign btbTable_MPORT_18_en = io_branch & _GEN_35;
  assign btbTable_MPORT_21_data = btbTable_MPORT_20_data - 2'h1;
  assign btbTable_MPORT_21_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_21_mask = 1'h1;
  assign btbTable_MPORT_21_en = io_branch & _GEN_44;
  assign io_btb_taken = btbTable_btbEntry_data[1]; // @[dut.scala 27:28]
  always @(posedge clock) begin
    if (btbTable_MPORT_en & btbTable_MPORT_mask) begin
      btbTable[btbTable_MPORT_addr] <= btbTable_MPORT_data; // @[dut.scala 14:21]
    end
    if (btbTable_MPORT_1_en & btbTable_MPORT_1_mask) begin
      btbTable[btbTable_MPORT_1_addr] <= btbTable_MPORT_1_data; // @[dut.scala 14:21]
    end
    if (btbTable_MPORT_2_en & btbTable_MPORT_2_mask) begin
      btbTable[btbTable_MPORT_2_addr] <= btbTable_MPORT_2_data; // @[dut.scala 14:21]
    end
    if (btbTable_MPORT_3_en & btbTable_MPORT_3_mask) begin
      btbTable[btbTable_MPORT_3_addr] <= btbTable_MPORT_3_data; // @[dut.scala 14:21]
    end
    if (btbTable_MPORT_4_en & btbTable_MPORT_4_mask) begin
      btbTable[btbTable_MPORT_4_addr] <= btbTable_MPORT_4_data; // @[dut.scala 14:21]
    end
    if (btbTable_MPORT_5_en & btbTable_MPORT_5_mask) begin
      btbTable[btbTable_MPORT_5_addr] <= btbTable_MPORT_5_data; // @[dut.scala 14:21]
    end
    if (btbTable_MPORT_6_en & btbTable_MPORT_6_mask) begin
      btbTable[btbTable_MPORT_6_addr] <= btbTable_MPORT_6_data; // @[dut.scala 14:21]
    end
    if (btbTable_MPORT_7_en & btbTable_MPORT_7_mask) begin
      btbTable[btbTable_MPORT_7_addr] <= btbTable_MPORT_7_data; // @[dut.scala 14:21]
    end
    if (btbTable_MPORT_8_en & btbTable_MPORT_8_mask) begin
      btbTable[btbTable_MPORT_8_addr] <= btbTable_MPORT_8_data; // @[dut.scala 14:21]
    end
    if (btbTable_MPORT_9_en & btbTable_MPORT_9_mask) begin
      btbTable[btbTable_MPORT_9_addr] <= btbTable_MPORT_9_data; // @[dut.scala 14:21]
    end
    if (btbTable_MPORT_10_en & btbTable_MPORT_10_mask) begin
      btbTable[btbTable_MPORT_10_addr] <= btbTable_MPORT_10_data; // @[dut.scala 14:21]
    end
    if (btbTable_MPORT_11_en & btbTable_MPORT_11_mask) begin
      btbTable[btbTable_MPORT_11_addr] <= btbTable_MPORT_11_data; // @[dut.scala 14:21]
    end
    if (btbTable_MPORT_12_en & btbTable_MPORT_12_mask) begin
      btbTable[btbTable_MPORT_12_addr] <= btbTable_MPORT_12_data; // @[dut.scala 14:21]
    end
    if (btbTable_MPORT_13_en & btbTable_MPORT_13_mask) begin
      btbTable[btbTable_MPORT_13_addr] <= btbTable_MPORT_13_data; // @[dut.scala 14:21]
    end
    if (btbTable_MPORT_14_en & btbTable_MPORT_14_mask) begin
      btbTable[btbTable_MPORT_14_addr] <= btbTable_MPORT_14_data; // @[dut.scala 14:21]
    end
    if (btbTable_MPORT_15_en & btbTable_MPORT_15_mask) begin
      btbTable[btbTable_MPORT_15_addr] <= btbTable_MPORT_15_data; // @[dut.scala 14:21]
    end
    if (btbTable_MPORT_18_en & btbTable_MPORT_18_mask) begin
      btbTable[btbTable_MPORT_18_addr] <= btbTable_MPORT_18_data; // @[dut.scala 14:21]
    end
    if (btbTable_MPORT_21_en & btbTable_MPORT_21_mask) begin
      btbTable[btbTable_MPORT_21_addr] <= btbTable_MPORT_21_data; // @[dut.scala 14:21]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    btbTable[initvar] = _RAND_0[1:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
