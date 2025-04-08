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
  reg [3:0] cnt; // @[dut.scala 15:20]
  reg [7:0] shift_reg; // @[dut.scala 18:26]
  reg  dout_valid_reg; // @[dut.scala 21:31]
  wire [7:0] _shift_reg_T_1 = {shift_reg[6:0],io_din_serial}; // @[Cat.scala 33:92]
  wire [3:0] _cnt_T_1 = cnt + 4'h1; // @[dut.scala 33:16]
  wire  _T = cnt == 4'h8; // @[dut.scala 36:14]
  wire  _GEN_6 = io_din_valid & _T; // @[dut.scala 25:17 28:22]
  assign io_dout_parallel = shift_reg; // @[dut.scala 56:20]
  assign io_dout_valid = dout_valid_reg; // @[dut.scala 57:17]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:20]
      cnt <= 4'h0; // @[dut.scala 15:20]
    end else if (io_din_valid) begin // @[dut.scala 28:22]
      if (cnt == 4'h8) begin // @[dut.scala 36:23]
        cnt <= 4'h0; // @[dut.scala 42:11]
      end else begin
        cnt <= _cnt_T_1; // @[dut.scala 33:9]
      end
    end
    if (reset) begin // @[dut.scala 18:26]
      shift_reg <= 8'h0; // @[dut.scala 18:26]
    end else if (io_din_valid) begin // @[dut.scala 28:22]
      shift_reg <= _shift_reg_T_1; // @[dut.scala 30:15]
    end
    if (reset) begin // @[dut.scala 21:31]
      dout_valid_reg <= 1'h0; // @[dut.scala 21:31]
    end else begin
      dout_valid_reg <= _GEN_6;
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
  dout_valid_reg = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
