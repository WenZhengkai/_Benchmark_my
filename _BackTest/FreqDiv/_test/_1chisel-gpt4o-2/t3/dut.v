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
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg  clk50Reg; // @[dut.scala 13:25]
  reg  clk10Reg; // @[dut.scala 14:25]
  reg  clk1Reg; // @[dut.scala 15:24]
  reg [3:0] cnt10; // @[dut.scala 18:22]
  reg [6:0] cnt100; // @[dut.scala 19:23]
  reg  REG; // @[dut.scala 26:23]
  reg  REG_1; // @[dut.scala 34:23]
  wire [3:0] _cnt10_T_1 = cnt10 + 4'h1; // @[dut.scala 39:22]
  reg  REG_2; // @[dut.scala 47:23]
  wire [6:0] _cnt100_T_1 = cnt100 + 7'h1; // @[dut.scala 52:24]
  assign io_CLK_50 = clk50Reg; // @[dut.scala 57:13]
  assign io_CLK_10 = clk10Reg; // @[dut.scala 58:13]
  assign io_CLK_1 = clk1Reg; // @[dut.scala 59:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 13:25]
      clk50Reg <= 1'h0; // @[dut.scala 13:25]
    end else if (io_RST) begin // @[dut.scala 24:17]
      clk50Reg <= 1'h0; // @[dut.scala 25:14]
    end else if (REG) begin // @[dut.scala 26:45]
      clk50Reg <= ~clk50Reg; // @[dut.scala 27:14]
    end
    if (reset) begin // @[dut.scala 14:25]
      clk10Reg <= 1'h0; // @[dut.scala 14:25]
    end else if (io_RST) begin // @[dut.scala 31:17]
      clk10Reg <= 1'h0; // @[dut.scala 32:14]
    end else if (REG_1) begin // @[dut.scala 34:45]
      if (cnt10 == 4'h4) begin // @[dut.scala 35:26]
        clk10Reg <= ~clk10Reg; // @[dut.scala 36:16]
      end
    end
    if (reset) begin // @[dut.scala 15:24]
      clk1Reg <= 1'h0; // @[dut.scala 15:24]
    end else if (io_RST) begin // @[dut.scala 44:17]
      clk1Reg <= 1'h0; // @[dut.scala 45:13]
    end else if (REG_2) begin // @[dut.scala 47:45]
      if (cnt100 == 7'h31) begin // @[dut.scala 48:28]
        clk1Reg <= ~clk1Reg; // @[dut.scala 49:15]
      end
    end
    if (reset) begin // @[dut.scala 18:22]
      cnt10 <= 4'h0; // @[dut.scala 18:22]
    end else if (io_RST) begin // @[dut.scala 31:17]
      cnt10 <= 4'h0; // @[dut.scala 33:11]
    end else if (REG_1) begin // @[dut.scala 34:45]
      if (cnt10 == 4'h4) begin // @[dut.scala 35:26]
        cnt10 <= 4'h0; // @[dut.scala 37:13]
      end else begin
        cnt10 <= _cnt10_T_1; // @[dut.scala 39:13]
      end
    end
    if (reset) begin // @[dut.scala 19:23]
      cnt100 <= 7'h0; // @[dut.scala 19:23]
    end else if (io_RST) begin // @[dut.scala 44:17]
      cnt100 <= 7'h0; // @[dut.scala 46:12]
    end else if (REG_2) begin // @[dut.scala 47:45]
      if (cnt100 == 7'h31) begin // @[dut.scala 48:28]
        cnt100 <= 7'h0; // @[dut.scala 50:14]
      end else begin
        cnt100 <= _cnt100_T_1; // @[dut.scala 52:14]
      end
    end
    REG <= io_CLK_in; // @[dut.scala 26:40]
    REG_1 <= io_CLK_in; // @[dut.scala 34:40]
    REG_2 <= io_CLK_in; // @[dut.scala 47:40]
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
  _RAND_5 = {1{`RANDOM}};
  REG = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  REG_1 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  REG_2 = _RAND_7[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
