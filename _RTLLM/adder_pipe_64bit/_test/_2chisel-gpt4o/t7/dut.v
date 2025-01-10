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
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
`endif // RANDOMIZE_REG_INIT
  reg  enableRegs_0; // @[dut.scala 17:27]
  reg  enableRegs_1; // @[dut.scala 17:27]
  reg  enableRegs_2; // @[dut.scala 17:27]
  reg  enableRegs_3; // @[dut.scala 17:27]
  wire [15:0] addaParts_0 = io_adda[15:0]; // @[dut.scala 20:38]
  wire [15:0] addaParts_1 = io_adda[31:16]; // @[dut.scala 20:54]
  wire [15:0] addaParts_2 = io_adda[47:32]; // @[dut.scala 20:71]
  wire [15:0] addaParts_3 = io_adda[63:48]; // @[dut.scala 20:88]
  wire [15:0] addbParts_0 = io_addb[15:0]; // @[dut.scala 21:38]
  wire [15:0] addbParts_1 = io_addb[31:16]; // @[dut.scala 21:54]
  wire [15:0] addbParts_2 = io_addb[47:32]; // @[dut.scala 21:71]
  wire [15:0] addbParts_3 = io_addb[63:48]; // @[dut.scala 21:88]
  reg [16:0] sum0; // @[dut.scala 24:21]
  reg  enableRegs_0_REG; // @[dut.scala 25:27]
  wire [16:0] _sum1_T = addaParts_1 + addbParts_1; // @[dut.scala 28:35]
  wire [16:0] _GEN_0 = {{16'd0}, sum0[16]}; // @[dut.scala 28:51]
  reg [16:0] sum1; // @[dut.scala 28:21]
  reg  enableRegs_1_REG; // @[dut.scala 29:27]
  wire [16:0] _sum2_T = addaParts_2 + addbParts_2; // @[dut.scala 32:35]
  wire [16:0] _GEN_1 = {{16'd0}, sum1[16]}; // @[dut.scala 32:51]
  reg [16:0] sum2; // @[dut.scala 32:21]
  reg  enableRegs_2_REG; // @[dut.scala 33:27]
  wire [16:0] _sum3_T = addaParts_3 + addbParts_3; // @[dut.scala 36:35]
  wire [16:0] _GEN_2 = {{16'd0}, sum2[16]}; // @[dut.scala 36:51]
  reg [16:0] sum3; // @[dut.scala 36:21]
  reg  enableRegs_3_REG; // @[dut.scala 37:27]
  wire [31:0] io_result_lo = {sum1[15:0],sum0[15:0]}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {sum3[16],sum3[15:0],sum2[15:0]}; // @[Cat.scala 33:92]
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = enableRegs_3; // @[dut.scala 43:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 17:27]
      enableRegs_0 <= 1'h0; // @[dut.scala 17:27]
    end else begin
      enableRegs_0 <= enableRegs_0_REG; // @[dut.scala 25:17]
    end
    if (reset) begin // @[dut.scala 17:27]
      enableRegs_1 <= 1'h0; // @[dut.scala 17:27]
    end else begin
      enableRegs_1 <= enableRegs_1_REG; // @[dut.scala 29:17]
    end
    if (reset) begin // @[dut.scala 17:27]
      enableRegs_2 <= 1'h0; // @[dut.scala 17:27]
    end else begin
      enableRegs_2 <= enableRegs_2_REG; // @[dut.scala 33:17]
    end
    if (reset) begin // @[dut.scala 17:27]
      enableRegs_3 <= 1'h0; // @[dut.scala 17:27]
    end else begin
      enableRegs_3 <= enableRegs_3_REG; // @[dut.scala 37:17]
    end
    sum0 <= addaParts_0 + addbParts_0; // @[dut.scala 24:35]
    enableRegs_0_REG <= io_i_en; // @[dut.scala 25:27]
    sum1 <= _sum1_T + _GEN_0; // @[dut.scala 28:51]
    enableRegs_1_REG <= enableRegs_0; // @[dut.scala 29:27]
    sum2 <= _sum2_T + _GEN_1; // @[dut.scala 32:51]
    enableRegs_2_REG <= enableRegs_1; // @[dut.scala 33:27]
    sum3 <= _sum3_T + _GEN_2; // @[dut.scala 36:51]
    enableRegs_3_REG <= enableRegs_2; // @[dut.scala 37:27]
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
  _RAND_0 = {1{`RANDOM}};
  enableRegs_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  enableRegs_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  enableRegs_2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  enableRegs_3 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  sum0 = _RAND_4[16:0];
  _RAND_5 = {1{`RANDOM}};
  enableRegs_0_REG = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  sum1 = _RAND_6[16:0];
  _RAND_7 = {1{`RANDOM}};
  enableRegs_1_REG = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  sum2 = _RAND_8[16:0];
  _RAND_9 = {1{`RANDOM}};
  enableRegs_2_REG = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  sum3 = _RAND_10[16:0];
  _RAND_11 = {1{`RANDOM}};
  enableRegs_3_REG = _RAND_11[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
