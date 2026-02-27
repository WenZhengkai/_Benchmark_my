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
  reg  clk50; // @[dut.scala 14:22]
  reg [3:0] cnt10; // @[dut.scala 17:22]
  reg  clk10; // @[dut.scala 18:22]
  reg [6:0] cnt100; // @[dut.scala 21:23]
  reg  clk1; // @[dut.scala 22:21]
  wire [3:0] _cnt10_T_1 = cnt10 + 4'h1; // @[dut.scala 39:20]
  wire [6:0] _cnt100_T_1 = cnt100 + 7'h1; // @[dut.scala 50:22]
  assign io_CLK_50 = clk50; // @[dut.scala 54:13]
  assign io_CLK_10 = clk10; // @[dut.scala 55:13]
  assign io_CLK_1 = clk1; // @[dut.scala 56:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:22]
      clk50 <= 1'h0; // @[dut.scala 14:22]
    end else if (io_RST) begin // @[dut.scala 25:16]
      clk50 <= 1'h0; // @[dut.scala 26:11]
    end else begin
      clk50 <= ~clk50; // @[dut.scala 28:11]
    end
    if (reset) begin // @[dut.scala 17:22]
      cnt10 <= 4'h0; // @[dut.scala 17:22]
    end else if (io_RST) begin // @[dut.scala 32:16]
      cnt10 <= 4'h0; // @[dut.scala 33:11]
    end else if (cnt10 == 4'h4) begin // @[dut.scala 35:29]
      cnt10 <= 4'h0; // @[dut.scala 37:11]
    end else begin
      cnt10 <= _cnt10_T_1; // @[dut.scala 39:11]
    end
    if (reset) begin // @[dut.scala 18:22]
      clk10 <= 1'h0; // @[dut.scala 18:22]
    end else if (io_RST) begin // @[dut.scala 32:16]
      clk10 <= 1'h0; // @[dut.scala 34:11]
    end else if (cnt10 == 4'h4) begin // @[dut.scala 35:29]
      clk10 <= ~clk10; // @[dut.scala 36:11]
    end
    if (reset) begin // @[dut.scala 21:23]
      cnt100 <= 7'h0; // @[dut.scala 21:23]
    end else if (io_RST) begin // @[dut.scala 43:16]
      cnt100 <= 7'h0; // @[dut.scala 44:12]
    end else if (cnt100 == 7'h31) begin // @[dut.scala 46:31]
      cnt100 <= 7'h0; // @[dut.scala 48:12]
    end else begin
      cnt100 <= _cnt100_T_1; // @[dut.scala 50:12]
    end
    if (reset) begin // @[dut.scala 22:21]
      clk1 <= 1'h0; // @[dut.scala 22:21]
    end else if (io_RST) begin // @[dut.scala 43:16]
      clk1 <= 1'h0; // @[dut.scala 45:10]
    end else if (cnt100 == 7'h31) begin // @[dut.scala 46:31]
      clk1 <= ~clk1; // @[dut.scala 47:10]
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
  clk50 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  cnt10 = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  clk10 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  cnt100 = _RAND_3[6:0];
  _RAND_4 = {1{`RANDOM}};
  clk1 = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
