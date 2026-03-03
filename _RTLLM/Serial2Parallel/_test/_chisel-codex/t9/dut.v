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
  reg [7:0] shiftReg; // @[dut.scala 12:25]
  reg [3:0] cnt; // @[dut.scala 13:25]
  reg [7:0] outReg; // @[dut.scala 14:25]
  reg  outValid; // @[dut.scala 15:25]
  wire  _T = cnt == 4'h7; // @[dut.scala 21:14]
  wire [7:0] _outReg_T_1 = {shiftReg[6:0],io_din_serial}; // @[Cat.scala 33:92]
  wire [3:0] _cnt_T_1 = cnt + 4'h1; // @[dut.scala 29:23]
  wire  _GEN_5 = io_din_valid & _T; // @[dut.scala 18:12 20:22]
  assign io_dout_parallel = outReg; // @[dut.scala 33:20]
  assign io_dout_valid = outValid; // @[dut.scala 34:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 12:25]
      shiftReg <= 8'h0; // @[dut.scala 12:25]
    end else if (io_din_valid) begin // @[dut.scala 20:22]
      if (cnt == 4'h7) begin // @[dut.scala 21:23]
        shiftReg <= 8'h0; // @[dut.scala 26:16]
      end else begin
        shiftReg <= _outReg_T_1; // @[dut.scala 28:16]
      end
    end
    if (reset) begin // @[dut.scala 13:25]
      cnt <= 4'h0; // @[dut.scala 13:25]
    end else if (io_din_valid) begin // @[dut.scala 20:22]
      if (cnt == 4'h7) begin // @[dut.scala 21:23]
        cnt <= 4'h0; // @[dut.scala 25:16]
      end else begin
        cnt <= _cnt_T_1; // @[dut.scala 29:16]
      end
    end
    if (reset) begin // @[dut.scala 14:25]
      outReg <= 8'h0; // @[dut.scala 14:25]
    end else if (io_din_valid) begin // @[dut.scala 20:22]
      if (cnt == 4'h7) begin // @[dut.scala 21:23]
        outReg <= _outReg_T_1; // @[dut.scala 23:16]
      end
    end
    if (reset) begin // @[dut.scala 15:25]
      outValid <= 1'h0; // @[dut.scala 15:25]
    end else begin
      outValid <= _GEN_5;
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
  outReg = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  outValid = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
