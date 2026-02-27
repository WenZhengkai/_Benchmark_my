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
  reg  clk_50_reg; // @[dut.scala 16:29]
  reg [2:0] cnt_10; // @[dut.scala 21:25]
  reg  clk_10_reg; // @[dut.scala 22:29]
  wire [2:0] _cnt_10_T_1 = cnt_10 + 3'h1; // @[dut.scala 28:24]
  reg [6:0] cnt_100; // @[dut.scala 33:26]
  reg  clk_1_reg; // @[dut.scala 34:28]
  wire [6:0] _cnt_100_T_1 = cnt_100 + 7'h1; // @[dut.scala 40:26]
  assign io_CLK_50 = clk_50_reg; // @[dut.scala 18:29]
  assign io_CLK_10 = clk_10_reg; // @[dut.scala 30:29]
  assign io_CLK_1 = clk_1_reg; // @[dut.scala 42:27]
  always @(posedge io_CLK_in) begin
    if (io_RST) begin // @[dut.scala 16:29]
      clk_50_reg <= 1'h0; // @[dut.scala 16:29]
    end else begin
      clk_50_reg <= ~clk_50_reg; // @[dut.scala 17:16]
    end
    if (io_RST) begin // @[dut.scala 21:25]
      cnt_10 <= 3'h0; // @[dut.scala 21:25]
    end else if (cnt_10 == 3'h4) begin // @[dut.scala 24:26]
      cnt_10 <= 3'h0; // @[dut.scala 26:14]
    end else begin
      cnt_10 <= _cnt_10_T_1; // @[dut.scala 28:14]
    end
    if (io_RST) begin // @[dut.scala 22:29]
      clk_10_reg <= 1'h0; // @[dut.scala 22:29]
    end else if (cnt_10 == 3'h4) begin // @[dut.scala 24:26]
      clk_10_reg <= ~clk_10_reg; // @[dut.scala 25:18]
    end
    if (io_RST) begin // @[dut.scala 33:26]
      cnt_100 <= 7'h0; // @[dut.scala 33:26]
    end else if (cnt_100 == 7'h31) begin // @[dut.scala 36:28]
      cnt_100 <= 7'h0; // @[dut.scala 38:15]
    end else begin
      cnt_100 <= _cnt_100_T_1; // @[dut.scala 40:15]
    end
    if (io_RST) begin // @[dut.scala 34:28]
      clk_1_reg <= 1'h0; // @[dut.scala 34:28]
    end else if (cnt_100 == 7'h31) begin // @[dut.scala 36:28]
      clk_1_reg <= ~clk_1_reg; // @[dut.scala 37:17]
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
  clk_50_reg = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  cnt_10 = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  clk_10_reg = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  cnt_100 = _RAND_3[6:0];
  _RAND_4 = {1{`RANDOM}};
  clk_1_reg = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
