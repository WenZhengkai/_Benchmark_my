module dut(
  input         clock,
  input         reset,
  output        io_input_ready,
  input         io_input_valid,
  input  [3:0]  io_input_bits,
  input  [2:0]  io_num_0,
  input  [2:0]  io_num_1,
  input  [2:0]  io_num_2,
  input  [2:0]  io_num_3,
  input  [2:0]  io_den_0,
  input  [2:0]  io_den_1,
  input         io_output_ready,
  output        io_output_valid,
  output [10:0] io_output_bits
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
`endif // RANDOMIZE_REG_INIT
  reg [2:0] state; // @[dut.scala 25:22]
  reg [3:0] inputMem_0; // @[dut.scala 28:21]
  reg [3:0] inputMem_1; // @[dut.scala 28:21]
  reg [3:0] inputMem_2; // @[dut.scala 28:21]
  reg [3:0] inputMem_3; // @[dut.scala 28:21]
  reg [10:0] outputMem_0; // @[dut.scala 29:22]
  reg [10:0] outputMem_1; // @[dut.scala 29:22]
  reg [1:0] coefNum; // @[dut.scala 32:24]
  reg [11:0] inputSum; // @[dut.scala 35:25]
  reg [11:0] outputSum; // @[dut.scala 36:26]
  wire [3:0] _GEN_9 = 2'h1 == coefNum ? $signed(inputMem_1) : $signed(inputMem_0); // @[dut.scala 70:{14,14}]
  wire [3:0] _GEN_10 = 2'h2 == coefNum ? $signed(inputMem_2) : $signed(_GEN_9); // @[dut.scala 70:{14,14}]
  wire [3:0] _GEN_11 = 2'h3 == coefNum ? $signed(inputMem_3) : $signed(_GEN_10); // @[dut.scala 70:{14,14}]
  wire [10:0] _GEN_20 = coefNum[0] ? $signed(outputMem_1) : $signed(outputMem_0); // @[dut.scala 83:{16,16}]
  wire [10:0] _GEN_23 = coefNum < 2'h2 ? $signed(_GEN_20) : $signed(11'sh0); // @[dut.scala 44:10 82:40 83:16]
  wire [10:0] _GEN_36 = 3'h2 == state ? $signed(_GEN_23) : $signed(11'sh0); // @[dut.scala 44:10 54:17]
  wire [10:0] _GEN_45 = 3'h1 == state ? $signed({{7{_GEN_11[3]}},_GEN_11}) : $signed(_GEN_36); // @[dut.scala 54:17 70:14]
  wire [10:0] multIn = 3'h0 == state ? $signed(11'sh0) : $signed(_GEN_45); // @[dut.scala 44:10 54:17]
  wire [2:0] _GEN_13 = 2'h1 == coefNum ? $signed(io_num_1) : $signed(io_num_0); // @[dut.scala 71:{16,16}]
  wire [2:0] _GEN_14 = 2'h2 == coefNum ? $signed(io_num_2) : $signed(_GEN_13); // @[dut.scala 71:{16,16}]
  wire [2:0] _GEN_15 = 2'h3 == coefNum ? $signed(io_num_3) : $signed(_GEN_14); // @[dut.scala 71:{16,16}]
  wire [2:0] _GEN_22 = coefNum[0] ? $signed(io_den_1) : $signed(io_den_0); // @[dut.scala 84:{18,18}]
  wire [2:0] _GEN_24 = coefNum < 2'h2 ? $signed(_GEN_22) : $signed(3'sh0); // @[dut.scala 45:12 82:40 84:18]
  wire [2:0] _GEN_37 = 3'h2 == state ? $signed(_GEN_24) : $signed(3'sh0); // @[dut.scala 45:12 54:17]
  wire [2:0] _GEN_46 = 3'h1 == state ? $signed(_GEN_15) : $signed(_GEN_37); // @[dut.scala 54:17 71:16]
  wire [2:0] multCoef = 3'h0 == state ? $signed(3'sh0) : $signed(_GEN_46); // @[dut.scala 45:12 54:17]
  wire [13:0] multOut = $signed(multIn) * $signed(multCoef); // @[dut.scala 46:21]
  wire [11:0] _GEN_5 = io_input_valid ? $signed(12'sh0) : $signed(inputSum); // @[dut.scala 56:28 63:18 35:25]
  wire [13:0] _GEN_70 = {{2{inputSum[11]}},inputSum}; // @[dut.scala 72:28]
  wire [13:0] _inputSum_T_3 = $signed(_GEN_70) + $signed(multOut); // @[dut.scala 72:28]
  wire [1:0] _coefNum_T_1 = coefNum + 2'h1; // @[dut.scala 73:26]
  wire [11:0] _GEN_17 = coefNum == 2'h3 ? $signed(12'sh0) : $signed(outputSum); // @[dut.scala 74:46 76:19 36:26]
  wire [13:0] _GEN_71 = {{2{outputSum[11]}},outputSum}; // @[dut.scala 85:32]
  wire [13:0] _outputSum_T_3 = $signed(_GEN_71) + $signed(multOut); // @[dut.scala 85:32]
  wire [13:0] _GEN_25 = coefNum < 2'h2 ? $signed(_outputSum_T_3) : $signed({{2{outputSum[11]}},outputSum}); // @[dut.scala 82:40 85:19 36:26]
  wire [1:0] _GEN_26 = coefNum < 2'h2 ? _coefNum_T_1 : coefNum; // @[dut.scala 82:40 86:17 32:24]
  wire [2:0] _GEN_27 = coefNum < 2'h2 ? state : 3'h3; // @[dut.scala 25:22 82:40 88:15]
  wire [11:0] result = $signed(inputSum) - $signed(outputSum); // @[dut.scala 94:29]
  wire [10:0] _GEN_28 = io_output_ready ? $signed(outputMem_0) : $signed(outputMem_1); // @[dut.scala 100:24 29:22 97:29]
  wire [11:0] _GEN_29 = io_output_ready ? $signed(result) : $signed({{1{outputMem_0[10]}},outputMem_0}); // @[dut.scala 102:22 29:22 97:29]
  wire [2:0] _GEN_30 = io_output_ready ? 3'h0 : state; // @[dut.scala 103:15 25:22 97:29]
  wire [11:0] _GEN_31 = 3'h3 == state ? $signed(result) : $signed(12'sh0); // @[dut.scala 54:17 51:18 95:22]
  wire [11:0] _GEN_34 = 3'h3 == state ? $signed(_GEN_29) : $signed({{1{outputMem_0[10]}},outputMem_0}); // @[dut.scala 54:17 29:22]
  wire [2:0] _GEN_35 = 3'h3 == state ? _GEN_30 : state; // @[dut.scala 54:17 25:22]
  wire [13:0] _GEN_38 = 3'h2 == state ? $signed(_GEN_25) : $signed({{2{outputSum[11]}},outputSum}); // @[dut.scala 54:17 36:26]
  wire [11:0] _GEN_41 = 3'h2 == state ? $signed(12'sh0) : $signed(_GEN_31); // @[dut.scala 54:17 51:18]
  wire  _GEN_42 = 3'h2 == state ? 1'h0 : 3'h3 == state; // @[dut.scala 54:17 50:19]
  wire [11:0] _GEN_44 = 3'h2 == state ? $signed({{1{outputMem_0[10]}},outputMem_0}) : $signed(_GEN_34); // @[dut.scala 54:17 29:22]
  wire [13:0] _GEN_47 = 3'h1 == state ? $signed(_inputSum_T_3) : $signed({{2{inputSum[11]}},inputSum}); // @[dut.scala 54:17 72:16 35:25]
  wire [13:0] _GEN_49 = 3'h1 == state ? $signed({{2{_GEN_17[11]}},_GEN_17}) : $signed(_GEN_38); // @[dut.scala 54:17]
  wire [11:0] _GEN_51 = 3'h1 == state ? $signed(12'sh0) : $signed(_GEN_41); // @[dut.scala 54:17 51:18]
  wire  _GEN_52 = 3'h1 == state ? 1'h0 : _GEN_42; // @[dut.scala 54:17 50:19]
  wire [11:0] _GEN_54 = 3'h1 == state ? $signed({{1{outputMem_0[10]}},outputMem_0}) : $signed(_GEN_44); // @[dut.scala 54:17 29:22]
  wire [13:0] _GEN_60 = 3'h0 == state ? $signed({{2{_GEN_5[11]}},_GEN_5}) : $signed(_GEN_47); // @[dut.scala 54:17]
  wire [13:0] _GEN_65 = 3'h0 == state ? $signed({{2{outputSum[11]}},outputSum}) : $signed(_GEN_49); // @[dut.scala 54:17 36:26]
  wire [11:0] _GEN_66 = 3'h0 == state ? $signed(12'sh0) : $signed(_GEN_51); // @[dut.scala 54:17 51:18]
  wire [11:0] _GEN_69 = 3'h0 == state ? $signed({{1{outputMem_0[10]}},outputMem_0}) : $signed(_GEN_54); // @[dut.scala 54:17 29:22]
  wire [13:0] _GEN_74 = reset ? $signed(14'sh0) : $signed(_GEN_60); // @[dut.scala 35:{25,25}]
  wire [13:0] _GEN_76 = reset ? $signed(14'sh0) : $signed(_GEN_65); // @[dut.scala 36:{26,26}]
  assign io_input_ready = 3'h0 == state & io_input_valid; // @[dut.scala 54:17 49:18]
  assign io_output_valid = 3'h0 == state ? 1'h0 : _GEN_52; // @[dut.scala 54:17 50:19]
  assign io_output_bits = _GEN_66[10:0];
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 25:22]
      state <= 3'h0; // @[dut.scala 25:22]
    end else if (3'h0 == state) begin // @[dut.scala 54:17]
      if (io_input_valid) begin // @[dut.scala 56:28]
        state <= 3'h1; // @[dut.scala 65:15]
      end
    end else if (3'h1 == state) begin // @[dut.scala 54:17]
      if (coefNum == 2'h3) begin // @[dut.scala 74:46]
        state <= 3'h2; // @[dut.scala 77:15]
      end
    end else if (3'h2 == state) begin // @[dut.scala 54:17]
      state <= _GEN_27;
    end else begin
      state <= _GEN_35;
    end
    if (3'h0 == state) begin // @[dut.scala 54:17]
      if (io_input_valid) begin // @[dut.scala 56:28]
        inputMem_0 <= io_input_bits; // @[dut.scala 62:21]
      end
    end
    if (3'h0 == state) begin // @[dut.scala 54:17]
      if (io_input_valid) begin // @[dut.scala 56:28]
        inputMem_1 <= inputMem_0; // @[dut.scala 60:23]
      end
    end
    if (3'h0 == state) begin // @[dut.scala 54:17]
      if (io_input_valid) begin // @[dut.scala 56:28]
        inputMem_2 <= inputMem_1; // @[dut.scala 60:23]
      end
    end
    if (3'h0 == state) begin // @[dut.scala 54:17]
      if (io_input_valid) begin // @[dut.scala 56:28]
        inputMem_3 <= inputMem_2; // @[dut.scala 60:23]
      end
    end
    outputMem_0 <= _GEN_69[10:0];
    if (!(3'h0 == state)) begin // @[dut.scala 54:17]
      if (!(3'h1 == state)) begin // @[dut.scala 54:17]
        if (!(3'h2 == state)) begin // @[dut.scala 54:17]
          if (3'h3 == state) begin // @[dut.scala 54:17]
            outputMem_1 <= _GEN_28;
          end
        end
      end
    end
    if (reset) begin // @[dut.scala 32:24]
      coefNum <= 2'h0; // @[dut.scala 32:24]
    end else if (3'h0 == state) begin // @[dut.scala 54:17]
      if (io_input_valid) begin // @[dut.scala 56:28]
        coefNum <= 2'h0; // @[dut.scala 64:17]
      end
    end else if (3'h1 == state) begin // @[dut.scala 54:17]
      if (coefNum == 2'h3) begin // @[dut.scala 74:46]
        coefNum <= 2'h0; // @[dut.scala 75:17]
      end else begin
        coefNum <= _coefNum_T_1; // @[dut.scala 73:15]
      end
    end else if (3'h2 == state) begin // @[dut.scala 54:17]
      coefNum <= _GEN_26;
    end
    inputSum <= _GEN_74[11:0]; // @[dut.scala 35:{25,25}]
    outputSum <= _GEN_76[11:0]; // @[dut.scala 36:{26,26}]
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
  state = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  inputMem_0 = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  inputMem_1 = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  inputMem_2 = _RAND_3[3:0];
  _RAND_4 = {1{`RANDOM}};
  inputMem_3 = _RAND_4[3:0];
  _RAND_5 = {1{`RANDOM}};
  outputMem_0 = _RAND_5[10:0];
  _RAND_6 = {1{`RANDOM}};
  outputMem_1 = _RAND_6[10:0];
  _RAND_7 = {1{`RANDOM}};
  coefNum = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  inputSum = _RAND_8[11:0];
  _RAND_9 = {1{`RANDOM}};
  outputSum = _RAND_9[11:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
