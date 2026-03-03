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
  reg [3:0] cnt; // @[dut.scala 13:20]
  reg [7:0] shiftReg; // @[dut.scala 16:25]
  reg  validReg; // @[dut.scala 19:25]
  reg [7:0] parallelReg; // @[dut.scala 22:28]
  wire [7:0] _shiftReg_T_1 = {shiftReg[6:0],io_din_serial}; // @[Cat.scala 33:92]
  wire [3:0] _cnt_T_1 = cnt + 4'h1; // @[dut.scala 32:16]
  wire  _T = cnt == 4'h7; // @[dut.scala 35:14]
  wire  _GEN_6 = io_din_valid & _T; // @[dut.scala 25:12 27:22]
  assign io_dout_parallel = parallelReg; // @[dut.scala 44:20]
  assign io_dout_valid = validReg; // @[dut.scala 45:17]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 13:20]
      cnt <= 4'h0; // @[dut.scala 13:20]
    end else if (io_din_valid) begin // @[dut.scala 27:22]
      if (cnt == 4'h7) begin // @[dut.scala 35:23]
        cnt <= 4'h0; // @[dut.scala 39:11]
      end else begin
        cnt <= _cnt_T_1; // @[dut.scala 32:9]
      end
    end
    if (reset) begin // @[dut.scala 16:25]
      shiftReg <= 8'h0; // @[dut.scala 16:25]
    end else if (io_din_valid) begin // @[dut.scala 27:22]
      shiftReg <= _shiftReg_T_1; // @[dut.scala 29:14]
    end
    if (reset) begin // @[dut.scala 19:25]
      validReg <= 1'h0; // @[dut.scala 19:25]
    end else begin
      validReg <= _GEN_6;
    end
    if (reset) begin // @[dut.scala 22:28]
      parallelReg <= 8'h0; // @[dut.scala 22:28]
    end else if (io_din_valid) begin // @[dut.scala 27:22]
      if (cnt == 4'h7) begin // @[dut.scala 35:23]
        parallelReg <= _shiftReg_T_1; // @[dut.scala 37:19]
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
  cnt = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  shiftReg = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  validReg = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  parallelReg = _RAND_3[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
