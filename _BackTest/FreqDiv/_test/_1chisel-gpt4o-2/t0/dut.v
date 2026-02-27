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
  reg  clk_50; // @[dut.scala 13:23]
  reg  clk_10; // @[dut.scala 14:23]
  reg  clk_1; // @[dut.scala 15:22]
  reg [2:0] cnt_10; // @[dut.scala 18:23]
  reg [5:0] cnt_100; // @[dut.scala 19:24]
  wire [2:0] _cnt_10_T_1 = cnt_10 + 3'h1; // @[dut.scala 37:24]
  wire [5:0] _cnt_100_T_1 = cnt_100 + 6'h1; // @[dut.scala 50:26]
  assign io_CLK_50 = clk_50; // @[dut.scala 55:13]
  assign io_CLK_10 = clk_10; // @[dut.scala 56:13]
  assign io_CLK_1 = clk_1; // @[dut.scala 57:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 13:23]
      clk_50 <= 1'h0; // @[dut.scala 13:23]
    end else if (io_RST) begin // @[dut.scala 22:16]
      clk_50 <= 1'h0; // @[dut.scala 23:12]
    end else if (io_CLK_in) begin // @[dut.scala 24:26]
      clk_50 <= ~clk_50; // @[dut.scala 25:12]
    end
    if (reset) begin // @[dut.scala 14:23]
      clk_10 <= 1'h0; // @[dut.scala 14:23]
    end else if (io_RST) begin // @[dut.scala 29:16]
      clk_10 <= 1'h0; // @[dut.scala 30:12]
    end else if (io_CLK_in) begin // @[dut.scala 32:26]
      if (cnt_10 == 3'h4) begin // @[dut.scala 33:26]
        clk_10 <= ~clk_10; // @[dut.scala 34:14]
      end
    end
    if (reset) begin // @[dut.scala 15:22]
      clk_1 <= 1'h0; // @[dut.scala 15:22]
    end else if (io_RST) begin // @[dut.scala 42:16]
      clk_1 <= 1'h0; // @[dut.scala 43:11]
    end else if (io_CLK_in) begin // @[dut.scala 45:26]
      if (cnt_100 == 6'h31) begin // @[dut.scala 46:28]
        clk_1 <= ~clk_1; // @[dut.scala 47:13]
      end
    end
    if (reset) begin // @[dut.scala 18:23]
      cnt_10 <= 3'h0; // @[dut.scala 18:23]
    end else if (io_RST) begin // @[dut.scala 29:16]
      cnt_10 <= 3'h0; // @[dut.scala 31:12]
    end else if (io_CLK_in) begin // @[dut.scala 32:26]
      if (cnt_10 == 3'h4) begin // @[dut.scala 33:26]
        cnt_10 <= 3'h0; // @[dut.scala 35:14]
      end else begin
        cnt_10 <= _cnt_10_T_1; // @[dut.scala 37:14]
      end
    end
    if (reset) begin // @[dut.scala 19:24]
      cnt_100 <= 6'h0; // @[dut.scala 19:24]
    end else if (io_RST) begin // @[dut.scala 42:16]
      cnt_100 <= 6'h0; // @[dut.scala 44:13]
    end else if (io_CLK_in) begin // @[dut.scala 45:26]
      if (cnt_100 == 6'h31) begin // @[dut.scala 46:28]
        cnt_100 <= 6'h0; // @[dut.scala 48:15]
      end else begin
        cnt_100 <= _cnt_100_T_1; // @[dut.scala 50:15]
      end
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
  clk_50 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  clk_10 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  clk_1 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  cnt_10 = _RAND_3[2:0];
  _RAND_4 = {1{`RANDOM}};
  cnt_100 = _RAND_4[5:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
