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
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [9:0] sumReg; // @[dut.scala 13:23]
  reg [1:0] countReg; // @[dut.scala 14:25]
  reg [9:0] outputReg; // @[dut.scala 15:26]
  reg  validOutReg; // @[dut.scala 16:28]
  wire [9:0] _GEN_8 = {{2'd0}, io_data_in}; // @[dut.scala 20:22]
  wire [9:0] _sumReg_T_1 = sumReg + _GEN_8; // @[dut.scala 20:22]
  wire [1:0] _countReg_T_1 = countReg + 2'h1; // @[dut.scala 21:26]
  wire  _T = countReg == 2'h3; // @[dut.scala 24:19]
  wire  _GEN_7 = io_valid_in & _T; // @[dut.scala 18:21 33:17]
  assign io_data_out = outputReg; // @[dut.scala 36:15]
  assign io_valid_out = validOutReg; // @[dut.scala 37:16]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 13:23]
      sumReg <= 10'h0; // @[dut.scala 13:23]
    end else if (io_valid_in) begin // @[dut.scala 18:21]
      if (countReg == 2'h3) begin // @[dut.scala 24:28]
        sumReg <= 10'h0; // @[dut.scala 27:14]
      end else begin
        sumReg <= _sumReg_T_1; // @[dut.scala 20:12]
      end
    end
    if (reset) begin // @[dut.scala 14:25]
      countReg <= 2'h0; // @[dut.scala 14:25]
    end else if (io_valid_in) begin // @[dut.scala 18:21]
      if (countReg == 2'h3) begin // @[dut.scala 24:28]
        countReg <= 2'h0; // @[dut.scala 28:16]
      end else begin
        countReg <= _countReg_T_1; // @[dut.scala 21:14]
      end
    end
    if (reset) begin // @[dut.scala 15:26]
      outputReg <= 10'h0; // @[dut.scala 15:26]
    end else if (io_valid_in) begin // @[dut.scala 18:21]
      if (countReg == 2'h3) begin // @[dut.scala 24:28]
        outputReg <= _sumReg_T_1; // @[dut.scala 25:17]
      end
    end
    if (reset) begin // @[dut.scala 16:28]
      validOutReg <= 1'h0; // @[dut.scala 16:28]
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
  sumReg = _RAND_0[9:0];
  _RAND_1 = {1{`RANDOM}};
  countReg = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  outputReg = _RAND_2[9:0];
  _RAND_3 = {1{`RANDOM}};
  validOutReg = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
