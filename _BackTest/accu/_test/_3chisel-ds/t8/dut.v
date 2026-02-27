module dut(
  input        clock,
  input        reset,
  input  [7:0] io_data_in,
  input        io_valid_in,
  output [9:0] io_data_out,
  output       io_valid_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [9:0] accumulator; // @[dut.scala 13:28]
  reg [1:0] counter; // @[dut.scala 14:24]
  reg  outputValid; // @[dut.scala 15:28]
  wire  _T = counter == 2'h3; // @[dut.scala 22:18]
  wire [9:0] _GEN_8 = {{2'd0}, io_data_in}; // @[dut.scala 24:34]
  wire [9:0] _accumulator_T_1 = accumulator + _GEN_8; // @[dut.scala 24:34]
  wire [1:0] _counter_T_1 = counter + 2'h1; // @[dut.scala 32:26]
  wire [9:0] _GEN_1 = counter == 2'h3 ? _accumulator_T_1 : 10'h0; // @[dut.scala 18:15 22:27 25:19]
  wire  _GEN_6 = io_valid_in & _T; // @[dut.scala 21:21 36:17]
  assign io_data_out = io_valid_in ? _GEN_1 : 10'h0; // @[dut.scala 18:15 21:21]
  assign io_valid_out = outputValid; // @[dut.scala 19:16]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 13:28]
      accumulator <= 10'h0; // @[dut.scala 13:28]
    end else if (io_valid_in) begin // @[dut.scala 21:21]
      if (counter == 2'h3) begin // @[dut.scala 22:27]
        accumulator <= 10'h0; // @[dut.scala 28:19]
      end else begin
        accumulator <= _accumulator_T_1; // @[dut.scala 31:19]
      end
    end
    if (reset) begin // @[dut.scala 14:24]
      counter <= 2'h0; // @[dut.scala 14:24]
    end else if (io_valid_in) begin // @[dut.scala 21:21]
      if (counter == 2'h3) begin // @[dut.scala 22:27]
        counter <= 2'h0; // @[dut.scala 27:15]
      end else begin
        counter <= _counter_T_1; // @[dut.scala 32:15]
      end
    end
    if (reset) begin // @[dut.scala 15:28]
      outputValid <= 1'h0; // @[dut.scala 15:28]
    end else begin
      outputValid <= _GEN_6;
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
  accumulator = _RAND_0[9:0];
  _RAND_1 = {1{`RANDOM}};
  counter = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  outputValid = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
