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
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] cnt_reg; // @[dut.scala 25:24]
  wire  _T = cnt_reg == 4'h8; // @[dut.scala 29:18]
  wire [3:0] _cnt_reg_T_1 = cnt_reg + 4'h1; // @[dut.scala 32:26]
  reg [7:0] shift_reg; // @[dut.scala 38:26]
  wire [7:0] _shift_reg_T_1 = {shift_reg[6:0],io_din_serial}; // @[Cat.scala 33:92]
  reg [7:0] dout_parallel_reg; // @[dut.scala 47:34]
  wire  _T_2 = io_din_valid & _T; // @[dut.scala 50:21]
  reg  dout_valid_reg; // @[dut.scala 59:31]
  assign io_dout_parallel = dout_parallel_reg; // @[dut.scala 55:20]
  assign io_dout_valid = dout_valid_reg; // @[dut.scala 65:17]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 25:24]
      cnt_reg <= 4'h0; // @[dut.scala 25:24]
    end else if (io_din_valid) begin // @[dut.scala 28:22]
      if (cnt_reg == 4'h8) begin // @[dut.scala 29:27]
        cnt_reg <= 4'h0; // @[dut.scala 30:15]
      end else begin
        cnt_reg <= _cnt_reg_T_1; // @[dut.scala 32:15]
      end
    end
    if (reset) begin // @[dut.scala 38:26]
      shift_reg <= 8'h0; // @[dut.scala 38:26]
    end else if (io_din_valid) begin // @[dut.scala 40:22]
      shift_reg <= _shift_reg_T_1; // @[dut.scala 42:15]
    end
    if (reset) begin // @[dut.scala 47:34]
      dout_parallel_reg <= 8'h0; // @[dut.scala 47:34]
    end else if (io_din_valid & _T) begin // @[dut.scala 50:41]
      dout_parallel_reg <= shift_reg; // @[dut.scala 51:23]
    end
    if (reset) begin // @[dut.scala 59:31]
      dout_valid_reg <= 1'h0; // @[dut.scala 59:31]
    end else begin
      dout_valid_reg <= _T_2; // @[dut.scala 62:18]
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
  cnt_reg = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  shift_reg = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  dout_parallel_reg = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  dout_valid_reg = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
