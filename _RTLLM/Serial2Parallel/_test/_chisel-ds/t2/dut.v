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
`endif // RANDOMIZE_REG_INIT
  reg [3:0] cnt; // @[dut.scala 13:20]
  reg [7:0] shiftReg; // @[dut.scala 14:25]
  wire [8:0] _shiftReg_T = {shiftReg, 1'h0}; // @[dut.scala 23:27]
  wire [8:0] _GEN_7 = {{8'd0}, io_din_serial}; // @[dut.scala 23:33]
  wire [8:0] _shiftReg_T_1 = _shiftReg_T | _GEN_7; // @[dut.scala 23:33]
  wire [3:0] _cnt_T_1 = cnt + 4'h1; // @[dut.scala 24:16]
  wire  _T = cnt == 4'h7; // @[dut.scala 27:14]
  wire [7:0] _GEN_0 = cnt == 4'h7 ? shiftReg : 8'h0; // @[dut.scala 17:20 27:23 28:24]
  wire [8:0] _GEN_3 = io_din_valid ? _shiftReg_T_1 : {{1'd0}, shiftReg}; // @[dut.scala 21:22 23:14 14:25]
  wire [8:0] _GEN_8 = reset ? 9'h0 : _GEN_3; // @[dut.scala 14:{25,25}]
  assign io_dout_parallel = io_din_valid ? _GEN_0 : 8'h0; // @[dut.scala 17:20 21:22]
  assign io_dout_valid = io_din_valid & _T; // @[dut.scala 18:17 21:22]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 13:20]
      cnt <= 4'h0; // @[dut.scala 13:20]
    end else if (io_din_valid) begin // @[dut.scala 21:22]
      if (cnt == 4'h7) begin // @[dut.scala 27:23]
        cnt <= 4'h0; // @[dut.scala 30:11]
      end else begin
        cnt <= _cnt_T_1; // @[dut.scala 24:9]
      end
    end
    shiftReg <= _GEN_8[7:0]; // @[dut.scala 14:{25,25}]
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
  shiftReg = _RAND_1[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
