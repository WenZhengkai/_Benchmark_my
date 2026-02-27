module dut(
  input         clock,
  input         reset,
  input         io_i_en,
  input  [63:0] io_adda,
  input  [63:0] io_addb,
  output [64:0] io_result,
  output        io_o_en
);
`ifdef RANDOMIZE_REG_INIT
  reg [95:0] _RAND_0;
  reg [95:0] _RAND_1;
  reg [95:0] _RAND_2;
  reg [95:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg [64:0] stageRegs_0; // @[dut.scala 14:26]
  reg [64:0] stageRegs_1; // @[dut.scala 14:26]
  reg [64:0] stageRegs_2; // @[dut.scala 14:26]
  reg [64:0] stageRegs_3; // @[dut.scala 14:26]
  reg  enableRegs_0; // @[dut.scala 15:27]
  reg  enableRegs_1; // @[dut.scala 15:27]
  reg  enableRegs_2; // @[dut.scala 15:27]
  reg  enableRegs_3; // @[dut.scala 15:27]
  wire [15:0] addaParts_0 = io_adda[15:0]; // @[dut.scala 22:28]
  wire [15:0] addbParts_0 = io_addb[15:0]; // @[dut.scala 23:28]
  wire [15:0] addaParts_1 = io_adda[31:16]; // @[dut.scala 22:28]
  wire [15:0] addbParts_1 = io_addb[31:16]; // @[dut.scala 23:28]
  wire [15:0] addaParts_2 = io_adda[47:32]; // @[dut.scala 22:28]
  wire [15:0] addbParts_2 = io_addb[47:32]; // @[dut.scala 23:28]
  wire [15:0] addaParts_3 = io_adda[63:48]; // @[dut.scala 22:28]
  wire [15:0] addbParts_3 = io_addb[63:48]; // @[dut.scala 23:28]
  wire [16:0] _sum_T = addaParts_0 + addbParts_0; // @[dut.scala 32:28]
  wire [17:0] _sum_T_1 = {{1'd0}, _sum_T}; // @[dut.scala 32:44]
  wire [16:0] sum = _sum_T_1[16:0]; // @[dut.scala 32:44]
  wire  carry_1 = sum[16]; // @[dut.scala 34:24]
  wire [16:0] _sum_T_2 = addaParts_1 + addbParts_1; // @[dut.scala 32:28]
  wire [16:0] _GEN_0 = {{16'd0}, carry_1}; // @[dut.scala 32:44]
  wire [16:0] sum_1 = _sum_T_2 + _GEN_0; // @[dut.scala 32:44]
  wire  carry_2 = sum_1[16]; // @[dut.scala 34:24]
  wire [16:0] _sum_T_4 = addaParts_2 + addbParts_2; // @[dut.scala 32:28]
  wire [16:0] _GEN_1 = {{16'd0}, carry_2}; // @[dut.scala 32:44]
  wire [16:0] sum_2 = _sum_T_4 + _GEN_1; // @[dut.scala 32:44]
  wire  carry_3 = sum_2[16]; // @[dut.scala 34:24]
  wire [16:0] _sum_T_6 = addaParts_3 + addbParts_3; // @[dut.scala 32:28]
  wire [16:0] _GEN_2 = {{16'd0}, carry_3}; // @[dut.scala 32:44]
  wire [16:0] sum_3 = _sum_T_6 + _GEN_2; // @[dut.scala 32:44]
  wire  carry_4 = sum_3[16]; // @[dut.scala 34:24]
  wire [63:0] finalResult = {stageRegs_3[15:0],stageRegs_2[15:0],stageRegs_1[15:0],stageRegs_0[15:0]}; // @[dut.scala 44:87]
  wire [64:0] _io_result_T = {carry_4, 64'h0}; // @[dut.scala 45:40]
  wire [64:0] _GEN_3 = {{1'd0}, finalResult}; // @[dut.scala 45:28]
  assign io_result = _GEN_3 + _io_result_T; // @[dut.scala 45:28]
  assign io_o_en = enableRegs_3; // @[dut.scala 48:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:26]
      stageRegs_0 <= 65'h0; // @[dut.scala 14:26]
    end else begin
      stageRegs_0 <= {{48'd0}, sum}; // @[dut.scala 33:18]
    end
    if (reset) begin // @[dut.scala 14:26]
      stageRegs_1 <= 65'h0; // @[dut.scala 14:26]
    end else begin
      stageRegs_1 <= {{48'd0}, sum_1}; // @[dut.scala 33:18]
    end
    if (reset) begin // @[dut.scala 14:26]
      stageRegs_2 <= 65'h0; // @[dut.scala 14:26]
    end else begin
      stageRegs_2 <= {{48'd0}, sum_2}; // @[dut.scala 33:18]
    end
    if (reset) begin // @[dut.scala 14:26]
      stageRegs_3 <= 65'h0; // @[dut.scala 14:26]
    end else begin
      stageRegs_3 <= {{48'd0}, sum_3}; // @[dut.scala 33:18]
    end
    if (reset) begin // @[dut.scala 15:27]
      enableRegs_0 <= 1'h0; // @[dut.scala 15:27]
    end else begin
      enableRegs_0 <= io_i_en; // @[dut.scala 38:17]
    end
    if (reset) begin // @[dut.scala 15:27]
      enableRegs_1 <= 1'h0; // @[dut.scala 15:27]
    end else begin
      enableRegs_1 <= enableRegs_0; // @[dut.scala 40:19]
    end
    if (reset) begin // @[dut.scala 15:27]
      enableRegs_2 <= 1'h0; // @[dut.scala 15:27]
    end else begin
      enableRegs_2 <= enableRegs_1; // @[dut.scala 40:19]
    end
    if (reset) begin // @[dut.scala 15:27]
      enableRegs_3 <= 1'h0; // @[dut.scala 15:27]
    end else begin
      enableRegs_3 <= enableRegs_2; // @[dut.scala 40:19]
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
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {3{`RANDOM}};
  stageRegs_0 = _RAND_0[64:0];
  _RAND_1 = {3{`RANDOM}};
  stageRegs_1 = _RAND_1[64:0];
  _RAND_2 = {3{`RANDOM}};
  stageRegs_2 = _RAND_2[64:0];
  _RAND_3 = {3{`RANDOM}};
  stageRegs_3 = _RAND_3[64:0];
  _RAND_4 = {1{`RANDOM}};
  enableRegs_0 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  enableRegs_1 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  enableRegs_2 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  enableRegs_3 = _RAND_7[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
