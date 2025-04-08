module dut(
  input        clock,
  input        reset,
  input        io_din_serial,
  input        io_din_valid,
  output [7:0] io_dout_parallel,
  output       io_dout_valid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] cnt; // @[dut.scala 13:20]
  wire [3:0] _cnt_T_1 = cnt + 4'h1; // @[dut.scala 15:16]
  wire  _T = cnt == 4'h7; // @[dut.scala 16:15]
  reg [7:0] shift_reg; // @[dut.scala 22:26]
  wire [7:0] _shift_reg_T_1 = {shift_reg[6:0],io_din_serial}; // @[Cat.scala 33:92]
  reg  dout_valid; // @[dut.scala 35:27]
  assign io_dout_parallel = _T ? shift_reg : 8'h0; // @[dut.scala 29:22 30:19 28:34]
  assign io_dout_valid = dout_valid; // @[dut.scala 41:17]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 13:20]
      cnt <= 4'h0; // @[dut.scala 13:20]
    end else if (io_din_valid) begin // @[dut.scala 14:23]
      if (cnt == 4'h7) begin // @[dut.scala 16:24]
        cnt <= 4'h0; // @[dut.scala 17:11]
      end else begin
        cnt <= _cnt_T_1; // @[dut.scala 15:9]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      shift_reg <= 8'h0; // @[dut.scala 22:26]
    end else if (io_din_valid) begin // @[dut.scala 23:23]
      shift_reg <= _shift_reg_T_1; // @[dut.scala 24:15]
    end
    if (reset) begin // @[dut.scala 35:27]
      dout_valid <= 1'h0; // @[dut.scala 35:27]
    end else begin
      dout_valid <= _T;
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
  cnt = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  shift_reg = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  dout_valid = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
