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
  reg [7:0] parallelData; // @[dut.scala 13:29]
  reg [3:0] counter; // @[dut.scala 16:24]
  reg  validOut; // @[dut.scala 19:25]
  wire [7:0] _parallelData_T_1 = {parallelData[6:0],io_din_serial}; // @[Cat.scala 33:92]
  wire [3:0] _counter_T_1 = counter + 4'h1; // @[dut.scala 31:24]
  wire  _T = counter == 4'h7; // @[dut.scala 34:18]
  wire  _GEN_4 = io_din_valid & _T; // @[dut.scala 26:22 41:14]
  assign io_dout_parallel = parallelData; // @[dut.scala 22:20]
  assign io_dout_valid = validOut; // @[dut.scala 23:17]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 13:29]
      parallelData <= 8'h0; // @[dut.scala 13:29]
    end else if (io_din_valid) begin // @[dut.scala 26:22]
      parallelData <= _parallelData_T_1; // @[dut.scala 28:18]
    end
    if (reset) begin // @[dut.scala 16:24]
      counter <= 4'h0; // @[dut.scala 16:24]
    end else if (io_din_valid) begin // @[dut.scala 26:22]
      if (counter == 4'h7) begin // @[dut.scala 34:27]
        counter <= 4'h0; // @[dut.scala 36:15]
      end else begin
        counter <= _counter_T_1; // @[dut.scala 31:13]
      end
    end
    if (reset) begin // @[dut.scala 19:25]
      validOut <= 1'h0; // @[dut.scala 19:25]
    end else begin
      validOut <= _GEN_4;
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
  parallelData = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  counter = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  validOut = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
