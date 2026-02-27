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
  reg  clk50Reg; // @[dut.scala 14:25]
  reg  clk10Reg; // @[dut.scala 15:25]
  reg  clk1Reg; // @[dut.scala 16:24]
  reg [3:0] cnt10; // @[dut.scala 19:22]
  reg [6:0] cnt100; // @[dut.scala 20:23]
  wire [3:0] _cnt10_T_1 = cnt10 + 4'h1; // @[dut.scala 37:24]
  wire [6:0] _cnt100_T_1 = cnt100 + 7'h1; // @[dut.scala 52:26]
  assign io_CLK_50 = clk50Reg; // @[dut.scala 58:13]
  assign io_CLK_10 = clk10Reg; // @[dut.scala 59:13]
  assign io_CLK_1 = clk1Reg; // @[dut.scala 60:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:25]
      clk50Reg <= 1'h0; // @[dut.scala 14:25]
    end else if (io_RST) begin // @[dut.scala 24:20]
      clk50Reg <= 1'h0;
    end else begin
      clk50Reg <= ~clk50Reg;
    end
    if (reset) begin // @[dut.scala 15:25]
      clk10Reg <= 1'h0; // @[dut.scala 15:25]
    end else if (io_RST) begin // @[dut.scala 29:18]
      clk10Reg <= 1'h0; // @[dut.scala 30:16]
    end else if (cnt10 == 4'h4) begin // @[dut.scala 33:27]
      clk10Reg <= ~clk10Reg; // @[dut.scala 34:18]
    end
    if (reset) begin // @[dut.scala 16:24]
      clk1Reg <= 1'h0; // @[dut.scala 16:24]
    end else if (io_RST) begin // @[dut.scala 44:18]
      clk1Reg <= 1'h0; // @[dut.scala 45:15]
    end else if (cnt100 == 7'h31) begin // @[dut.scala 48:29]
      clk1Reg <= ~clk1Reg; // @[dut.scala 49:17]
    end
    if (reset) begin // @[dut.scala 19:22]
      cnt10 <= 4'h0; // @[dut.scala 19:22]
    end else if (io_RST) begin // @[dut.scala 29:18]
      cnt10 <= 4'h0; // @[dut.scala 31:13]
    end else if (cnt10 == 4'h4) begin // @[dut.scala 33:27]
      cnt10 <= 4'h0; // @[dut.scala 35:15]
    end else begin
      cnt10 <= _cnt10_T_1; // @[dut.scala 37:15]
    end
    if (reset) begin // @[dut.scala 20:23]
      cnt100 <= 7'h0; // @[dut.scala 20:23]
    end else if (io_RST) begin // @[dut.scala 44:18]
      cnt100 <= 7'h0; // @[dut.scala 46:14]
    end else if (cnt100 == 7'h31) begin // @[dut.scala 48:29]
      cnt100 <= 7'h0; // @[dut.scala 50:16]
    end else begin
      cnt100 <= _cnt100_T_1; // @[dut.scala 52:16]
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
  clk1Reg = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  cnt10 = _RAND_3[3:0];
  _RAND_4 = {1{`RANDOM}};
  cnt100 = _RAND_4[6:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
