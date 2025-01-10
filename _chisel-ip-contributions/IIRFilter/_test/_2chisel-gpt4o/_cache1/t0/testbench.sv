`timescale 1ns / 1ps

module testbench;

//parameter or localparam 
// No parameters or localparams in the provided RTL

// Inputs
reg clock;
reg reset;
reg io_input_valid;
reg [3:0] io_input_bits;
reg [2:0] io_num_0;
reg [2:0] io_num_1;
reg [2:0] io_num_2;
reg [2:0] io_num_3;
reg [2:0] io_den_0;
reg [2:0] io_den_1;
reg io_output_ready;

// Outputs or inout
wire io_input_ready, io_input_ready_golden;
wire io_output_valid, io_output_valid_golden;
wire [10:0] io_output_bits, io_output_bits_golden;

integer total_tests = 0;
integer failed_tests = 0;
wire match;
assign match = ({io_input_ready_golden, io_output_valid_golden, io_output_bits_golden} === ({io_input_ready_golden, io_output_valid_golden, io_output_bits_golden} ^ {io_input_ready, io_output_valid, io_output_bits} ^ {io_input_ready_golden, io_output_valid_golden, io_output_bits_golden}));

// Instantiate the Unit Under Test (UUT)
IIRFilter_golden golden_model (
    .clock(clock),
    .reset(reset),
    .io_input_ready(io_input_ready_golden),
    .io_input_valid(io_input_valid),
    .io_input_bits(io_input_bits),
    .io_num_0(io_num_0),
    .io_num_1(io_num_1),
    .io_num_2(io_num_2),
    .io_num_3(io_num_3),
    .io_den_0(io_den_0),
    .io_den_1(io_den_1),
    .io_output_ready(io_output_ready),
    .io_output_valid(io_output_valid_golden),
    .io_output_bits(io_output_bits_golden)
);


dut uut (
    .clock(clock),
    .reset(reset),
    .io_input_ready(io_input_ready),
    .io_input_valid(io_input_valid),
    .io_input_bits(io_input_bits),
    .io_num_0(io_num_0),
    .io_num_1(io_num_1),
    .io_num_2(io_num_2),
    .io_num_3(io_num_3),
    .io_den_0(io_den_0),
    .io_den_1(io_den_1),
    .io_output_ready(io_output_ready),
    .io_output_valid(io_output_valid),
    .io_output_bits(io_output_bits)
);


//clk toggle generate
always #5 clock = ~clock;

always @(posedge clock) begin
    total_tests = total_tests + 1; 
    if (match) begin
        $display("\033[1;32mtestcase is passed!!!\033[0m");
    end
    else begin
        $display("\033[1;31mtestcase is failed!!!\033[0m");
        failed_tests = failed_tests + 1; 
    end
end

initial begin
    // Initialize Inputs
    clock = 0;
    reset = 1;
    io_input_valid = 0;
    io_input_bits = 4'b0000;
    io_num_0 = 3'b000;
    io_num_1 = 3'b000;
    io_num_2 = 3'b000;
    io_num_3 = 3'b000;
    io_den_0 = 3'b000;
    io_den_1 = 3'b000;
    io_output_ready = 0;

    // Wait 100 ns for global reset to finish
    #100;
    reset = 0;

    // Add stimulus here

    // Initial stimulus
    io_input_valid = 1;
    io_input_bits = 4'b0000;
    io_num_0 = 3'b001;
    io_num_1 = 3'b010;
    io_num_2 = 3'b011;
    io_num_3 = 3'b100;
    io_den_0 = 3'b001;
    io_den_1 = 3'b010;
    io_output_ready = 1;

    // Apply initial input pattern and toggle inputs
    for (integer i = 0; i < 16; i = i + 1) begin
        io_input_bits = i[3:0];
        #10;
    end

    // Test Case 1: Data Input Handling
    io_input_valid = 1;
    for (integer i = 0; i < 100; i = i + 1) begin
        io_input_bits = i[3:0];
        #10;
    end

    // Test Case 2: Coefficient Configuration
    io_num_0 = 3'b001;
    io_num_1 = 3'b010;
    io_num_2 = 3'b011;
    io_num_3 = 3'b100;
    io_den_0 = 3'b001;
    io_den_1 = 3'b010;
    for (integer i = 0; i < 100; i = i + 1) begin
        io_input_bits = i[3:0];
        #10;
    end

    // Test Case 3: Recursive Filtering Operation
    io_input_valid = 1;
    for (integer i = 0; i < 100; i = i + 1) begin
        io_input_bits = $random;
        #10;
    end

    // Test Case 4: Output Generation
    io_output_ready = 1;
    for (integer i = 0; i < 100; i = i + 1) begin
        io_input_bits = i[3:0];
        #10;
    end

    // Test Case 5: State Machine Control
    for (integer i = 0; i < 100; i = i + 1) begin
        io_input_valid = (i % 2 == 0);
        io_input_bits = i[3:0];
        #10;
    end

    // Test Case 6: Memory Management
    for (integer i = 0; i < 100; i = i + 1) begin
        io_input_bits = i[3:0];
        #10;
    end

    // Test Case 7: Multiply-Accumulate Operations
    for (integer i = 0; i < 100; i = i + 1) begin
        io_input_bits = i[3:0];
        #10;
    end

    // Test Case 8: Input and Output Synchronization
    for (integer i = 0; i < 100; i = i + 1) begin
        io_input_valid = (i % 2 == 0);
        io_output_ready = (i % 3 == 0);
        io_input_bits = i[3:0];
        #10;
    end

    // Test Case 9: Signal Integrity and Error Handling
    reset = 1;
    #10;
    reset = 0;
    #10;
    for (integer i = 0; i < 100; i = i + 1) begin
        io_input_bits = i[3:0];
        #10;
    end

    // Final reset event to simulate a reset condition
    reset = 1;
    #10;
    reset = 0;
    #10;

// Additional Test Stimuli
// Ensure all states and transitions in the FSM are covered
// Test Case 10: Transition through all FSM states
reset = 1;
#10;
reset = 0;
io_input_valid = 1;
io_input_bits = 4'b0010;
io_output_ready = 0;
#10;
// Transition from state 0 to state 1
io_input_valid = 1;
#10;
// Transition from state 1 to state 2
io_input_valid = 0;
#10;
// Transition from state 2 to state 3
io_output_ready = 1;
#10;
// Transition from state 3 to state 0
io_output_ready = 0;
#10;
// Test Case 11: Ensure all branches and conditions are covered
// Use a combination of coefficients and input values to explore all branches
io_num_0 = 3'b011;
io_num_1 = 3'b110;
io_num_2 = 3'b101;
io_num_3 = 3'b111;
io_den_0 = 3'b100;
io_den_1 = 3'b011;
io_input_valid = 1;
io_output_ready = 1;
#10;
// Test Case 12: Toggle all bits of input signals
// Iterate through all possible values for input bits to ensure toggle coverage
for (integer i = 0; i < 16; i = i + 1) begin
    io_input_bits = i[3:0];
    #10;
end
// Test Case 13: Ensure toggle coverage for output signals
// Generate output by toggling input and observing the output
io_input_valid = 1;
io_output_ready = 1;
for (integer i = 0; i < 16; i = i + 1) begin
    io_input_bits = i[3:0];
    #10;
    io_output_ready = ~io_output_ready; // Toggle output ready signal
end
// Test Case 14: Reset condition and edge cases
// Test reset functionality and edge cases for input and output
reset = 1;
#10;
reset = 0;
io_input_valid = 1;
io_input_bits = 4'b1111; // Edge case with maximum input value
io_output_ready = 1;
#10;
io_input_bits = 4'b0000; // Edge case with minimum input value
#10;
// Finalize testing with a reset to ensure proper reset behavior
reset = 1;
#10;
reset = 0;
#10;
$display("\033[1;34mTotal testcases: %d, Failed testcases: %d\033[0m", total_tests, failed_tests);
$finish;
end

endmodule

module IIRFilter_golden(
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
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] inputMem [0:2]; // @[golden.scala 115:21]
  wire  inputMem_inputRdWr_r_en; // @[golden.scala 115:21]
  wire [1:0] inputMem_inputRdWr_r_addr; // @[golden.scala 115:21]
  wire [3:0] inputMem_inputRdWr_r_data; // @[golden.scala 115:21]
  wire [3:0] inputMem_inputRdWr_w_data; // @[golden.scala 115:21]
  wire [1:0] inputMem_inputRdWr_w_addr; // @[golden.scala 115:21]
  wire  inputMem_inputRdWr_w_mask; // @[golden.scala 115:21]
  wire  inputMem_inputRdWr_w_en; // @[golden.scala 115:21]
  reg [10:0] outputMem [0:1]; // @[golden.scala 139:22]
  wire  outputMem_outputRdWr_r_en; // @[golden.scala 139:22]
  wire  outputMem_outputRdWr_r_addr; // @[golden.scala 139:22]
  wire [10:0] outputMem_outputRdWr_r_data; // @[golden.scala 139:22]
  wire [10:0] outputMem_outputRdWr_w_data; // @[golden.scala 139:22]
  wire  outputMem_outputRdWr_w_addr; // @[golden.scala 139:22]
  wire  outputMem_outputRdWr_w_mask; // @[golden.scala 139:22]
  wire  outputMem_outputRdWr_w_en; // @[golden.scala 139:22]
  reg [1:0] coefNum; // @[golden.scala 62:24]
  reg [2:0] state; // @[golden.scala 68:22]
  wire  _T_6 = coefNum == 2'h3; // @[golden.scala 77:20]
  wire  _T_10 = coefNum == 2'h1; // @[golden.scala 82:20]
  wire [2:0] _GEN_2 = coefNum == 2'h1 ? 3'h4 : state; // @[golden.scala 82:48 83:15 68:22]
  wire [2:0] _GEN_3 = io_output_ready ? 3'h0 : state; // @[golden.scala 90:29 91:15 68:22]
  wire [2:0] _GEN_4 = 3'h3 == state ? _GEN_3 : state; // @[golden.scala 70:17 68:22]
  wire [2:0] _GEN_5 = 3'h4 == state ? 3'h3 : _GEN_4; // @[golden.scala 70:17 87:13]
  wire  _T_18 = state == 3'h0 & io_input_valid; // @[golden.scala 96:40]
  wire  _T_19 = state == 3'h1; // @[golden.scala 98:20]
  wire [1:0] _coefNum_T_1 = coefNum + 2'h1; // @[golden.scala 102:26]
  wire  _T_21 = state == 3'h2; // @[golden.scala 104:20]
  wire [1:0] _GEN_10 = _T_10 ? 2'h0 : _coefNum_T_1; // @[golden.scala 105:46 106:15 108:15]
  reg [3:0] inputReg; // @[golden.scala 114:25]
  reg [1:0] inputMemAddr; // @[golden.scala 116:29]
  wire  _T_23 = state == 3'h4; // @[golden.scala 122:14]
  wire [3:0] inputMemOut = inputMem_inputRdWr_r_data; // @[golden.scala 124:65 126:17 128:17]
  wire [1:0] _inputMemAddr_T_1 = inputMemAddr + 2'h1; // @[golden.scala 135:36]
  reg  outputMemAddr; // @[golden.scala 140:30]
  wire  _T_30 = state == 3'h3; // @[golden.scala 146:15]
  reg [2:0] REG; // @[golden.scala 146:52]
  wire  _T_31 = REG == 3'h4; // @[golden.scala 146:60]
  wire [10:0] outputMemOut = outputMem_outputRdWr_r_data; // @[golden.scala 146:91 149:18]
  reg [8:0] inputSum; // @[golden.scala 160:25]
  reg [14:0] outputSum; // @[golden.scala 161:26]
  reg [13:0] multOutReg; // @[golden.scala 164:27]
  wire [13:0] _GEN_48 = {{5{inputSum[8]}},inputSum}; // @[golden.scala 174:26]
  wire [14:0] _inputSum_T = $signed(_GEN_48) + $signed(multOutReg); // @[golden.scala 174:26]
  wire [14:0] _GEN_50 = {{1{multOutReg[13]}},multOutReg}; // @[golden.scala 182:30]
  wire [15:0] _outputSum_T = $signed(outputSum) + $signed(_GEN_50); // @[golden.scala 182:30]
  wire [14:0] _GEN_27 = coefNum == 2'h0 ? $signed(_inputSum_T) : $signed({{6{inputSum[8]}},inputSum}); // @[golden.scala 178:27 180:16 160:25]
  wire [15:0] _GEN_28 = coefNum == 2'h0 ? $signed({{1{outputSum[14]}},outputSum}) : $signed(_outputSum_T); // @[golden.scala 161:26 178:27 182:17]
  wire [15:0] _GEN_29 = _T_23 ? $signed(_outputSum_T) : $signed({{1{outputSum[14]}},outputSum}); // @[golden.scala 184:50 185:15 161:26]
  wire [10:0] _GEN_39 = _T_21 ? $signed(outputMemOut) : $signed({{7{io_input_bits[3]}},io_input_bits}); // @[golden.scala 190:51 191:12 193:12]
  wire [10:0] multIn = _T_19 ? $signed({{7{inputMemOut[3]}},inputMemOut}) : $signed(_GEN_39); // @[golden.scala 188:45 189:12]
  wire [2:0] _GEN_42 = coefNum[0] ? $signed(io_den_1) : $signed(io_den_0); // @[golden.scala 197:{14,14}]
  wire [2:0] _GEN_44 = 2'h1 == coefNum ? $signed(io_num_1) : $signed(io_num_0); // @[golden.scala 199:{14,14}]
  wire [2:0] _GEN_45 = 2'h2 == coefNum ? $signed(io_num_2) : $signed(_GEN_44); // @[golden.scala 199:{14,14}]
  wire [2:0] _GEN_46 = 2'h3 == coefNum ? $signed(io_num_3) : $signed(_GEN_45); // @[golden.scala 199:{14,14}]
  wire [2:0] multCoef = _T_21 ? $signed(_GEN_42) : $signed(_GEN_46); // @[golden.scala 196:45 197:14 199:14]
  wire [13:0] multOut = $signed(multIn) * $signed(multCoef); // @[golden.scala 202:21]
  wire [14:0] _GEN_31 = _T_21 ? $signed(_GEN_27) : $signed({{6{inputSum[8]}},inputSum}); // @[golden.scala 160:25 175:51]
  wire [15:0] _GEN_32 = _T_21 ? $signed(_GEN_28) : $signed(_GEN_29); // @[golden.scala 175:51]
  wire [14:0] _GEN_34 = _T_19 ? $signed(_inputSum_T) : $signed(_GEN_31); // @[golden.scala 172:51 174:14]
  wire [15:0] _GEN_35 = _T_19 ? $signed({{1{outputSum[14]}},outputSum}) : $signed(_GEN_32); // @[golden.scala 161:26 172:51]
  wire [15:0] _GEN_37 = _T_18 ? $signed(16'sh0) : $signed(_GEN_35); // @[golden.scala 168:59 170:15]
  wire [14:0] _GEN_38 = _T_18 ? $signed(15'sh0) : $signed(_GEN_34); // @[golden.scala 168:59 171:14]
  wire [14:0] _GEN_52 = {{6{inputSum[8]}},inputSum}; // @[golden.scala 206:30]
  wire [15:0] _io_output_bits_T_1 = $signed(_GEN_52) - $signed(outputSum); // @[golden.scala 206:30]
  wire [14:0] _GEN_54 = reset ? $signed(15'sh0) : $signed(_GEN_38); // @[golden.scala 160:{25,25}]
  wire [15:0] _GEN_56 = reset ? $signed(16'sh0) : $signed(_GEN_37); // @[golden.scala 161:{26,26}]
  assign inputMem_inputRdWr_r_en = 1'h1 & ~(state == 3'h4);
  assign inputMem_inputRdWr_r_addr = inputMemAddr;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign inputMem_inputRdWr_r_data = inputMem[inputMem_inputRdWr_r_addr]; // @[golden.scala 115:21]
  `else
  assign inputMem_inputRdWr_r_data = inputMem_inputRdWr_r_addr >= 2'h3 ? _RAND_1[3:0] :
    inputMem[inputMem_inputRdWr_r_addr]; // @[golden.scala 115:21]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign inputMem_inputRdWr_w_data = inputReg;
  assign inputMem_inputRdWr_w_addr = inputMemAddr;
  assign inputMem_inputRdWr_w_mask = state == 3'h4;
  assign inputMem_inputRdWr_w_en = 1'h1 & state == 3'h4;
  assign outputMem_outputRdWr_r_en = 1'h1 & ~(_T_30 & _T_31);
  assign outputMem_outputRdWr_r_addr = outputMemAddr;
  assign outputMem_outputRdWr_r_data = outputMem[outputMem_outputRdWr_r_addr]; // @[golden.scala 139:22]
  assign outputMem_outputRdWr_w_data = io_output_bits;
  assign outputMem_outputRdWr_w_addr = outputMemAddr;
  assign outputMem_outputRdWr_w_mask = _T_30 & _T_31;
  assign outputMem_outputRdWr_w_en = 1'h1 & (_T_30 & _T_31);
  assign io_input_ready = state == 3'h0; // @[golden.scala 204:27]
  assign io_output_valid = state == 3'h3; // @[golden.scala 205:28]
  assign io_output_bits = _io_output_bits_T_1[10:0]; // @[golden.scala 206:18]
  always @(posedge clock) begin
    if (inputMem_inputRdWr_w_en & inputMem_inputRdWr_w_mask) begin
      inputMem[inputMem_inputRdWr_w_addr] <= inputMem_inputRdWr_w_data; // @[golden.scala 115:21]
    end
    if (outputMem_outputRdWr_w_en & outputMem_outputRdWr_w_mask) begin
      outputMem[outputMem_outputRdWr_w_addr] <= outputMem_outputRdWr_w_data; // @[golden.scala 139:22]
    end
    if (reset) begin // @[golden.scala 62:24]
      coefNum <= 2'h0; // @[golden.scala 62:24]
    end else if (state == 3'h0 & io_input_valid) begin // @[golden.scala 96:59]
      coefNum <= 2'h1; // @[golden.scala 97:13]
    end else if (state == 3'h1) begin // @[golden.scala 98:51]
      if (_T_6) begin // @[golden.scala 99:44]
        coefNum <= 2'h0; // @[golden.scala 100:15]
      end else begin
        coefNum <= _coefNum_T_1; // @[golden.scala 102:15]
      end
    end else if (state == 3'h2) begin // @[golden.scala 104:51]
      coefNum <= _GEN_10;
    end else begin
      coefNum <= 2'h0; // @[golden.scala 111:13]
    end
    if (reset) begin // @[golden.scala 68:22]
      state <= 3'h0; // @[golden.scala 68:22]
    end else if (3'h0 == state) begin // @[golden.scala 70:17]
      if (io_input_valid) begin // @[golden.scala 72:28]
        state <= 3'h1; // @[golden.scala 73:15]
      end
    end else if (3'h1 == state) begin // @[golden.scala 70:17]
      if (coefNum == 2'h3) begin // @[golden.scala 77:46]
        state <= 3'h2; // @[golden.scala 78:15]
      end
    end else if (3'h2 == state) begin // @[golden.scala 70:17]
      state <= _GEN_2;
    end else begin
      state <= _GEN_5;
    end
    if (reset) begin // @[golden.scala 114:25]
      inputReg <= 4'sh0; // @[golden.scala 114:25]
    end else if (!(state == 3'h4)) begin // @[golden.scala 122:44]
      if (_T_18) begin // @[golden.scala 124:65]
        inputReg <= io_input_bits; // @[golden.scala 125:14]
      end
    end
    if (reset) begin // @[golden.scala 116:29]
      inputMemAddr <= 2'h0; // @[golden.scala 116:29]
    end else if (_T_19 & coefNum < 2'h3) begin // @[golden.scala 131:83]
      if (inputMemAddr == 2'h2) begin // @[golden.scala 132:49]
        inputMemAddr <= 2'h0; // @[golden.scala 133:20]
      end else begin
        inputMemAddr <= _inputMemAddr_T_1; // @[golden.scala 135:20]
      end
    end
    if (reset) begin // @[golden.scala 140:30]
      outputMemAddr <= 1'h0; // @[golden.scala 140:30]
    end else if (_T_21 & coefNum < 2'h1) begin // @[golden.scala 152:85]
      if (outputMemAddr) begin // @[golden.scala 153:52]
        outputMemAddr <= 1'h0; // @[golden.scala 154:21]
      end else begin
        outputMemAddr <= outputMemAddr + 1'h1; // @[golden.scala 156:21]
      end
    end
    REG <= state; // @[golden.scala 146:52]
    inputSum <= _GEN_54[8:0]; // @[golden.scala 160:{25,25}]
    outputSum <= _GEN_56[14:0]; // @[golden.scala 161:{26,26}]
    if (reset) begin // @[golden.scala 164:27]
      multOutReg <= 14'sh0; // @[golden.scala 164:27]
    end else if (_T_18) begin // @[golden.scala 168:59]
      multOutReg <= multOut; // @[golden.scala 169:16]
    end else if (_T_19) begin // @[golden.scala 172:51]
      multOutReg <= multOut; // @[golden.scala 173:16]
    end else if (_T_21) begin // @[golden.scala 175:51]
      multOutReg <= multOut; // @[golden.scala 176:16]
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
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  _RAND_1 = {1{`RANDOM}};
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 3; initvar = initvar+1)
    inputMem[initvar] = _RAND_0[3:0];
  _RAND_2 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    outputMem[initvar] = _RAND_2[10:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  coefNum = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  state = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  inputReg = _RAND_5[3:0];
  _RAND_6 = {1{`RANDOM}};
  inputMemAddr = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  outputMemAddr = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  REG = _RAND_8[2:0];
  _RAND_9 = {1{`RANDOM}};
  inputSum = _RAND_9[8:0];
  _RAND_10 = {1{`RANDOM}};
  outputSum = _RAND_10[14:0];
  _RAND_11 = {1{`RANDOM}};
  multOutReg = _RAND_11[13:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
