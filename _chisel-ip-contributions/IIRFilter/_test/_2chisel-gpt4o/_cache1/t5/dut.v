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
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] inputMem [0:3]; // @[dut.scala 34:21]
  wire  inputMem_multIn_MPORT_en; // @[dut.scala 34:21]
  wire [1:0] inputMem_multIn_MPORT_addr; // @[dut.scala 34:21]
  wire [3:0] inputMem_multIn_MPORT_data; // @[dut.scala 34:21]
  wire [3:0] inputMem_MPORT_data; // @[dut.scala 34:21]
  wire [1:0] inputMem_MPORT_addr; // @[dut.scala 34:21]
  wire  inputMem_MPORT_mask; // @[dut.scala 34:21]
  wire  inputMem_MPORT_en; // @[dut.scala 34:21]
  reg [10:0] outputMem [0:1]; // @[dut.scala 35:22]
  wire  outputMem_multIn_MPORT_1_en; // @[dut.scala 35:22]
  wire  outputMem_multIn_MPORT_1_addr; // @[dut.scala 35:22]
  wire [10:0] outputMem_multIn_MPORT_1_data; // @[dut.scala 35:22]
  wire  outputMem_io_output_bits_MPORT_en; // @[dut.scala 35:22]
  wire  outputMem_io_output_bits_MPORT_addr; // @[dut.scala 35:22]
  wire [10:0] outputMem_io_output_bits_MPORT_data; // @[dut.scala 35:22]
  wire [10:0] outputMem_MPORT_1_data; // @[dut.scala 35:22]
  wire  outputMem_MPORT_1_addr; // @[dut.scala 35:22]
  wire  outputMem_MPORT_1_mask; // @[dut.scala 35:22]
  wire  outputMem_MPORT_1_en; // @[dut.scala 35:22]
  reg [2:0] state; // @[dut.scala 28:22]
  reg [1:0] coefNum; // @[dut.scala 31:24]
  reg [7:0] inputSum; // @[dut.scala 32:25]
  reg [7:0] outputSum; // @[dut.scala 33:26]
  reg [1:0] inputMemAddr; // @[dut.scala 36:29]
  reg  outputMemAddr; // @[dut.scala 37:30]
  wire  _T = 3'h0 == state; // @[dut.scala 48:17]
  wire  _T_2 = 3'h1 == state; // @[dut.scala 48:17]
  wire [3:0] _multIn_T_3 = coefNum == 2'h0 ? $signed(io_input_bits) : $signed(inputMem_multIn_MPORT_data); // @[dut.scala 66:22]
  wire  _T_5 = coefNum < 2'h2; // @[dut.scala 78:20]
  wire [10:0] _GEN_28 = coefNum < 2'h2 ? $signed(outputMem_multIn_MPORT_1_data) : $signed(11'sh0); // @[dut.scala 43:10 78:40 79:16]
  wire [10:0] _GEN_46 = 3'h2 == state ? $signed(_GEN_28) : $signed(11'sh0); // @[dut.scala 43:10 48:17]
  wire [10:0] _GEN_60 = 3'h1 == state ? $signed({{7{_multIn_T_3[3]}},_multIn_T_3}) : $signed(_GEN_46); // @[dut.scala 48:17]
  wire [10:0] _GEN_87 = 3'h0 == state ? $signed(11'sh0) : $signed(_GEN_60); // @[dut.scala 43:10 48:17]
  wire [3:0] multIn = _GEN_87[3:0]; // @[dut.scala 38:20]
  wire [2:0] _GEN_11 = 2'h1 == coefNum ? $signed(io_num_1) : $signed(io_num_0); // @[dut.scala 67:{18,18}]
  wire [2:0] _GEN_12 = 2'h2 == coefNum ? $signed(io_num_2) : $signed(_GEN_11); // @[dut.scala 67:{18,18}]
  wire [2:0] _GEN_13 = 2'h3 == coefNum ? $signed(io_num_3) : $signed(_GEN_12); // @[dut.scala 67:{18,18}]
  wire [2:0] _GEN_24 = coefNum[0] ? $signed(io_den_1) : $signed(io_den_0); // @[dut.scala 80:{18,18}]
  wire [2:0] _GEN_29 = coefNum < 2'h2 ? $signed(_GEN_24) : $signed(3'sh0); // @[dut.scala 44:12 78:40 80:18]
  wire [2:0] _GEN_47 = 3'h2 == state ? $signed(_GEN_29) : $signed(3'sh0); // @[dut.scala 44:12 48:17]
  wire [2:0] _GEN_61 = 3'h1 == state ? $signed(_GEN_13) : $signed(_GEN_47); // @[dut.scala 48:17]
  wire [2:0] multCoef = 3'h0 == state ? $signed(3'sh0) : $signed(_GEN_61); // @[dut.scala 44:12 48:17]
  wire [6:0] multOut = $signed(multIn) * $signed(multCoef); // @[dut.scala 45:21]
  wire [1:0] _inputMemAddr_T_1 = inputMemAddr + 2'h1; // @[dut.scala 53:38]
  wire [7:0] _GEN_100 = {{1{multOut[6]}},multOut}; // @[dut.scala 68:30]
  wire [7:0] _inputSum_T_2 = $signed(inputSum) + $signed(_GEN_100); // @[dut.scala 68:30]
  wire [1:0] _coefNum_T_1 = coefNum + 2'h1; // @[dut.scala 69:28]
  wire [7:0] _outputSum_T_2 = $signed(outputSum) + $signed(_GEN_100); // @[dut.scala 81:32]
  wire [7:0] _GEN_30 = coefNum < 2'h2 ? $signed(_outputSum_T_2) : $signed(outputSum); // @[dut.scala 78:40 81:19 33:26]
  wire [1:0] _GEN_31 = coefNum < 2'h2 ? _coefNum_T_1 : 2'h0; // @[dut.scala 78:40 82:17 84:17]
  wire [2:0] _GEN_32 = coefNum < 2'h2 ? state : 3'h3; // @[dut.scala 28:22 78:40 85:15]
  wire [7:0] finalOutput = $signed(inputSum) - $signed(outputSum); // @[dut.scala 90:35]
  wire  _GEN_33 = outputMemAddr ? 1'h0 : outputMemAddr + 1'h1; // @[dut.scala 92:21 93:54 94:23]
  wire [2:0] _GEN_34 = io_output_ready ? 3'h0 : state; // @[dut.scala 100:29 101:15 28:22]
  wire [2:0] _GEN_35 = 3'h4 == state ? _GEN_34 : state; // @[dut.scala 48:17 28:22]
  wire  _GEN_41 = 3'h3 == state ? _GEN_33 : outputMemAddr; // @[dut.scala 48:17 37:30]
  wire [2:0] _GEN_42 = 3'h3 == state ? 3'h4 : _GEN_35; // @[dut.scala 48:17 96:13]
  wire  _GEN_53 = 3'h2 == state ? 1'h0 : 3'h3 == state; // @[dut.scala 48:17 35:22]
  wire  _GEN_68 = 3'h1 == state ? 1'h0 : 3'h2 == state & _T_5; // @[dut.scala 48:17 35:22]
  wire  _GEN_71 = 3'h1 == state ? 1'h0 : _GEN_53; // @[dut.scala 48:17 35:22]
  wire  _io_output_valid_T = state == 3'h4; // @[dut.scala 108:29]
  assign inputMem_multIn_MPORT_en = _T ? 1'h0 : _T_2;
  assign inputMem_multIn_MPORT_addr = coefNum - 2'h1;
  assign inputMem_multIn_MPORT_data = inputMem[inputMem_multIn_MPORT_addr]; // @[dut.scala 34:21]
  assign inputMem_MPORT_data = io_input_bits;
  assign inputMem_MPORT_addr = inputMemAddr;
  assign inputMem_MPORT_mask = 1'h1;
  assign inputMem_MPORT_en = _T & io_input_valid;
  assign outputMem_multIn_MPORT_1_en = _T ? 1'h0 : _GEN_68;
  assign outputMem_multIn_MPORT_1_addr = coefNum[0];
  assign outputMem_multIn_MPORT_1_data = outputMem[outputMem_multIn_MPORT_1_addr]; // @[dut.scala 35:22]
  assign outputMem_io_output_bits_MPORT_en = 1'h1;
  assign outputMem_io_output_bits_MPORT_addr = outputMemAddr - 1'h1;
  assign outputMem_io_output_bits_MPORT_data = outputMem[outputMem_io_output_bits_MPORT_addr]; // @[dut.scala 35:22]
  assign outputMem_MPORT_1_data = {{3{finalOutput[7]}},finalOutput};
  assign outputMem_MPORT_1_addr = outputMemAddr;
  assign outputMem_MPORT_1_mask = 1'h1;
  assign outputMem_MPORT_1_en = _T ? 1'h0 : _GEN_71;
  assign io_input_ready = state == 3'h0; // @[dut.scala 107:28]
  assign io_output_valid = state == 3'h4; // @[dut.scala 108:29]
  assign io_output_bits = _io_output_valid_T ? $signed(outputMem_io_output_bits_MPORT_data) : $signed(11'sh0); // @[dut.scala 109:24]
  always @(posedge clock) begin
    if (inputMem_MPORT_en & inputMem_MPORT_mask) begin
      inputMem[inputMem_MPORT_addr] <= inputMem_MPORT_data; // @[dut.scala 34:21]
    end
    if (outputMem_MPORT_1_en & outputMem_MPORT_1_mask) begin
      outputMem[outputMem_MPORT_1_addr] <= outputMem_MPORT_1_data; // @[dut.scala 35:22]
    end
    if (reset) begin // @[dut.scala 28:22]
      state <= 3'h0; // @[dut.scala 28:22]
    end else if (3'h0 == state) begin // @[dut.scala 48:17]
      if (io_input_valid) begin // @[dut.scala 50:28]
        state <= 3'h1; // @[dut.scala 60:15]
      end
    end else if (!(3'h1 == state)) begin // @[dut.scala 48:17]
      if (3'h2 == state) begin // @[dut.scala 48:17]
        state <= _GEN_32;
      end else begin
        state <= _GEN_42;
      end
    end
    if (reset) begin // @[dut.scala 31:24]
      coefNum <= 2'h0; // @[dut.scala 31:24]
    end else if (3'h0 == state) begin // @[dut.scala 48:17]
      if (io_input_valid) begin // @[dut.scala 50:28]
        coefNum <= 2'h0; // @[dut.scala 59:17]
      end
    end else if (3'h1 == state) begin // @[dut.scala 48:17]
      coefNum <= _coefNum_T_1;
    end else if (3'h2 == state) begin // @[dut.scala 48:17]
      coefNum <= _GEN_31;
    end
    if (reset) begin // @[dut.scala 32:25]
      inputSum <= 8'sh0; // @[dut.scala 32:25]
    end else if (3'h0 == state) begin // @[dut.scala 48:17]
      if (io_input_valid) begin // @[dut.scala 50:28]
        inputSum <= 8'sh0; // @[dut.scala 58:18]
      end
    end else if (3'h1 == state) begin // @[dut.scala 48:17]
      inputSum <= _inputSum_T_2;
    end
    if (reset) begin // @[dut.scala 33:26]
      outputSum <= 8'sh0; // @[dut.scala 33:26]
    end else if (!(3'h0 == state)) begin // @[dut.scala 48:17]
      if (!(3'h1 == state)) begin // @[dut.scala 48:17]
        if (3'h2 == state) begin // @[dut.scala 48:17]
          outputSum <= _GEN_30;
        end
      end
    end
    if (reset) begin // @[dut.scala 36:29]
      inputMemAddr <= 2'h0; // @[dut.scala 36:29]
    end else if (3'h0 == state) begin // @[dut.scala 48:17]
      if (io_input_valid) begin // @[dut.scala 50:28]
        if (inputMemAddr == 2'h3) begin // @[dut.scala 54:53]
          inputMemAddr <= 2'h0; // @[dut.scala 55:24]
        end else begin
          inputMemAddr <= _inputMemAddr_T_1; // @[dut.scala 53:22]
        end
      end
    end
    if (reset) begin // @[dut.scala 37:30]
      outputMemAddr <= 1'h0; // @[dut.scala 37:30]
    end else if (!(3'h0 == state)) begin // @[dut.scala 48:17]
      if (!(3'h1 == state)) begin // @[dut.scala 48:17]
        if (!(3'h2 == state)) begin // @[dut.scala 48:17]
          outputMemAddr <= _GEN_41;
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 4; initvar = initvar+1)
    inputMem[initvar] = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    outputMem[initvar] = _RAND_1[10:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  state = _RAND_2[2:0];
  _RAND_3 = {1{`RANDOM}};
  coefNum = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  inputSum = _RAND_4[7:0];
  _RAND_5 = {1{`RANDOM}};
  outputSum = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  inputMemAddr = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  outputMemAddr = _RAND_7[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
