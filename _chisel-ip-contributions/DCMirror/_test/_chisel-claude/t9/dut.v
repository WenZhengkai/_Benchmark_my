module dut(
  input        clock,
  input        reset,
  input  [4:0] io_dst,
  output       io_c_ready,
  input        io_c_valid,
  input  [7:0] io_c_bits,
  input        io_p_0_ready,
  output       io_p_0_valid,
  output [7:0] io_p_0_bits,
  input        io_p_1_ready,
  output       io_p_1_valid,
  output [7:0] io_p_1_bits,
  input        io_p_2_ready,
  output       io_p_2_valid,
  output [7:0] io_p_2_bits,
  input        io_p_3_ready,
  output       io_p_3_valid,
  output [7:0] io_p_3_bits,
  input        io_p_4_ready,
  output       io_p_4_valid,
  output [7:0] io_p_4_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] pData; // @[dut.scala 12:22]
  reg [4:0] pValid; // @[dut.scala 15:23]
  wire [4:0] pReady = {io_p_4_ready,io_p_3_ready,io_p_2_ready,io_p_1_ready,io_p_0_ready}; // @[Cat.scala 33:92]
  wire [4:0] _nxtAccept_T_1 = pValid & pReady; // @[dut.scala 21:48]
  wire  nxtAccept = pValid == 5'h0 | _nxtAccept_T_1 == pValid; // @[dut.scala 21:36]
  wire [4:0] _pValid_T = ~pReady; // @[dut.scala 32:24]
  wire [4:0] _pValid_T_1 = pValid & _pValid_T; // @[dut.scala 32:22]
  assign io_c_ready = pValid == 5'h0 | _nxtAccept_T_1 == pValid; // @[dut.scala 21:36]
  assign io_p_0_valid = pValid[0]; // @[dut.scala 40:28]
  assign io_p_0_bits = pData; // @[dut.scala 41:18]
  assign io_p_1_valid = pValid[1]; // @[dut.scala 40:28]
  assign io_p_1_bits = pData; // @[dut.scala 41:18]
  assign io_p_2_valid = pValid[2]; // @[dut.scala 40:28]
  assign io_p_2_bits = pData; // @[dut.scala 41:18]
  assign io_p_3_valid = pValid[3]; // @[dut.scala 40:28]
  assign io_p_3_bits = pData; // @[dut.scala 41:18]
  assign io_p_4_valid = pValid[4]; // @[dut.scala 40:28]
  assign io_p_4_bits = pData; // @[dut.scala 41:18]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 12:22]
      pData <= 8'h0; // @[dut.scala 12:22]
    end else if (nxtAccept) begin // @[dut.scala 24:19]
      pData <= io_c_bits; // @[dut.scala 25:11]
    end
    if (reset) begin // @[dut.scala 15:23]
      pValid <= 5'h0; // @[dut.scala 15:23]
    end else if (nxtAccept) begin // @[dut.scala 24:19]
      if (io_c_valid) begin // @[dut.scala 26:22]
        pValid <= io_dst; // @[dut.scala 27:14]
      end else begin
        pValid <= 5'h0; // @[dut.scala 29:14]
      end
    end else begin
      pValid <= _pValid_T_1; // @[dut.scala 32:12]
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
  pData = _RAND_0[7:0];
  _RAND_1 = {1{`RANDOM}};
  pValid = _RAND_1[4:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
