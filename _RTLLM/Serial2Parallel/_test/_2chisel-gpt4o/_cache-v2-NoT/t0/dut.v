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
  reg [3:0] cnt; // @[dut.scala 13:20]
  wire [3:0] _cnt_T_1 = cnt + 4'h1; // @[dut.scala 16:16]
  wire  _T = cnt == 4'h7; // @[dut.scala 17:14]
  reg [7:0] shift_reg; // @[dut.scala 23:26]
  wire [7:0] _shift_reg_T_1 = {shift_reg[6:0],io_din_serial}; // @[Cat.scala 33:92]
  reg [7:0] dout_parallel_reg; // @[dut.scala 29:34]
  wire  _T_2 = _T & io_din_valid; // @[dut.scala 30:20]
  reg  dout_valid_reg; // @[dut.scala 35:31]
  assign io_dout_parallel = dout_parallel_reg; // @[dut.scala 43:20]
  assign io_dout_valid = dout_valid_reg; // @[dut.scala 44:17]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 13:20]
      cnt <= 4'h0; // @[dut.scala 13:20]
    end else if (io_din_valid) begin // @[dut.scala 15:22]
      if (cnt == 4'h7) begin // @[dut.scala 17:23]
        cnt <= 4'h0; // @[dut.scala 18:11]
      end else begin
        cnt <= _cnt_T_1; // @[dut.scala 16:9]
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      shift_reg <= 8'h0; // @[dut.scala 23:26]
    end else if (io_din_valid) begin // @[dut.scala 24:22]
      shift_reg <= _shift_reg_T_1; // @[dut.scala 25:15]
    end
    if (reset) begin // @[dut.scala 29:34]
      dout_parallel_reg <= 8'h0; // @[dut.scala 29:34]
    end else if (_T & io_din_valid) begin // @[dut.scala 30:37]
      dout_parallel_reg <= shift_reg; // @[dut.scala 31:23]
    end
    if (reset) begin // @[dut.scala 35:31]
      dout_valid_reg <= 1'h0; // @[dut.scala 35:31]
    end else begin
      dout_valid_reg <= _T_2;
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
