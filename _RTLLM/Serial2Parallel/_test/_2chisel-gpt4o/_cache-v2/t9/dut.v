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
  reg [7:0] shiftReg; // @[dut.scala 13:25]
  reg [2:0] counter; // @[dut.scala 14:25]
  reg  doutValid; // @[dut.scala 15:26]
  wire [7:0] _shiftReg_T_1 = {shiftReg[6:0],io_din_serial}; // @[Cat.scala 33:92]
  wire [2:0] _counter_T_1 = counter + 3'h1; // @[dut.scala 25:24]
  wire  _T = counter == 3'h7; // @[dut.scala 28:18]
  wire  _GEN_4 = io_din_valid & _T; // @[dut.scala 22:22 35:15]
  assign io_dout_parallel = shiftReg; // @[dut.scala 18:20]
  assign io_dout_valid = doutValid; // @[dut.scala 19:17]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 13:25]
      shiftReg <= 8'h0; // @[dut.scala 13:25]
    end else if (io_din_valid) begin // @[dut.scala 22:22]
      shiftReg <= _shiftReg_T_1; // @[dut.scala 24:14]
    end
    if (reset) begin // @[dut.scala 14:25]
      counter <= 3'h0; // @[dut.scala 14:25]
    end else if (io_din_valid) begin // @[dut.scala 22:22]
      if (counter == 3'h7) begin // @[dut.scala 28:27]
        counter <= 3'h0; // @[dut.scala 30:15]
      end else begin
        counter <= _counter_T_1; // @[dut.scala 25:13]
      end
    end
    if (reset) begin // @[dut.scala 15:26]
      doutValid <= 1'h0; // @[dut.scala 15:26]
    end else begin
      doutValid <= _GEN_4;
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
  counter = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  doutValid = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
