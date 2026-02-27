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
  reg [9:0] sum; // @[dut.scala 13:20]
  reg [2:0] count; // @[dut.scala 14:22]
  wire [9:0] _GEN_8 = {{2'd0}, io_data_in}; // @[dut.scala 22:16]
  wire [9:0] _sum_T_1 = sum + _GEN_8; // @[dut.scala 22:16]
  wire [2:0] _count_T_1 = count + 3'h1; // @[dut.scala 23:20]
  wire  _T = count == 3'h3; // @[dut.scala 26:16]
  wire [9:0] _GEN_0 = count == 3'h3 ? _sum_T_1 : 10'h0; // @[dut.scala 17:15 26:25 27:19]
  assign io_valid_out = io_valid_in & _T; // @[dut.scala 18:16 20:21]
  assign io_data_out = io_valid_in ? _GEN_0 : 10'h0; // @[dut.scala 17:15 20:21]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 13:20]
      sum <= 10'h0; // @[dut.scala 13:20]
    end else if (io_valid_in) begin // @[dut.scala 20:21]
      if (count == 3'h3) begin // @[dut.scala 26:25]
        sum <= 10'h0; // @[dut.scala 29:11]
      end else begin
        sum <= _sum_T_1; // @[dut.scala 22:9]
      end
    end
    if (reset) begin // @[dut.scala 14:22]
      count <= 3'h0; // @[dut.scala 14:22]
    end else if (io_valid_in) begin // @[dut.scala 20:21]
      if (count == 3'h3) begin // @[dut.scala 26:25]
        count <= 3'h0; // @[dut.scala 30:13]
      end else begin
        count <= _count_T_1; // @[dut.scala 23:11]
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
  sum = _RAND_0[9:0];
  _RAND_1 = {1{`RANDOM}};
  count = _RAND_1[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
