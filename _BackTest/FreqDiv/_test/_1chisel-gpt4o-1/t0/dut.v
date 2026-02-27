module dut(
  input   clock,
  input   reset,
  input   io_CLK_in,
  input   io_RST,
  output  io_CLK_50,
  output  io_CLK_10,
  output  io_CLK_1
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg  reg_CLK_50; // @[dut.scala 13:27]
  reg  reg_CLK_10; // @[dut.scala 14:27]
  reg  reg_CLK_1; // @[dut.scala 15:26]
  reg [3:0] cnt_10; // @[dut.scala 18:23]
  reg [6:0] cnt_100; // @[dut.scala 19:24]
  wire [3:0] _cnt_10_T_1 = cnt_10 + 4'h1; // @[dut.scala 37:24]
  wire [6:0] _cnt_100_T_1 = cnt_100 + 7'h1; // @[dut.scala 50:26]
  assign io_CLK_50 = reg_CLK_50; // @[dut.scala 55:13]
  assign io_CLK_10 = reg_CLK_10; // @[dut.scala 56:13]
  assign io_CLK_1 = reg_CLK_1; // @[dut.scala 57:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 13:27]
      reg_CLK_50 <= 1'h0; // @[dut.scala 13:27]
    end else if (io_RST) begin // @[dut.scala 22:17]
      reg_CLK_50 <= 1'h0; // @[dut.scala 23:16]
    end else begin
      reg_CLK_50 <= ~reg_CLK_50; // @[dut.scala 25:16]
    end
    if (reset) begin // @[dut.scala 14:27]
      reg_CLK_10 <= 1'h0; // @[dut.scala 14:27]
    end else if (io_RST) begin // @[dut.scala 29:17]
      reg_CLK_10 <= 1'h0; // @[dut.scala 30:16]
    end else if (cnt_10 == 4'h4) begin // @[dut.scala 33:27]
      reg_CLK_10 <= ~reg_CLK_10; // @[dut.scala 34:18]
    end
    if (reset) begin // @[dut.scala 15:26]
      reg_CLK_1 <= 1'h0; // @[dut.scala 15:26]
    end else if (io_RST) begin // @[dut.scala 42:17]
      reg_CLK_1 <= 1'h0; // @[dut.scala 43:15]
    end else if (cnt_100 == 7'h31) begin // @[dut.scala 46:29]
      reg_CLK_1 <= ~reg_CLK_1; // @[dut.scala 47:17]
    end
    if (reset) begin // @[dut.scala 18:23]
      cnt_10 <= 4'h0; // @[dut.scala 18:23]
    end else if (io_RST) begin // @[dut.scala 29:17]
      cnt_10 <= 4'h0; // @[dut.scala 31:12]
    end else if (cnt_10 == 4'h4) begin // @[dut.scala 33:27]
      cnt_10 <= 4'h0; // @[dut.scala 35:14]
    end else begin
      cnt_10 <= _cnt_10_T_1; // @[dut.scala 37:14]
    end
    if (reset) begin // @[dut.scala 19:24]
      cnt_100 <= 7'h0; // @[dut.scala 19:24]
    end else if (io_RST) begin // @[dut.scala 42:17]
      cnt_100 <= 7'h0; // @[dut.scala 44:13]
    end else if (cnt_100 == 7'h31) begin // @[dut.scala 46:29]
      cnt_100 <= 7'h0; // @[dut.scala 48:15]
    end else begin
      cnt_100 <= _cnt_100_T_1; // @[dut.scala 50:15]
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
  reg_CLK_50 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  reg_CLK_10 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  reg_CLK_1 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  cnt_10 = _RAND_3[3:0];
  _RAND_4 = {1{`RANDOM}};
  cnt_100 = _RAND_4[6:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
