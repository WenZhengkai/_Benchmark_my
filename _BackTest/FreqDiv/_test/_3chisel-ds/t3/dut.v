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
  reg  clk50Reg; // @[dut.scala 15:27]
  reg  clk10Reg; // @[dut.scala 20:27]
  reg [2:0] cnt10; // @[dut.scala 21:24]
  wire [2:0] _cnt10_T_1 = cnt10 + 3'h1; // @[dut.scala 27:22]
  reg  clk1Reg; // @[dut.scala 32:26]
  reg [5:0] cnt100; // @[dut.scala 33:25]
  wire [5:0] _cnt100_T_1 = cnt100 + 6'h1; // @[dut.scala 39:24]
  assign io_CLK_50 = clk50Reg; // @[dut.scala 17:15]
  assign io_CLK_10 = clk10Reg; // @[dut.scala 29:15]
  assign io_CLK_1 = clk1Reg; // @[dut.scala 41:14]
  always @(posedge io_CLK_in) begin
    if (io_RST) begin // @[dut.scala 15:27]
      clk50Reg <= 1'h0; // @[dut.scala 15:27]
    end else begin
      clk50Reg <= ~clk50Reg; // @[dut.scala 16:14]
    end
    if (io_RST) begin // @[dut.scala 20:27]
      clk10Reg <= 1'h0; // @[dut.scala 20:27]
    end else if (cnt10 == 3'h4) begin // @[dut.scala 23:25]
      clk10Reg <= ~clk10Reg; // @[dut.scala 24:16]
    end
    if (io_RST) begin // @[dut.scala 21:24]
      cnt10 <= 3'h0; // @[dut.scala 21:24]
    end else if (cnt10 == 3'h4) begin // @[dut.scala 23:25]
      cnt10 <= 3'h0; // @[dut.scala 25:13]
    end else begin
      cnt10 <= _cnt10_T_1; // @[dut.scala 27:13]
    end
    if (io_RST) begin // @[dut.scala 32:26]
      clk1Reg <= 1'h0; // @[dut.scala 32:26]
    end else if (cnt100 == 6'h31) begin // @[dut.scala 35:27]
      clk1Reg <= ~clk1Reg; // @[dut.scala 36:15]
    end
    if (io_RST) begin // @[dut.scala 33:25]
      cnt100 <= 6'h0; // @[dut.scala 33:25]
    end else if (cnt100 == 6'h31) begin // @[dut.scala 35:27]
      cnt100 <= 6'h0; // @[dut.scala 37:14]
    end else begin
      cnt100 <= _cnt100_T_1; // @[dut.scala 39:14]
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
  clk50Reg = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  clk10Reg = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  cnt10 = _RAND_2[2:0];
  _RAND_3 = {1{`RANDOM}};
  clk1Reg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  cnt100 = _RAND_4[5:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
