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
  reg [7:0] shiftReg; // @[dut.scala 13:25]
  reg [3:0] cnt; // @[dut.scala 15:25]
  reg [7:0] doutParallelReg; // @[dut.scala 18:32]
  reg  doutValidReg; // @[dut.scala 19:32]
  wire [7:0] nextShift = {shiftReg[6:0],io_din_serial}; // @[Cat.scala 33:92]
  wire  _T = cnt == 4'h7; // @[dut.scala 27:14]
  wire [3:0] _cnt_T_1 = cnt + 4'h1; // @[dut.scala 33:18]
  wire  _GEN_4 = io_din_valid & _T; // @[dut.scala 22:16 24:22]
  assign io_dout_parallel = doutParallelReg; // @[dut.scala 39:20]
  assign io_dout_valid = doutValidReg; // @[dut.scala 40:17]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 13:25]
      shiftReg <= 8'h0; // @[dut.scala 13:25]
    end else if (io_din_valid) begin // @[dut.scala 24:22]
      shiftReg <= nextShift; // @[dut.scala 36:14]
    end
    if (reset) begin // @[dut.scala 15:25]
      cnt <= 4'h0; // @[dut.scala 15:25]
    end else if (io_din_valid) begin // @[dut.scala 24:22]
      if (cnt == 4'h7) begin // @[dut.scala 27:23]
        cnt <= 4'h0; // @[dut.scala 31:11]
      end else begin
        cnt <= _cnt_T_1; // @[dut.scala 33:11]
      end
    end
    if (reset) begin // @[dut.scala 18:32]
      doutParallelReg <= 8'h0; // @[dut.scala 18:32]
    end else if (io_din_valid) begin // @[dut.scala 24:22]
      if (cnt == 4'h7) begin // @[dut.scala 27:23]
        doutParallelReg <= nextShift; // @[dut.scala 29:23]
      end
    end
    if (reset) begin // @[dut.scala 19:32]
      doutValidReg <= 1'h0; // @[dut.scala 19:32]
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
  doutParallelReg = _RAND_2[7:0];
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
