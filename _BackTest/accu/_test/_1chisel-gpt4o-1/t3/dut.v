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
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [9:0] accumulator; // @[dut.scala 13:28]
  reg [1:0] dataCounter; // @[dut.scala 14:28]
  reg  validOut; // @[dut.scala 15:25]
  wire [9:0] _GEN_8 = {{2'd0}, io_data_in}; // @[dut.scala 22:32]
  wire [9:0] _accumulator_T_1 = accumulator + _GEN_8; // @[dut.scala 22:32]
  wire [1:0] _dataCounter_T_1 = dataCounter + 2'h1; // @[dut.scala 23:32]
  wire  _T = dataCounter == 2'h3; // @[dut.scala 25:22]
  wire [9:0] _GEN_0 = dataCounter == 2'h3 ? _accumulator_T_1 : 10'h0; // @[dut.scala 19:15 25:31 27:19]
  wire  _GEN_7 = io_valid_in & _T; // @[dut.scala 21:21 35:14]
  assign io_valid_out = validOut; // @[dut.scala 18:16]
  assign io_data_out = io_valid_in ? _GEN_0 : 10'h0; // @[dut.scala 19:15 21:21]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 13:28]
      accumulator <= 10'h0; // @[dut.scala 13:28]
    end else if (io_valid_in) begin // @[dut.scala 21:21]
      if (dataCounter == 2'h3) begin // @[dut.scala 25:31]
        accumulator <= 10'h0; // @[dut.scala 29:19]
      end else begin
        accumulator <= _accumulator_T_1; // @[dut.scala 22:17]
      end
    end
    if (reset) begin // @[dut.scala 14:28]
      dataCounter <= 2'h0; // @[dut.scala 14:28]
    end else if (io_valid_in) begin // @[dut.scala 21:21]
      if (dataCounter == 2'h3) begin // @[dut.scala 25:31]
        dataCounter <= 2'h0; // @[dut.scala 30:19]
      end else begin
        dataCounter <= _dataCounter_T_1; // @[dut.scala 23:17]
      end
    end
    if (reset) begin // @[dut.scala 15:25]
      validOut <= 1'h0; // @[dut.scala 15:25]
    end else begin
      validOut <= _GEN_7;
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
  dataCounter = _RAND_1[1:0];
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
