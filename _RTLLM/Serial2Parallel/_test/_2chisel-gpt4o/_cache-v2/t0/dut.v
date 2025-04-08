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
`endif // RANDOMIZE_REG_INIT
  reg [3:0] cnt; // @[dut.scala 13:20]
  reg [7:0] parallelReg; // @[dut.scala 16:28]
  reg  validReg; // @[dut.scala 19:25]
  wire [7:0] _parallelReg_T_1 = {parallelReg[6:0],io_din_serial}; // @[Cat.scala 33:92]
  wire [3:0] _cnt_T_1 = cnt + 4'h1; // @[dut.scala 30:16]
  wire  _T_1 = cnt == 4'h7 & io_din_valid; // @[dut.scala 34:20]
  assign io_dout_parallel = parallelReg; // @[dut.scala 22:20]
  assign io_dout_valid = validReg; // @[dut.scala 23:17]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 13:20]
      cnt <= 4'h0; // @[dut.scala 13:20]
    end else if (cnt == 4'h7 & io_din_valid) begin // @[dut.scala 34:37]
      cnt <= 4'h0; // @[dut.scala 36:9]
    end else if (io_din_valid) begin // @[dut.scala 26:22]
      cnt <= _cnt_T_1; // @[dut.scala 30:9]
    end
    if (reset) begin // @[dut.scala 16:28]
      parallelReg <= 8'h0; // @[dut.scala 16:28]
    end else if (io_din_valid) begin // @[dut.scala 26:22]
      parallelReg <= _parallelReg_T_1; // @[dut.scala 28:17]
    end
    if (reset) begin // @[dut.scala 19:25]
      validReg <= 1'h0; // @[dut.scala 19:25]
    end else begin
      validReg <= _T_1;
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
  parallelReg = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  validReg = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
