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
  reg [31:0] _RAND_10;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] state; // @[dut.scala 28:22]
  reg [3:0] inputReg; // @[dut.scala 31:21]
  reg [9:0] inputSum; // @[dut.scala 32:21]
  reg [8:0] outputSum; // @[dut.scala 33:22]
  reg [1:0] coefNum; // @[dut.scala 34:24]
  reg [3:0] inputMem_0; // @[dut.scala 37:21]
  reg [3:0] inputMem_1; // @[dut.scala 37:21]
  reg [3:0] inputMem_2; // @[dut.scala 37:21]
  reg [3:0] inputMem_3; // @[dut.scala 37:21]
  reg [10:0] outputMem_0; // @[dut.scala 38:22]
  reg [10:0] outputMem_1; // @[dut.scala 38:22]
  wire [1:0] _multIn_T_2 = coefNum - 2'h1; // @[dut.scala 71:67]
  wire [3:0] _GEN_4 = 2'h1 == _multIn_T_2 ? $signed(inputMem_1) : $signed(inputMem_0); // @[dut.scala 71:{22,22}]
  wire [3:0] _GEN_5 = 2'h2 == _multIn_T_2 ? $signed(inputMem_2) : $signed(_GEN_4); // @[dut.scala 71:{22,22}]
  wire [3:0] _GEN_6 = 2'h3 == _multIn_T_2 ? $signed(inputMem_3) : $signed(_GEN_5); // @[dut.scala 71:{22,22}]
  wire [3:0] _multIn_T_3 = coefNum == 2'h0 ? $signed(inputReg) : $signed(_GEN_6); // @[dut.scala 71:22]
  wire [10:0] _GEN_17 = coefNum[0] ? $signed(outputMem_1) : $signed(outputMem_0); // @[dut.scala 83:{16,16}]
  wire [10:0] _GEN_20 = coefNum < 2'h2 ? $signed(_GEN_17) : $signed(11'sh0); // @[dut.scala 53:10 82:40 83:16]
  wire [10:0] _GEN_37 = 3'h2 == state ? $signed(_GEN_20) : $signed(11'sh0); // @[dut.scala 53:10 57:17]
  wire [10:0] _GEN_50 = 3'h1 == state ? $signed({{7{_multIn_T_3[3]}},_multIn_T_3}) : $signed(_GEN_37); // @[dut.scala 57:17]
  wire [10:0] _GEN_70 = 3'h0 == state ? $signed(11'sh0) : $signed(_GEN_50); // @[dut.scala 53:10 57:17]
  wire [3:0] multIn = _GEN_70[3:0]; // @[dut.scala 44:20]
  wire [2:0] _GEN_8 = 2'h1 == coefNum ? $signed(io_num_1) : $signed(io_num_0); // @[dut.scala 72:{18,18}]
  wire [2:0] _GEN_9 = 2'h2 == coefNum ? $signed(io_num_2) : $signed(_GEN_8); // @[dut.scala 72:{18,18}]
  wire [2:0] _GEN_10 = 2'h3 == coefNum ? $signed(io_num_3) : $signed(_GEN_9); // @[dut.scala 72:{18,18}]
  wire [2:0] _GEN_19 = coefNum[0] ? $signed(io_den_1) : $signed(io_den_0); // @[dut.scala 84:{18,18}]
  wire [2:0] _GEN_21 = coefNum < 2'h2 ? $signed(_GEN_19) : $signed(3'sh0); // @[dut.scala 54:12 82:40 84:18]
  wire [2:0] _GEN_38 = 3'h2 == state ? $signed(_GEN_21) : $signed(3'sh0); // @[dut.scala 54:12 57:17]
  wire [2:0] _GEN_51 = 3'h1 == state ? $signed(_GEN_10) : $signed(_GEN_38); // @[dut.scala 57:17]
  wire [2:0] multCoef = 3'h0 == state ? $signed(3'sh0) : $signed(_GEN_51); // @[dut.scala 54:12 57:17]
  wire [6:0] multOut = $signed(multIn) * $signed(multCoef); // @[dut.scala 47:21]
  wire [9:0] _GEN_81 = {{3{multOut[6]}},multOut}; // @[dut.scala 73:30]
  wire [9:0] _inputSum_T_2 = $signed(inputSum) + $signed(_GEN_81); // @[dut.scala 73:30]
  wire [1:0] _coefNum_T_1 = coefNum + 2'h1; // @[dut.scala 74:28]
  wire [8:0] _GEN_82 = {{2{multOut[6]}},multOut}; // @[dut.scala 85:32]
  wire [8:0] _outputSum_T_2 = $signed(outputSum) + $signed(_GEN_82); // @[dut.scala 85:32]
  wire [1:0] _GEN_23 = coefNum < 2'h2 ? _coefNum_T_1 : coefNum; // @[dut.scala 82:40 86:17 34:24]
  wire [2:0] _GEN_24 = coefNum < 2'h2 ? state : 3'h3; // @[dut.scala 28:22 82:40 88:15]
  wire [9:0] _GEN_83 = {{1{outputSum[8]}},outputSum}; // @[dut.scala 103:35]
  wire [9:0] finalOutput = $signed(inputSum) - $signed(_GEN_83); // @[dut.scala 103:35]
  wire [2:0] _GEN_25 = io_output_ready ? 3'h0 : state; // @[dut.scala 113:29 114:15 28:22]
  wire [2:0] _GEN_27 = 3'h4 == state ? _GEN_25 : state; // @[dut.scala 57:17 28:22]
  wire [9:0] _GEN_34 = 3'h3 == state ? $signed(finalOutput) : $signed(10'sh0); // @[dut.scala 57:17 107:22 52:18]
  wire [2:0] _GEN_35 = 3'h3 == state ? 3'h4 : _GEN_27; // @[dut.scala 108:13 57:17]
  wire  _GEN_36 = 3'h3 == state ? 1'h0 : 3'h4 == state; // @[dut.scala 57:17 51:19]
  wire [9:0] _GEN_48 = 3'h2 == state ? $signed(10'sh0) : $signed(_GEN_34); // @[dut.scala 57:17 52:18]
  wire  _GEN_49 = 3'h2 == state ? 1'h0 : _GEN_36; // @[dut.scala 57:17 51:19]
  wire [9:0] _GEN_62 = 3'h1 == state ? $signed(10'sh0) : $signed(_GEN_48); // @[dut.scala 57:17 52:18]
  wire  _GEN_63 = 3'h1 == state ? 1'h0 : _GEN_49; // @[dut.scala 57:17 51:19]
  wire [9:0] _GEN_78 = 3'h0 == state ? $signed(10'sh0) : $signed(_GEN_62); // @[dut.scala 57:17 52:18]
  assign io_input_ready = 3'h0 == state & io_input_valid; // @[dut.scala 57:17 50:18]
  assign io_output_valid = 3'h0 == state ? 1'h0 : _GEN_63; // @[dut.scala 57:17 51:19]
  assign io_output_bits = {{1{_GEN_78[9]}},_GEN_78};
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 28:22]
      state <= 3'h0; // @[dut.scala 28:22]
    end else if (3'h0 == state) begin // @[dut.scala 57:17]
      if (io_input_valid) begin // @[dut.scala 62:28]
        state <= 3'h1; // @[dut.scala 65:15]
      end
    end else if (!(3'h1 == state)) begin // @[dut.scala 57:17]
      if (3'h2 == state) begin // @[dut.scala 57:17]
        state <= _GEN_24;
      end else begin
        state <= _GEN_35;
      end
    end
    if (3'h0 == state) begin // @[dut.scala 57:17]
      if (io_input_valid) begin // @[dut.scala 62:28]
        inputReg <= io_input_bits; // @[dut.scala 64:18]
      end
    end
    if (3'h0 == state) begin // @[dut.scala 57:17]
      inputSum <= 10'sh0; // @[dut.scala 59:16]
    end else if (3'h1 == state) begin // @[dut.scala 57:17]
      inputSum <= _inputSum_T_2;
    end
    if (3'h0 == state) begin // @[dut.scala 57:17]
      outputSum <= 9'sh0; // @[dut.scala 60:17]
    end else if (!(3'h1 == state)) begin // @[dut.scala 57:17]
      if (3'h2 == state) begin // @[dut.scala 57:17]
        if (coefNum < 2'h2) begin // @[dut.scala 82:40]
          outputSum <= _outputSum_T_2; // @[dut.scala 85:19]
        end
      end
    end
    if (reset) begin // @[dut.scala 34:24]
      coefNum <= 2'h0; // @[dut.scala 34:24]
    end else if (3'h0 == state) begin // @[dut.scala 57:17]
      coefNum <= 2'h0; // @[dut.scala 61:15]
    end else if (3'h1 == state) begin // @[dut.scala 57:17]
      coefNum <= _coefNum_T_1;
    end else if (3'h2 == state) begin // @[dut.scala 57:17]
      coefNum <= _GEN_23;
    end
    if (!(3'h0 == state)) begin // @[dut.scala 57:17]
      if (!(3'h1 == state)) begin // @[dut.scala 57:17]
        if (!(3'h2 == state)) begin // @[dut.scala 57:17]
          if (3'h3 == state) begin // @[dut.scala 57:17]
            inputMem_0 <= inputReg; // @[dut.scala 97:19]
          end
        end
      end
    end
    if (!(3'h0 == state)) begin // @[dut.scala 57:17]
      if (!(3'h1 == state)) begin // @[dut.scala 57:17]
        if (!(3'h2 == state)) begin // @[dut.scala 57:17]
          if (3'h3 == state) begin // @[dut.scala 57:17]
            inputMem_1 <= inputMem_0; // @[dut.scala 95:21]
          end
        end
      end
    end
    if (!(3'h0 == state)) begin // @[dut.scala 57:17]
      if (!(3'h1 == state)) begin // @[dut.scala 57:17]
        if (!(3'h2 == state)) begin // @[dut.scala 57:17]
          if (3'h3 == state) begin // @[dut.scala 57:17]
            inputMem_2 <= inputMem_1; // @[dut.scala 95:21]
          end
        end
      end
    end
    if (!(3'h0 == state)) begin // @[dut.scala 57:17]
      if (!(3'h1 == state)) begin // @[dut.scala 57:17]
        if (!(3'h2 == state)) begin // @[dut.scala 57:17]
          if (3'h3 == state) begin // @[dut.scala 57:17]
            inputMem_3 <= inputMem_2; // @[dut.scala 95:21]
          end
        end
      end
    end
    if (!(3'h0 == state)) begin // @[dut.scala 57:17]
      if (!(3'h1 == state)) begin // @[dut.scala 57:17]
        if (!(3'h2 == state)) begin // @[dut.scala 57:17]
          if (3'h3 == state) begin // @[dut.scala 57:17]
            outputMem_0 <= {{1{finalOutput[9]}},finalOutput}; // @[dut.scala 104:20]
          end
        end
      end
    end
    if (!(3'h0 == state)) begin // @[dut.scala 57:17]
      if (!(3'h1 == state)) begin // @[dut.scala 57:17]
        if (!(3'h2 == state)) begin // @[dut.scala 57:17]
          if (3'h3 == state) begin // @[dut.scala 57:17]
            outputMem_1 <= outputMem_0; // @[dut.scala 101:22]
          end
        end
      end
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
  state = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  inputReg = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  inputSum = _RAND_2[9:0];
  _RAND_3 = {1{`RANDOM}};
  outputSum = _RAND_3[8:0];
  _RAND_4 = {1{`RANDOM}};
  coefNum = _RAND_4[1:0];
  _RAND_5 = {1{`RANDOM}};
  inputMem_0 = _RAND_5[3:0];
  _RAND_6 = {1{`RANDOM}};
  inputMem_1 = _RAND_6[3:0];
  _RAND_7 = {1{`RANDOM}};
  inputMem_2 = _RAND_7[3:0];
  _RAND_8 = {1{`RANDOM}};
  inputMem_3 = _RAND_8[3:0];
  _RAND_9 = {1{`RANDOM}};
  outputMem_0 = _RAND_9[10:0];
  _RAND_10 = {1{`RANDOM}};
  outputMem_1 = _RAND_10[10:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
