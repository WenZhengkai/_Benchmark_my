module dut(
  input        clock,
  input        reset,
  input        io_din_serial,
  input        io_din_valid,
  output [7:0] io_dout_parallel,
  output       io_dout_valid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] shiftReg; // @[dut.scala 12:28]
  reg [3:0] cnt; // @[dut.scala 13:28]
  reg [7:0] doutReg; // @[dut.scala 14:28]
  reg  doutValidReg; // @[dut.scala 15:29]
  wire [7:0] nextShift = {shiftReg[6:0],io_din_serial}; // @[Cat.scala 33:92]
  wire  _T = cnt == 4'h7; // @[dut.scala 23:14]
  wire [3:0] _cnt_T_1 = cnt + 4'h1; // @[dut.scala 29:18]
  wire  _GEN_4 = io_din_valid & _T; // @[dut.scala 18:16 20:22]
  assign io_dout_parallel = doutReg; // @[dut.scala 35:20]
  assign io_dout_valid = doutValidReg; // @[dut.scala 36:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 12:28]
      shiftReg <= 8'h0; // @[dut.scala 12:28]
    end else if (io_din_valid) begin // @[dut.scala 20:22]
      shiftReg <= nextShift; // @[dut.scala 32:14]
    end
    if (reset) begin // @[dut.scala 13:28]
      cnt <= 4'h0; // @[dut.scala 13:28]
    end else if (io_din_valid) begin // @[dut.scala 20:22]
      if (cnt == 4'h7) begin // @[dut.scala 23:23]
        cnt <= 4'h0; // @[dut.scala 27:20]
      end else begin
        cnt <= _cnt_T_1; // @[dut.scala 29:11]
      end
    end
    if (reset) begin // @[dut.scala 14:28]
      doutReg <= 8'h0; // @[dut.scala 14:28]
    end else if (io_din_valid) begin // @[dut.scala 20:22]
      if (cnt == 4'h7) begin // @[dut.scala 23:23]
        doutReg <= nextShift; // @[dut.scala 25:20]
      end
    end
    if (reset) begin // @[dut.scala 15:29]
      doutValidReg <= 1'h0; // @[dut.scala 15:29]
    end else begin
      doutValidReg <= _GEN_4;
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
  shiftReg = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  cnt = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  doutReg = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  doutValidReg = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
