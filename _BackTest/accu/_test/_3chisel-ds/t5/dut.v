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
`endif // RANDOMIZE_REG_INIT
  reg [9:0] sumReg; // @[dut.scala 13:23]
  reg [1:0] countReg; // @[dut.scala 14:25]
  wire  _T = countReg == 2'h3; // @[dut.scala 21:19]
  wire [9:0] _GEN_8 = {{2'd0}, io_data_in}; // @[dut.scala 23:29]
  wire [9:0] _io_data_out_T_1 = sumReg + _GEN_8; // @[dut.scala 23:29]
  wire [1:0] _countReg_T_1 = countReg + 2'h1; // @[dut.scala 30:28]
  wire [9:0] _GEN_0 = countReg == 2'h3 ? _io_data_out_T_1 : 10'h0; // @[dut.scala 17:15 21:28 23:19]
  assign io_data_out = io_valid_in ? _GEN_0 : 10'h0; // @[dut.scala 17:15 20:21]
  assign io_valid_out = io_valid_in & _T; // @[dut.scala 18:16 20:21]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 13:23]
      sumReg <= 10'h0; // @[dut.scala 13:23]
    end else if (io_valid_in) begin // @[dut.scala 20:21]
      if (countReg == 2'h3) begin // @[dut.scala 21:28]
        sumReg <= 10'h0; // @[dut.scala 25:14]
      end else begin
        sumReg <= _io_data_out_T_1; // @[dut.scala 29:14]
      end
    end
    if (reset) begin // @[dut.scala 14:25]
      countReg <= 2'h0; // @[dut.scala 14:25]
    end else if (io_valid_in) begin // @[dut.scala 20:21]
      if (countReg == 2'h3) begin // @[dut.scala 21:28]
        countReg <= 2'h0; // @[dut.scala 26:16]
      end else begin
        countReg <= _countReg_T_1; // @[dut.scala 30:16]
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
  sumReg = _RAND_0[9:0];
  _RAND_1 = {1{`RANDOM}};
  countReg = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
