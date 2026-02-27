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
  reg  CLK_50_reg; // @[dut.scala 14:27]
  reg  CLK_10_reg; // @[dut.scala 15:27]
  reg  CLK_1_reg; // @[dut.scala 16:26]
  reg [3:0] cnt_10; // @[dut.scala 19:23]
  reg [6:0] cnt_100; // @[dut.scala 20:24]
  wire [3:0] _cnt_10_T_1 = cnt_10 + 4'h1; // @[dut.scala 38:24]
  wire [6:0] _cnt_100_T_1 = cnt_100 + 7'h1; // @[dut.scala 51:26]
  assign io_CLK_50 = CLK_50_reg; // @[dut.scala 56:13]
  assign io_CLK_10 = CLK_10_reg; // @[dut.scala 57:13]
  assign io_CLK_1 = CLK_1_reg; // @[dut.scala 58:12]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:27]
      CLK_50_reg <= 1'h0; // @[dut.scala 14:27]
    end else if (io_RST) begin // @[dut.scala 23:16]
      CLK_50_reg <= 1'h0; // @[dut.scala 24:16]
    end else if (io_CLK_in) begin // @[dut.scala 25:26]
      CLK_50_reg <= ~CLK_50_reg; // @[dut.scala 26:16]
    end
    if (reset) begin // @[dut.scala 15:27]
      CLK_10_reg <= 1'h0; // @[dut.scala 15:27]
    end else if (io_RST) begin // @[dut.scala 30:16]
      CLK_10_reg <= 1'h0; // @[dut.scala 32:16]
    end else if (io_CLK_in) begin // @[dut.scala 33:26]
      if (cnt_10 == 4'h4) begin // @[dut.scala 34:26]
        CLK_10_reg <= ~CLK_10_reg; // @[dut.scala 35:18]
      end
    end
    if (reset) begin // @[dut.scala 16:26]
      CLK_1_reg <= 1'h0; // @[dut.scala 16:26]
    end else if (io_RST) begin // @[dut.scala 43:16]
      CLK_1_reg <= 1'h0; // @[dut.scala 45:15]
    end else if (io_CLK_in) begin // @[dut.scala 46:26]
      if (cnt_100 == 7'h31) begin // @[dut.scala 47:28]
        CLK_1_reg <= ~CLK_1_reg; // @[dut.scala 48:17]
      end
    end
    if (reset) begin // @[dut.scala 19:23]
      cnt_10 <= 4'h0; // @[dut.scala 19:23]
    end else if (io_RST) begin // @[dut.scala 30:16]
      cnt_10 <= 4'h0; // @[dut.scala 31:12]
    end else if (io_CLK_in) begin // @[dut.scala 33:26]
      if (cnt_10 == 4'h4) begin // @[dut.scala 34:26]
        cnt_10 <= 4'h0; // @[dut.scala 36:14]
      end else begin
        cnt_10 <= _cnt_10_T_1; // @[dut.scala 38:14]
      end
    end
    if (reset) begin // @[dut.scala 20:24]
      cnt_100 <= 7'h0; // @[dut.scala 20:24]
    end else if (io_RST) begin // @[dut.scala 43:16]
      cnt_100 <= 7'h0; // @[dut.scala 44:13]
    end else if (io_CLK_in) begin // @[dut.scala 46:26]
      if (cnt_100 == 7'h31) begin // @[dut.scala 47:28]
        cnt_100 <= 7'h0; // @[dut.scala 49:15]
      end else begin
        cnt_100 <= _cnt_100_T_1; // @[dut.scala 51:15]
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
  CLK_50_reg = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  CLK_10_reg = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  CLK_1_reg = _RAND_2[0:0];
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
