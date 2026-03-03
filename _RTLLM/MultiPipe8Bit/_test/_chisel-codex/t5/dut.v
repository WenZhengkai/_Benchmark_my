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
`endif // RANDOMIZE_REG_INIT
  reg [4:0] mulEnOutReg; // @[dut.scala 14:28]
  wire [4:0] _mulEnOutReg_T_1 = {mulEnOutReg[3:0],io_mul_en_in}; // @[Cat.scala 33:92]
  reg [7:0] mulAReg; // @[dut.scala 19:24]
  reg [7:0] mulBReg; // @[dut.scala 20:24]
  wire [15:0] aExt = {8'h0,mulAReg}; // @[Cat.scala 33:92]
  wire [15:0] temp_0 = mulBReg[0] ? aExt : 16'h0; // @[dut.scala 30:19]
  wire [16:0] _temp_1_T_1 = {aExt, 1'h0}; // @[dut.scala 30:38]
  wire [15:0] temp_1 = mulBReg[1] ? _temp_1_T_1[15:0] : 16'h0; // @[dut.scala 30:19]
  wire [17:0] _temp_2_T_1 = {aExt, 2'h0}; // @[dut.scala 30:38]
  wire [15:0] temp_2 = mulBReg[2] ? _temp_2_T_1[15:0] : 16'h0; // @[dut.scala 30:19]
  wire [18:0] _temp_3_T_1 = {aExt, 3'h0}; // @[dut.scala 30:38]
  wire [15:0] temp_3 = mulBReg[3] ? _temp_3_T_1[15:0] : 16'h0; // @[dut.scala 30:19]
  wire [19:0] _temp_4_T_1 = {aExt, 4'h0}; // @[dut.scala 30:38]
  wire [15:0] temp_4 = mulBReg[4] ? _temp_4_T_1[15:0] : 16'h0; // @[dut.scala 30:19]
  wire [20:0] _temp_5_T_1 = {aExt, 5'h0}; // @[dut.scala 30:38]
  wire [15:0] temp_5 = mulBReg[5] ? _temp_5_T_1[15:0] : 16'h0; // @[dut.scala 30:19]
  wire [21:0] _temp_6_T_1 = {aExt, 6'h0}; // @[dut.scala 30:38]
  wire [15:0] temp_6 = mulBReg[6] ? _temp_6_T_1[15:0] : 16'h0; // @[dut.scala 30:19]
  wire [22:0] _temp_7_T_1 = {aExt, 7'h0}; // @[dut.scala 30:38]
  wire [15:0] temp_7 = mulBReg[7] ? _temp_7_T_1[15:0] : 16'h0; // @[dut.scala 30:19]
  reg [15:0] sumL_0; // @[dut.scala 34:21]
  reg [15:0] sumL_1; // @[dut.scala 34:21]
  reg [15:0] sumL_2; // @[dut.scala 34:21]
  reg [15:0] sumL_3; // @[dut.scala 34:21]
  reg [15:0] sumM_0; // @[dut.scala 35:21]
  reg [15:0] sumM_1; // @[dut.scala 35:21]
  reg [15:0] sumH; // @[dut.scala 36:21]
  reg [15:0] mulOutReg; // @[dut.scala 37:26]
  wire [15:0] _sumL_0_T_1 = temp_0 + temp_1; // @[dut.scala 40:24]
  wire [15:0] _sumL_1_T_1 = temp_2 + temp_3; // @[dut.scala 41:24]
  wire [15:0] _sumL_2_T_1 = temp_4 + temp_5; // @[dut.scala 42:24]
  wire [15:0] _sumL_3_T_1 = temp_6 + temp_7; // @[dut.scala 43:24]
  wire [15:0] _sumM_0_T_1 = sumL_0 + sumL_1; // @[dut.scala 47:24]
  wire [15:0] _sumM_1_T_1 = sumL_2 + sumL_3; // @[dut.scala 48:24]
  wire [15:0] _sumH_T_1 = sumM_0 + sumM_1; // @[dut.scala 52:21]
  assign io_mul_en_out = mulEnOutReg[4]; // @[dut.scala 16:31]
  assign io_mul_out = io_mul_en_out ? mulOutReg : 16'h0; // @[dut.scala 60:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:28]
      mulEnOutReg <= 5'h0; // @[dut.scala 14:28]
    end else begin
      mulEnOutReg <= _mulEnOutReg_T_1; // @[dut.scala 15:15]
    end
    if (reset) begin // @[dut.scala 19:24]
      mulAReg <= 8'h0; // @[dut.scala 19:24]
    end else if (io_mul_en_in) begin // @[dut.scala 21:22]
      mulAReg <= io_mul_a; // @[dut.scala 22:13]
    end
    if (reset) begin // @[dut.scala 20:24]
      mulBReg <= 8'h0; // @[dut.scala 20:24]
    end else if (io_mul_en_in) begin // @[dut.scala 21:22]
      mulBReg <= io_mul_b; // @[dut.scala 23:13]
    end
    if (reset) begin // @[dut.scala 34:21]
      sumL_0 <= 16'h0; // @[dut.scala 34:21]
    end else if (mulEnOutReg[0]) begin // @[dut.scala 39:24]
      sumL_0 <= _sumL_0_T_1; // @[dut.scala 40:13]
    end
    if (reset) begin // @[dut.scala 34:21]
      sumL_1 <= 16'h0; // @[dut.scala 34:21]
    end else if (mulEnOutReg[0]) begin // @[dut.scala 39:24]
      sumL_1 <= _sumL_1_T_1; // @[dut.scala 41:13]
    end
    if (reset) begin // @[dut.scala 34:21]
      sumL_2 <= 16'h0; // @[dut.scala 34:21]
    end else if (mulEnOutReg[0]) begin // @[dut.scala 39:24]
      sumL_2 <= _sumL_2_T_1; // @[dut.scala 42:13]
    end
    if (reset) begin // @[dut.scala 34:21]
      sumL_3 <= 16'h0; // @[dut.scala 34:21]
    end else if (mulEnOutReg[0]) begin // @[dut.scala 39:24]
      sumL_3 <= _sumL_3_T_1; // @[dut.scala 43:13]
    end
    if (reset) begin // @[dut.scala 35:21]
      sumM_0 <= 16'h0; // @[dut.scala 35:21]
    end else if (mulEnOutReg[1]) begin // @[dut.scala 46:24]
      sumM_0 <= _sumM_0_T_1; // @[dut.scala 47:13]
    end
    if (reset) begin // @[dut.scala 35:21]
      sumM_1 <= 16'h0; // @[dut.scala 35:21]
    end else if (mulEnOutReg[1]) begin // @[dut.scala 46:24]
      sumM_1 <= _sumM_1_T_1; // @[dut.scala 48:13]
    end
    if (reset) begin // @[dut.scala 36:21]
      sumH <= 16'h0; // @[dut.scala 36:21]
    end else if (mulEnOutReg[2]) begin // @[dut.scala 51:24]
      sumH <= _sumH_T_1; // @[dut.scala 52:10]
    end
    if (reset) begin // @[dut.scala 37:26]
      mulOutReg <= 16'h0; // @[dut.scala 37:26]
    end else if (mulEnOutReg[3]) begin // @[dut.scala 55:24]
      mulOutReg <= sumH; // @[dut.scala 56:15]
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
  mulEnOutReg = _RAND_0[4:0];
  _RAND_1 = {1{`RANDOM}};
  mulAReg = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  mulBReg = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  sumL_0 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  sumL_1 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  sumL_2 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  sumL_3 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  sumM_0 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  sumM_1 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  sumH = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  mulOutReg = _RAND_10[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
