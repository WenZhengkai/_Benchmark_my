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
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
`endif // RANDOMIZE_REG_INIT
  reg  mulEnReg_0; // @[dut.scala 16:25]
  reg  mulEnReg_1; // @[dut.scala 16:25]
  reg  mulEnReg_2; // @[dut.scala 16:25]
  reg  mulEnReg_3; // @[dut.scala 16:25]
  reg  mulEnReg_4; // @[dut.scala 16:25]
  reg [7:0] mulAReg_0; // @[dut.scala 26:24]
  reg [7:0] mulAReg_1; // @[dut.scala 26:24]
  reg [7:0] mulAReg_2; // @[dut.scala 26:24]
  reg [7:0] mulAReg_3; // @[dut.scala 26:24]
  reg [7:0] mulAReg_4; // @[dut.scala 26:24]
  reg [7:0] mulBReg_0; // @[dut.scala 27:24]
  reg [7:0] mulBReg_1; // @[dut.scala 27:24]
  reg [7:0] mulBReg_2; // @[dut.scala 27:24]
  reg [7:0] mulBReg_3; // @[dut.scala 27:24]
  reg [7:0] mulBReg_4; // @[dut.scala 27:24]
  wire [7:0] _partialProducts_0_T_2 = mulBReg_4[0] ? mulAReg_4 : 8'h0; // @[dut.scala 42:30]
  wire [8:0] _partialProducts_1_T_1 = {mulAReg_4, 1'h0}; // @[dut.scala 42:89]
  wire [8:0] _partialProducts_1_T_2 = mulBReg_4[1] ? _partialProducts_1_T_1 : 9'h0; // @[dut.scala 42:30]
  wire [9:0] _partialProducts_2_T_1 = {mulAReg_4, 2'h0}; // @[dut.scala 42:89]
  wire [9:0] _partialProducts_2_T_2 = mulBReg_4[2] ? _partialProducts_2_T_1 : 10'h0; // @[dut.scala 42:30]
  wire [10:0] _partialProducts_3_T_1 = {mulAReg_4, 3'h0}; // @[dut.scala 42:89]
  wire [10:0] _partialProducts_3_T_2 = mulBReg_4[3] ? _partialProducts_3_T_1 : 11'h0; // @[dut.scala 42:30]
  wire [11:0] _partialProducts_4_T_1 = {mulAReg_4, 4'h0}; // @[dut.scala 42:89]
  wire [11:0] _partialProducts_4_T_2 = mulBReg_4[4] ? _partialProducts_4_T_1 : 12'h0; // @[dut.scala 42:30]
  wire [12:0] _partialProducts_5_T_1 = {mulAReg_4, 5'h0}; // @[dut.scala 42:89]
  wire [12:0] _partialProducts_5_T_2 = mulBReg_4[5] ? _partialProducts_5_T_1 : 13'h0; // @[dut.scala 42:30]
  wire [13:0] _partialProducts_6_T_1 = {mulAReg_4, 6'h0}; // @[dut.scala 42:89]
  wire [13:0] _partialProducts_6_T_2 = mulBReg_4[6] ? _partialProducts_6_T_1 : 14'h0; // @[dut.scala 42:30]
  wire [14:0] _partialProducts_7_T_1 = {mulAReg_4, 7'h0}; // @[dut.scala 42:89]
  wire [14:0] _partialProducts_7_T_2 = mulBReg_4[7] ? _partialProducts_7_T_1 : 15'h0; // @[dut.scala 42:30]
  reg [15:0] sumReg1; // @[dut.scala 46:24]
  reg [15:0] sumReg2; // @[dut.scala 47:24]
  reg [15:0] sumReg3; // @[dut.scala 48:24]
  wire [15:0] partialProducts_0 = {{8'd0}, _partialProducts_0_T_2}; // @[dut.scala 40:29 42:24]
  wire [15:0] partialProducts_1 = {{7'd0}, _partialProducts_1_T_2}; // @[dut.scala 40:29 42:24]
  wire [15:0] _sumReg1_T_1 = partialProducts_0 + partialProducts_1; // @[dut.scala 52:35]
  wire [15:0] partialProducts_2 = {{6'd0}, _partialProducts_2_T_2}; // @[dut.scala 40:29 42:24]
  wire [15:0] _sumReg2_T_1 = sumReg1 + partialProducts_2; // @[dut.scala 55:24]
  wire [15:0] partialProducts_3 = {{5'd0}, _partialProducts_3_T_2}; // @[dut.scala 40:29 42:24]
  wire [15:0] _sumReg2_T_3 = _sumReg2_T_1 + partialProducts_3; // @[dut.scala 55:45]
  wire [15:0] partialProducts_4 = {{4'd0}, _partialProducts_4_T_2}; // @[dut.scala 40:29 42:24]
  wire [15:0] _sumReg3_T_1 = sumReg2 + partialProducts_4; // @[dut.scala 58:24]
  wire [15:0] partialProducts_5 = {{3'd0}, _partialProducts_5_T_2}; // @[dut.scala 40:29 42:24]
  wire [15:0] _sumReg3_T_3 = _sumReg3_T_1 + partialProducts_5; // @[dut.scala 58:45]
  reg [15:0] mulOutReg; // @[dut.scala 62:26]
  wire [15:0] partialProducts_6 = {{2'd0}, _partialProducts_6_T_2}; // @[dut.scala 40:29 42:24]
  wire [15:0] _mulOutReg_T_1 = sumReg3 + partialProducts_6; // @[dut.scala 64:26]
  wire [15:0] partialProducts_7 = {{1'd0}, _partialProducts_7_T_2}; // @[dut.scala 40:29 42:24]
  wire [15:0] _mulOutReg_T_3 = _mulOutReg_T_1 + partialProducts_7; // @[dut.scala 64:47]
  assign io_mul_en_out = mulEnReg_4; // @[dut.scala 23:17]
  assign io_mul_out = io_mul_en_out ? mulOutReg : 16'h0; // @[dut.scala 68:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 16:25]
      mulEnReg_0 <= 1'h0; // @[dut.scala 16:25]
    end else begin
      mulEnReg_0 <= io_mul_en_in; // @[dut.scala 17:15]
    end
    if (reset) begin // @[dut.scala 16:25]
      mulEnReg_1 <= 1'h0; // @[dut.scala 16:25]
    end else begin
      mulEnReg_1 <= mulEnReg_0; // @[dut.scala 19:17]
    end
    if (reset) begin // @[dut.scala 16:25]
      mulEnReg_2 <= 1'h0; // @[dut.scala 16:25]
    end else begin
      mulEnReg_2 <= mulEnReg_1; // @[dut.scala 19:17]
    end
    if (reset) begin // @[dut.scala 16:25]
      mulEnReg_3 <= 1'h0; // @[dut.scala 16:25]
    end else begin
      mulEnReg_3 <= mulEnReg_2; // @[dut.scala 19:17]
    end
    if (reset) begin // @[dut.scala 16:25]
      mulEnReg_4 <= 1'h0; // @[dut.scala 16:25]
    end else begin
      mulEnReg_4 <= mulEnReg_3; // @[dut.scala 19:17]
    end
    if (reset) begin // @[dut.scala 26:24]
      mulAReg_0 <= 8'h0; // @[dut.scala 26:24]
    end else if (io_mul_en_in) begin // @[dut.scala 30:22]
      mulAReg_0 <= io_mul_a; // @[dut.scala 31:16]
    end
    if (reset) begin // @[dut.scala 26:24]
      mulAReg_1 <= 8'h0; // @[dut.scala 26:24]
    end else begin
      mulAReg_1 <= mulAReg_0; // @[dut.scala 35:16]
    end
    if (reset) begin // @[dut.scala 26:24]
      mulAReg_2 <= 8'h0; // @[dut.scala 26:24]
    end else begin
      mulAReg_2 <= mulAReg_1; // @[dut.scala 35:16]
    end
    if (reset) begin // @[dut.scala 26:24]
      mulAReg_3 <= 8'h0; // @[dut.scala 26:24]
    end else begin
      mulAReg_3 <= mulAReg_2; // @[dut.scala 35:16]
    end
    if (reset) begin // @[dut.scala 26:24]
      mulAReg_4 <= 8'h0; // @[dut.scala 26:24]
    end else begin
      mulAReg_4 <= mulAReg_3; // @[dut.scala 35:16]
    end
    if (reset) begin // @[dut.scala 27:24]
      mulBReg_0 <= 8'h0; // @[dut.scala 27:24]
    end else if (io_mul_en_in) begin // @[dut.scala 30:22]
      mulBReg_0 <= io_mul_b; // @[dut.scala 32:16]
    end
    if (reset) begin // @[dut.scala 27:24]
      mulBReg_1 <= 8'h0; // @[dut.scala 27:24]
    end else begin
      mulBReg_1 <= mulBReg_0; // @[dut.scala 36:16]
    end
    if (reset) begin // @[dut.scala 27:24]
      mulBReg_2 <= 8'h0; // @[dut.scala 27:24]
    end else begin
      mulBReg_2 <= mulBReg_1; // @[dut.scala 36:16]
    end
    if (reset) begin // @[dut.scala 27:24]
      mulBReg_3 <= 8'h0; // @[dut.scala 27:24]
    end else begin
      mulBReg_3 <= mulBReg_2; // @[dut.scala 36:16]
    end
    if (reset) begin // @[dut.scala 27:24]
      mulBReg_4 <= 8'h0; // @[dut.scala 27:24]
    end else begin
      mulBReg_4 <= mulBReg_3; // @[dut.scala 36:16]
    end
    if (reset) begin // @[dut.scala 46:24]
      sumReg1 <= 16'h0; // @[dut.scala 46:24]
    end else if (mulEnReg_1) begin // @[dut.scala 51:21]
      sumReg1 <= _sumReg1_T_1; // @[dut.scala 52:13]
    end
    if (reset) begin // @[dut.scala 47:24]
      sumReg2 <= 16'h0; // @[dut.scala 47:24]
    end else if (mulEnReg_2) begin // @[dut.scala 54:21]
      sumReg2 <= _sumReg2_T_3; // @[dut.scala 55:13]
    end
    if (reset) begin // @[dut.scala 48:24]
      sumReg3 <= 16'h0; // @[dut.scala 48:24]
    end else if (mulEnReg_3) begin // @[dut.scala 57:21]
      sumReg3 <= _sumReg3_T_3; // @[dut.scala 58:13]
    end
    if (reset) begin // @[dut.scala 62:26]
      mulOutReg <= 16'h0; // @[dut.scala 62:26]
    end else if (mulEnReg_4) begin // @[dut.scala 63:21]
      mulOutReg <= _mulOutReg_T_3; // @[dut.scala 64:15]
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
  mulEnReg_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  mulEnReg_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mulEnReg_2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  mulEnReg_3 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  mulEnReg_4 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  mulAReg_0 = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  mulAReg_1 = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  mulAReg_2 = _RAND_7[7:0];
  _RAND_8 = {1{`RANDOM}};
  mulAReg_3 = _RAND_8[7:0];
  _RAND_9 = {1{`RANDOM}};
  mulAReg_4 = _RAND_9[7:0];
  _RAND_10 = {1{`RANDOM}};
  mulBReg_0 = _RAND_10[7:0];
  _RAND_11 = {1{`RANDOM}};
  mulBReg_1 = _RAND_11[7:0];
  _RAND_12 = {1{`RANDOM}};
  mulBReg_2 = _RAND_12[7:0];
  _RAND_13 = {1{`RANDOM}};
  mulBReg_3 = _RAND_13[7:0];
  _RAND_14 = {1{`RANDOM}};
  mulBReg_4 = _RAND_14[7:0];
  _RAND_15 = {1{`RANDOM}};
  sumReg1 = _RAND_15[15:0];
  _RAND_16 = {1{`RANDOM}};
  sumReg2 = _RAND_16[15:0];
  _RAND_17 = {1{`RANDOM}};
  sumReg3 = _RAND_17[15:0];
  _RAND_18 = {1{`RANDOM}};
  mulOutReg = _RAND_18[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
