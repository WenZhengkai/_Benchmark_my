module dut(
  input         clock,
  input         reset,
  input         io_i_en,
  input  [63:0] io_adda,
  input  [63:0] io_addb,
  output [64:0] io_result,
  output        io_o_en
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
  reg [16:0] sumStage1; // @[dut.scala 14:26]
  reg [16:0] sumStage2; // @[dut.scala 15:26]
  reg [16:0] sumStage3; // @[dut.scala 16:26]
  reg [16:0] sumStage4; // @[dut.scala 17:26]
  reg  enStage1; // @[dut.scala 20:25]
  reg  enStage2; // @[dut.scala 21:25]
  reg  enStage3; // @[dut.scala 22:25]
  reg  enStage4; // @[dut.scala 23:25]
  wire [16:0] add16_0 = io_adda[15:0] + io_addb[15:0]; // @[dut.scala 27:34]
  wire [16:0] _add16_1_T_2 = io_adda[31:16] + io_addb[31:16]; // @[dut.scala 34:35]
  wire [16:0] _GEN_8 = {{16'd0}, sumStage1[16]}; // @[dut.scala 34:54]
  wire [16:0] add16_1 = _add16_1_T_2 + _GEN_8; // @[dut.scala 34:54]
  wire [16:0] _add16_2_T_2 = io_adda[47:32] + io_addb[47:32]; // @[dut.scala 41:35]
  wire [16:0] _GEN_9 = {{16'd0}, sumStage2[16]}; // @[dut.scala 41:54]
  wire [16:0] add16_2 = _add16_2_T_2 + _GEN_9; // @[dut.scala 41:54]
  wire [16:0] _add16_3_T_2 = io_adda[63:48] + io_addb[63:48]; // @[dut.scala 48:35]
  wire [16:0] _GEN_10 = {{16'd0}, sumStage3[16]}; // @[dut.scala 48:54]
  wire [16:0] add16_3 = _add16_3_T_2 + _GEN_10; // @[dut.scala 48:54]
  wire [31:0] io_result_lo = {sumStage2[15:0],sumStage1[15:0]}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {sumStage4[16],sumStage4[15:0],sumStage3[15:0]}; // @[Cat.scala 33:92]
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = enStage4; // @[dut.scala 54:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:26]
      sumStage1 <= 17'h0; // @[dut.scala 14:26]
    end else if (io_i_en) begin // @[dut.scala 26:17]
      sumStage1 <= add16_0; // @[dut.scala 28:15]
    end
    if (reset) begin // @[dut.scala 15:26]
      sumStage2 <= 17'h0; // @[dut.scala 15:26]
    end else if (enStage1) begin // @[dut.scala 33:18]
      sumStage2 <= add16_1; // @[dut.scala 35:15]
    end
    if (reset) begin // @[dut.scala 16:26]
      sumStage3 <= 17'h0; // @[dut.scala 16:26]
    end else if (enStage2) begin // @[dut.scala 40:18]
      sumStage3 <= add16_2; // @[dut.scala 42:15]
    end
    if (reset) begin // @[dut.scala 17:26]
      sumStage4 <= 17'h0; // @[dut.scala 17:26]
    end else if (enStage3) begin // @[dut.scala 47:18]
      sumStage4 <= add16_3; // @[dut.scala 49:15]
    end
    if (reset) begin // @[dut.scala 20:25]
      enStage1 <= 1'h0; // @[dut.scala 20:25]
    end else if (io_i_en) begin // @[dut.scala 26:17]
      enStage1 <= io_i_en; // @[dut.scala 29:14]
    end
    if (reset) begin // @[dut.scala 21:25]
      enStage2 <= 1'h0; // @[dut.scala 21:25]
    end else if (enStage1) begin // @[dut.scala 33:18]
      enStage2 <= enStage1; // @[dut.scala 36:14]
    end
    if (reset) begin // @[dut.scala 22:25]
      enStage3 <= 1'h0; // @[dut.scala 22:25]
    end else if (enStage2) begin // @[dut.scala 40:18]
      enStage3 <= enStage2; // @[dut.scala 43:14]
    end
    if (reset) begin // @[dut.scala 23:25]
      enStage4 <= 1'h0; // @[dut.scala 23:25]
    end else if (enStage3) begin // @[dut.scala 47:18]
      enStage4 <= enStage3; // @[dut.scala 50:14]
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
  sumStage1 = _RAND_0[16:0];
  _RAND_1 = {1{`RANDOM}};
  sumStage2 = _RAND_1[16:0];
  _RAND_2 = {1{`RANDOM}};
  sumStage3 = _RAND_2[16:0];
  _RAND_3 = {1{`RANDOM}};
  sumStage4 = _RAND_3[16:0];
  _RAND_4 = {1{`RANDOM}};
  enStage1 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  enStage2 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  enStage3 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  enStage4 = _RAND_7[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
