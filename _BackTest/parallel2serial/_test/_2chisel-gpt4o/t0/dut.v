module dut(
  input        clock,
  input        reset,
  input  [3:0] io_d,
  output       io_dout,
  output       io_valid_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] data; // @[dut.scala 12:21]
  reg [1:0] cnt; // @[dut.scala 13:21]
  wire [1:0] _cnt_T_1 = cnt + 2'h1; // @[dut.scala 26:16]
  wire [4:0] _data_T = {data, 1'h0}; // @[dut.scala 27:18]
  wire [4:0] _GEN_1 = cnt == 2'h3 ? {{1'd0}, io_d} : _data_T; // @[dut.scala 19:21 22:10 27:10]
  wire [4:0] _GEN_3 = reset ? 5'h0 : _GEN_1; // @[dut.scala 12:{21,21}]
  assign io_dout = data[3]; // @[dut.scala 17:23]
  assign io_valid_out = cnt == 2'h3; // @[dut.scala 19:12]
  always @(posedge clock) begin
    data <= _GEN_3[3:0]; // @[dut.scala 12:{21,21}]
    if (reset) begin // @[dut.scala 13:21]
      cnt <= 2'h0; // @[dut.scala 13:21]
    end else if (cnt == 2'h3) begin // @[dut.scala 19:21]
      cnt <= 2'h0; // @[dut.scala 21:9]
    end else begin
      cnt <= _cnt_T_1; // @[dut.scala 26:9]
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
  data = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  cnt = _RAND_1[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
