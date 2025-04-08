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
  reg [3:0] cntReg; // @[dut.scala 13:23]
  reg [7:0] shiftReg; // @[dut.scala 14:25]
  reg [7:0] doutParallelReg; // @[dut.scala 15:32]
  reg  doutValidReg; // @[dut.scala 16:29]
  wire [3:0] _cntReg_T_1 = cntReg + 4'h1; // @[dut.scala 20:22]
  wire  _T = cntReg == 4'h8; // @[dut.scala 21:17]
  wire [7:0] _shiftReg_T_1 = {shiftReg[6:0],io_din_serial}; // @[Cat.scala 33:92]
  wire  _T_2 = io_din_valid & _T; // @[dut.scala 32:21]
  assign io_dout_parallel = doutParallelReg; // @[dut.scala 40:20]
  assign io_dout_valid = doutValidReg; // @[dut.scala 41:17]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 13:23]
      cntReg <= 4'h0; // @[dut.scala 13:23]
    end else if (io_din_valid) begin // @[dut.scala 19:22]
      if (cntReg == 4'h8) begin // @[dut.scala 21:26]
        cntReg <= 4'h0; // @[dut.scala 22:14]
      end else begin
        cntReg <= _cntReg_T_1; // @[dut.scala 20:12]
      end
    end
    if (reset) begin // @[dut.scala 14:25]
      shiftReg <= 8'h0; // @[dut.scala 14:25]
    end else if (io_din_valid) begin // @[dut.scala 27:22]
      shiftReg <= _shiftReg_T_1; // @[dut.scala 28:14]
    end
    if (reset) begin // @[dut.scala 15:32]
      doutParallelReg <= 8'h0; // @[dut.scala 15:32]
    end else if (io_din_valid & _T) begin // @[dut.scala 32:40]
      doutParallelReg <= shiftReg; // @[dut.scala 33:21]
    end
    if (reset) begin // @[dut.scala 16:29]
      doutValidReg <= 1'h0; // @[dut.scala 16:29]
    end else begin
      doutValidReg <= _T_2; // @[dut.scala 37:16]
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
  cntReg = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  shiftReg = _RAND_1[7:0];
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
