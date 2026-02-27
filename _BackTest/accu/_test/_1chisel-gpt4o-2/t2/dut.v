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
  reg [1:0] count; // @[dut.scala 13:22]
  reg [9:0] sum; // @[dut.scala 14:20]
  wire [1:0] _count_T_1 = count + 2'h1; // @[dut.scala 24:20]
  wire [9:0] _GEN_8 = {{2'd0}, io_data_in}; // @[dut.scala 25:16]
  wire [9:0] _sum_T_1 = sum + _GEN_8; // @[dut.scala 25:16]
  wire  _T = count == 2'h3; // @[dut.scala 28:16]
  wire [9:0] _GEN_0 = count == 2'h3 ? _sum_T_1 : 10'h0; // @[dut.scala 18:15 28:25 29:19]
  assign io_valid_out = io_valid_in & _T; // @[dut.scala 19:16 22:21]
  assign io_data_out = io_valid_in ? _GEN_0 : 10'h0; // @[dut.scala 18:15 22:21]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 13:22]
      count <= 2'h0; // @[dut.scala 13:22]
    end else if (io_valid_in) begin // @[dut.scala 22:21]
      if (count == 2'h3) begin // @[dut.scala 28:25]
        count <= 2'h0; // @[dut.scala 34:13]
      end else begin
        count <= _count_T_1; // @[dut.scala 24:11]
      end
    end
    if (reset) begin // @[dut.scala 14:20]
      sum <= 10'h0; // @[dut.scala 14:20]
    end else if (io_valid_in) begin // @[dut.scala 22:21]
      if (count == 2'h3) begin // @[dut.scala 28:25]
        sum <= 10'h0; // @[dut.scala 33:11]
      end else begin
        sum <= _sum_T_1; // @[dut.scala 25:9]
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
  count = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  sum = _RAND_1[9:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
