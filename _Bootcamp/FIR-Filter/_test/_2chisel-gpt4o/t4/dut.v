module dut(
  input         clock,
  input         reset,
  input  [11:0] io_in,
  output [26:0] io_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg [11:0] delayLine_0; // @[dut.scala 15:26]
  reg [11:0] delayLine_1; // @[dut.scala 15:26]
  reg [11:0] delayLine_2; // @[dut.scala 15:26]
  reg [11:0] delayLine_3; // @[dut.scala 15:26]
  reg [11:0] delayLine_4; // @[dut.scala 15:26]
  reg [11:0] delayLine_5; // @[dut.scala 15:26]
  reg [11:0] delayLine_6; // @[dut.scala 15:26]
  wire [12:0] mults_0 = delayLine_0 * 1'h0; // @[dut.scala 22:12]
  wire [22:0] mults_1 = delayLine_1 * 11'h555; // @[dut.scala 22:12]
  wire [23:0] mults_2 = delayLine_2 * 12'haab; // @[dut.scala 22:12]
  wire [24:0] mults_3 = delayLine_3 * 13'h1000; // @[dut.scala 22:12]
  wire [23:0] mults_4 = delayLine_4 * 12'haab; // @[dut.scala 22:12]
  wire [22:0] mults_5 = delayLine_5 * 11'h555; // @[dut.scala 22:12]
  wire [12:0] mults_6 = delayLine_6 * 1'h0; // @[dut.scala 22:12]
  wire [22:0] _GEN_0 = {{10'd0}, mults_0}; // @[dut.scala 26:28]
  wire [23:0] _sum_T = _GEN_0 + mults_1; // @[dut.scala 26:28]
  wire [24:0] _sum_T_1 = _sum_T + mults_2; // @[dut.scala 26:28]
  wire [25:0] _sum_T_2 = _sum_T_1 + mults_3; // @[dut.scala 26:28]
  wire [25:0] _GEN_1 = {{2'd0}, mults_4}; // @[dut.scala 26:28]
  wire [26:0] _sum_T_3 = _sum_T_2 + _GEN_1; // @[dut.scala 26:28]
  wire [26:0] _GEN_2 = {{4'd0}, mults_5}; // @[dut.scala 26:28]
  wire [27:0] _sum_T_4 = _sum_T_3 + _GEN_2; // @[dut.scala 26:28]
  wire [27:0] _GEN_3 = {{15'd0}, mults_6}; // @[dut.scala 26:28]
  wire [28:0] sum = _sum_T_4 + _GEN_3; // @[dut.scala 26:28]
  assign io_out = sum[26:0]; // @[dut.scala 29:10]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:26]
      delayLine_0 <= 12'h0; // @[dut.scala 15:26]
    end else begin
      delayLine_0 <= io_in; // @[dut.scala 18:13]
    end
    if (reset) begin // @[dut.scala 15:26]
      delayLine_1 <= 12'h0; // @[dut.scala 15:26]
    end else begin
      delayLine_1 <= delayLine_0; // @[dut.scala 18:13]
    end
    if (reset) begin // @[dut.scala 15:26]
      delayLine_2 <= 12'h0; // @[dut.scala 15:26]
    end else begin
      delayLine_2 <= delayLine_1; // @[dut.scala 18:13]
    end
    if (reset) begin // @[dut.scala 15:26]
      delayLine_3 <= 12'h0; // @[dut.scala 15:26]
    end else begin
      delayLine_3 <= delayLine_2; // @[dut.scala 18:13]
    end
    if (reset) begin // @[dut.scala 15:26]
      delayLine_4 <= 12'h0; // @[dut.scala 15:26]
    end else begin
      delayLine_4 <= delayLine_3; // @[dut.scala 18:13]
    end
    if (reset) begin // @[dut.scala 15:26]
      delayLine_5 <= 12'h0; // @[dut.scala 15:26]
    end else begin
      delayLine_5 <= delayLine_4; // @[dut.scala 18:13]
    end
    if (reset) begin // @[dut.scala 15:26]
      delayLine_6 <= 12'h0; // @[dut.scala 15:26]
    end else begin
      delayLine_6 <= delayLine_5; // @[dut.scala 18:13]
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
  _RAND_0 = {1{`RANDOM}};
  delayLine_0 = _RAND_0[11:0];
  _RAND_1 = {1{`RANDOM}};
  delayLine_1 = _RAND_1[11:0];
  _RAND_2 = {1{`RANDOM}};
  delayLine_2 = _RAND_2[11:0];
  _RAND_3 = {1{`RANDOM}};
  delayLine_3 = _RAND_3[11:0];
  _RAND_4 = {1{`RANDOM}};
  delayLine_4 = _RAND_4[11:0];
  _RAND_5 = {1{`RANDOM}};
  delayLine_5 = _RAND_5[11:0];
  _RAND_6 = {1{`RANDOM}};
  delayLine_6 = _RAND_6[11:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
