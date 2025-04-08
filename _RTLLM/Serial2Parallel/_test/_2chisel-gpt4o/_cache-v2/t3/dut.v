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
  reg [7:0] dataReg; // @[dut.scala 13:24]
  reg [3:0] cnt; // @[dut.scala 14:20]
  reg  doutValidReg; // @[dut.scala 15:29]
  wire [7:0] _dataReg_T_1 = {dataReg[6:0],io_din_serial}; // @[Cat.scala 33:92]
  wire [3:0] _cnt_T_1 = cnt + 4'h1; // @[dut.scala 25:16]
  wire  _T = cnt == 4'h7; // @[dut.scala 28:14]
  wire  _GEN_4 = io_din_valid & _T; // @[dut.scala 21:22 35:18]
  assign io_dout_parallel = dataReg; // @[dut.scala 18:20]
  assign io_dout_valid = doutValidReg; // @[dut.scala 19:17]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 13:24]
      dataReg <= 8'h0; // @[dut.scala 13:24]
    end else if (io_din_valid) begin // @[dut.scala 21:22]
      dataReg <= _dataReg_T_1; // @[dut.scala 23:13]
    end
    if (reset) begin // @[dut.scala 14:20]
      cnt <= 4'h0; // @[dut.scala 14:20]
    end else if (io_din_valid) begin // @[dut.scala 21:22]
      if (cnt == 4'h7) begin // @[dut.scala 28:23]
        cnt <= 4'h0; // @[dut.scala 30:11]
      end else begin
        cnt <= _cnt_T_1; // @[dut.scala 25:9]
      end
    end
    if (reset) begin // @[dut.scala 15:29]
      doutValidReg <= 1'h0; // @[dut.scala 15:29]
    end else begin
      doutValidReg <= _GEN_4;
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
  dataReg = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  cnt = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  doutValidReg = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
