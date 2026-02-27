module dut(
  input        clock,
  input        reset,
  input  [3:0] io_d,
  output       io_valid_out,
  output       io_dout
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] data; // @[dut.scala 12:21]
  reg [1:0] cnt; // @[dut.scala 13:20]
  reg  valid; // @[dut.scala 14:22]
  wire [1:0] _cnt_T_1 = cnt + 2'h1; // @[dut.scala 22:16]
  wire [3:0] _data_T_2 = {data[2:0],data[3]}; // @[Cat.scala 33:92]
  assign io_valid_out = valid; // @[dut.scala 28:16]
  assign io_dout = data[3]; // @[dut.scala 29:18]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 12:21]
      data <= 4'h0; // @[dut.scala 12:21]
    end else if (cnt == 2'h3) begin // @[dut.scala 17:21]
      data <= io_d; // @[dut.scala 19:10]
    end else begin
      data <= _data_T_2; // @[dut.scala 23:10]
    end
    if (reset) begin // @[dut.scala 13:20]
      cnt <= 2'h0; // @[dut.scala 13:20]
    end else if (cnt == 2'h3) begin // @[dut.scala 17:21]
      cnt <= 2'h0; // @[dut.scala 18:9]
    end else begin
      cnt <= _cnt_T_1; // @[dut.scala 22:9]
    end
    if (reset) begin // @[dut.scala 14:22]
      valid <= 1'h0; // @[dut.scala 14:22]
    end else if (cnt == 2'h3) begin // @[dut.scala 17:21]
      valid <= 1'h0; // @[dut.scala 20:11]
    end else begin
      valid <= 1'h1; // @[dut.scala 24:11]
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
  _RAND_2 = {1{`RANDOM}};
  valid = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
