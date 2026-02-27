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
  reg [9:0] accumulator; // @[dut.scala 16:28]
  reg [1:0] count; // @[dut.scala 18:22]
  reg  validOutReg; // @[dut.scala 20:28]
  wire [9:0] _GEN_8 = {{2'd0}, io_data_in}; // @[dut.scala 29:32]
  wire [9:0] _accumulator_T_1 = accumulator + _GEN_8; // @[dut.scala 29:32]
  wire [1:0] _count_T_1 = count + 2'h1; // @[dut.scala 31:20]
  wire  _T = count == 2'h3; // @[dut.scala 34:16]
  wire [9:0] _GEN_0 = count == 2'h3 ? _accumulator_T_1 : 10'h0; // @[dut.scala 25:15 34:25 36:19]
  wire  _GEN_7 = io_valid_in & _T; // @[dut.scala 24:15 27:21]
  assign io_valid_out = validOutReg; // @[dut.scala 23:16]
  assign io_data_out = io_valid_in ? _GEN_0 : 10'h0; // @[dut.scala 25:15 27:21]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 16:28]
      accumulator <= 10'h0; // @[dut.scala 16:28]
    end else if (io_valid_in) begin // @[dut.scala 27:21]
      if (count == 2'h3) begin // @[dut.scala 34:25]
        accumulator <= 10'h0; // @[dut.scala 40:19]
      end else begin
        accumulator <= _accumulator_T_1; // @[dut.scala 29:17]
      end
    end
    if (reset) begin // @[dut.scala 18:22]
      count <= 2'h0; // @[dut.scala 18:22]
    end else if (io_valid_in) begin // @[dut.scala 27:21]
      if (count == 2'h3) begin // @[dut.scala 34:25]
        count <= 2'h0; // @[dut.scala 41:13]
      end else begin
        count <= _count_T_1; // @[dut.scala 31:11]
      end
    end
    if (reset) begin // @[dut.scala 20:28]
      validOutReg <= 1'h0; // @[dut.scala 20:28]
    end else begin
      validOutReg <= _GEN_7;
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
  count = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  validOutReg = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
