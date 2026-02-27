module dut(
  input        clock,
  input        reset,
  input  [7:0] io_data_in,
  input        io_valid_in,
  output       io_valid_out,
  output [9:0] io_data_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [9:0] accumulator; // @[dut.scala 13:28]
  reg [1:0] counter; // @[dut.scala 14:24]
  wire [9:0] _GEN_10 = {{2'd0}, io_data_in}; // @[dut.scala 22:32]
  wire [9:0] _accumulator_T_1 = accumulator + _GEN_10; // @[dut.scala 22:32]
  wire [1:0] _counter_T_1 = counter + 2'h1; // @[dut.scala 23:24]
  wire  _T = counter == 2'h3; // @[dut.scala 25:18]
  wire [9:0] _GEN_0 = counter == 2'h3 ? _accumulator_T_1 : 10'h0; // @[dut.scala 19:15 25:27 27:19]
  assign io_valid_out = io_valid_in & _T; // @[dut.scala 18:16 21:21]
  assign io_data_out = io_valid_in ? _GEN_0 : 10'h0; // @[dut.scala 19:15 21:21]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 13:28]
      accumulator <= 10'h0; // @[dut.scala 13:28]
    end else if (io_valid_in) begin // @[dut.scala 21:21]
      if (counter == 2'h3) begin // @[dut.scala 25:27]
        accumulator <= 10'h0; // @[dut.scala 29:19]
      end else begin
        accumulator <= _accumulator_T_1; // @[dut.scala 22:17]
      end
    end
    if (reset) begin // @[dut.scala 14:24]
      counter <= 2'h0; // @[dut.scala 14:24]
    end else if (io_valid_in) begin // @[dut.scala 21:21]
      if (counter == 2'h3) begin // @[dut.scala 25:27]
        counter <= 2'h0; // @[dut.scala 30:15]
      end else begin
        counter <= _counter_T_1; // @[dut.scala 23:13]
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
  accumulator = _RAND_0[9:0];
  _RAND_1 = {1{`RANDOM}};
  counter = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
