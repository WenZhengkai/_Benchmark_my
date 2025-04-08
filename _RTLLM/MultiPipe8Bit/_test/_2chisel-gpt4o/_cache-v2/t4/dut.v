module dut(
  input         clock,
  input         reset,
  input         io_mul_en_in,
  input  [7:0]  io_mul_a,
  input  [7:0]  io_mul_b,
  output        io_mul_en_out,
  output [15:0] io_mul_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg [4:0] mul_en_out_reg; // @[dut.scala 14:31]
  wire [7:0] _temp_0_T_2 = io_mul_b[0] ? io_mul_a : 8'h0; // @[dut.scala 23:19]
  wire [8:0] _temp_1_T_1 = {io_mul_a, 1'h0}; // @[dut.scala 23:42]
  wire [8:0] _temp_1_T_2 = io_mul_b[1] ? _temp_1_T_1 : 9'h0; // @[dut.scala 23:19]
  wire [9:0] _temp_2_T_1 = {io_mul_a, 2'h0}; // @[dut.scala 23:42]
  wire [9:0] _temp_2_T_2 = io_mul_b[2] ? _temp_2_T_1 : 10'h0; // @[dut.scala 23:19]
  wire [10:0] _temp_3_T_1 = {io_mul_a, 3'h0}; // @[dut.scala 23:42]
  wire [10:0] _temp_3_T_2 = io_mul_b[3] ? _temp_3_T_1 : 11'h0; // @[dut.scala 23:19]
  wire [11:0] _temp_4_T_1 = {io_mul_a, 4'h0}; // @[dut.scala 23:42]
  wire [11:0] _temp_4_T_2 = io_mul_b[4] ? _temp_4_T_1 : 12'h0; // @[dut.scala 23:19]
  wire [12:0] _temp_5_T_1 = {io_mul_a, 5'h0}; // @[dut.scala 23:42]
  wire [12:0] _temp_5_T_2 = io_mul_b[5] ? _temp_5_T_1 : 13'h0; // @[dut.scala 23:19]
  wire [13:0] _temp_6_T_1 = {io_mul_a, 6'h0}; // @[dut.scala 23:42]
  wire [13:0] _temp_6_T_2 = io_mul_b[6] ? _temp_6_T_1 : 14'h0; // @[dut.scala 23:19]
  wire [14:0] _temp_7_T_1 = {io_mul_a, 7'h0}; // @[dut.scala 23:42]
  wire [14:0] _temp_7_T_2 = io_mul_b[7] ? _temp_7_T_1 : 15'h0; // @[dut.scala 23:19]
  wire [15:0] temp_0 = {{8'd0}, _temp_0_T_2}; // @[dut.scala 19:18 23:13]
  wire [15:0] temp_1 = {{7'd0}, _temp_1_T_2}; // @[dut.scala 19:18 23:13]
  wire [15:0] _sumReg1_T_1 = temp_0 + temp_1; // @[dut.scala 27:33]
  reg [15:0] sumReg1; // @[dut.scala 27:24]
  wire [15:0] temp_2 = {{6'd0}, _temp_2_T_2}; // @[dut.scala 19:18 23:13]
  wire [15:0] temp_3 = {{5'd0}, _temp_3_T_2}; // @[dut.scala 19:18 23:13]
  wire [15:0] _sumReg2_T_1 = temp_2 + temp_3; // @[dut.scala 28:33]
  reg [15:0] sumReg2; // @[dut.scala 28:24]
  wire [15:0] temp_4 = {{4'd0}, _temp_4_T_2}; // @[dut.scala 19:18 23:13]
  wire [15:0] temp_5 = {{3'd0}, _temp_5_T_2}; // @[dut.scala 19:18 23:13]
  wire [15:0] _sumReg3_T_1 = temp_4 + temp_5; // @[dut.scala 29:33]
  reg [15:0] sumReg3; // @[dut.scala 29:24]
  wire [15:0] temp_6 = {{2'd0}, _temp_6_T_2}; // @[dut.scala 19:18 23:13]
  wire [15:0] temp_7 = {{1'd0}, _temp_7_T_2}; // @[dut.scala 19:18 23:13]
  wire [15:0] _sumReg4_T_1 = temp_6 + temp_7; // @[dut.scala 30:33]
  reg [15:0] sumReg4; // @[dut.scala 30:24]
  wire [15:0] _partialSum1_T_1 = sumReg1 + sumReg2; // @[dut.scala 33:37]
  reg [15:0] partialSum1; // @[dut.scala 33:28]
  wire [15:0] _partialSum2_T_1 = sumReg3 + sumReg4; // @[dut.scala 34:37]
  reg [15:0] partialSum2; // @[dut.scala 34:28]
  wire [15:0] _mul_out_reg_T_1 = partialSum1 + partialSum2; // @[dut.scala 35:41]
  reg [15:0] mul_out_reg; // @[dut.scala 35:28]
  wire [4:0] _mul_en_out_reg_T_1 = {mul_en_out_reg[3:0],io_mul_en_in}; // @[Cat.scala 33:92]
  assign io_mul_en_out = mul_en_out_reg[4]; // @[dut.scala 41:34]
  assign io_mul_out = io_mul_en_out ? mul_out_reg : 16'h0; // @[dut.scala 42:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:31]
      mul_en_out_reg <= 5'h0; // @[dut.scala 14:31]
    end else begin
      mul_en_out_reg <= _mul_en_out_reg_T_1; // @[dut.scala 38:18]
    end
    if (reset) begin // @[dut.scala 27:24]
      sumReg1 <= 16'h0; // @[dut.scala 27:24]
    end else begin
      sumReg1 <= _sumReg1_T_1; // @[dut.scala 27:24]
    end
    if (reset) begin // @[dut.scala 28:24]
      sumReg2 <= 16'h0; // @[dut.scala 28:24]
    end else begin
      sumReg2 <= _sumReg2_T_1; // @[dut.scala 28:24]
    end
    if (reset) begin // @[dut.scala 29:24]
      sumReg3 <= 16'h0; // @[dut.scala 29:24]
    end else begin
      sumReg3 <= _sumReg3_T_1; // @[dut.scala 29:24]
    end
    if (reset) begin // @[dut.scala 30:24]
      sumReg4 <= 16'h0; // @[dut.scala 30:24]
    end else begin
      sumReg4 <= _sumReg4_T_1; // @[dut.scala 30:24]
    end
    if (reset) begin // @[dut.scala 33:28]
      partialSum1 <= 16'h0; // @[dut.scala 33:28]
    end else begin
      partialSum1 <= _partialSum1_T_1; // @[dut.scala 33:28]
    end
    if (reset) begin // @[dut.scala 34:28]
      partialSum2 <= 16'h0; // @[dut.scala 34:28]
    end else begin
      partialSum2 <= _partialSum2_T_1; // @[dut.scala 34:28]
    end
    if (reset) begin // @[dut.scala 35:28]
      mul_out_reg <= 16'h0; // @[dut.scala 35:28]
    end else begin
      mul_out_reg <= _mul_out_reg_T_1; // @[dut.scala 35:28]
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
  mul_en_out_reg = _RAND_0[4:0];
  _RAND_1 = {1{`RANDOM}};
  sumReg1 = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  sumReg2 = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  sumReg3 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  sumReg4 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  partialSum1 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  partialSum2 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  mul_out_reg = _RAND_7[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
