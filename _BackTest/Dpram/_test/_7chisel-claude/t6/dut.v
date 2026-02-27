module dut(
  input         clock,
  input         reset,
  input         io_portAEnable,
  input         io_portAWrite,
  input  [13:0] io_portAAddr,
  input  [31:0] io_portADataIn,
  output [31:0] io_portADataOut,
  input         io_portBEnable,
  input         io_portBWrite,
  input  [13:0] io_portBAddr,
  input  [31:0] io_portBDataIn,
  output [31:0] io_portBDataOut
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] mem [0:16383]; // @[dut.scala 30:24]
  wire  mem_readData_en; // @[dut.scala 30:24]
  wire [13:0] mem_readData_addr; // @[dut.scala 30:24]
  wire [31:0] mem_readData_data; // @[dut.scala 30:24]
  wire  mem_readData_1_en; // @[dut.scala 30:24]
  wire [13:0] mem_readData_1_addr; // @[dut.scala 30:24]
  wire [31:0] mem_readData_1_data; // @[dut.scala 30:24]
  wire [31:0] mem_MPORT_data; // @[dut.scala 30:24]
  wire [13:0] mem_MPORT_addr; // @[dut.scala 30:24]
  wire  mem_MPORT_mask; // @[dut.scala 30:24]
  wire  mem_MPORT_en; // @[dut.scala 30:24]
  wire [31:0] mem_MPORT_1_data; // @[dut.scala 30:24]
  wire [13:0] mem_MPORT_1_addr; // @[dut.scala 30:24]
  wire  mem_MPORT_1_mask; // @[dut.scala 30:24]
  wire  mem_MPORT_1_en; // @[dut.scala 30:24]
  reg  mem_readData_en_pipe_0;
  reg [13:0] mem_readData_addr_pipe_0;
  reg  mem_readData_1_en_pipe_0;
  reg [13:0] mem_readData_1_addr_pipe_0;
  reg [31:0] portADataOutReg; // @[dut.scala 33:32]
  reg [31:0] portBDataOutReg; // @[dut.scala 36:32]
  wire [31:0] _GEN_9 = mem_readData_data; // @[dut.scala 40:25 51:25]
  wire  _GEN_10 = io_portAWrite ? 1'h0 : 1'h1; // @[dut.scala 30:24 40:25]
  wire [31:0] _GEN_29 = mem_readData_1_data; // @[dut.scala 61:27 72:27]
  wire  _GEN_30 = io_portBWrite ? 1'h0 : 1'h1; // @[dut.scala 30:24 61:27]
  wire  _T_3 = io_portAWrite | io_portBWrite; // @[dut.scala 92:23]
  wire  _T_4 = io_portAEnable & io_portBEnable & io_portAAddr == io_portBAddr & _T_3; // @[dut.scala 91:74]
  assign mem_readData_en = mem_readData_en_pipe_0;
  assign mem_readData_addr = mem_readData_addr_pipe_0;
  assign mem_readData_data = mem[mem_readData_addr]; // @[dut.scala 30:24]
  assign mem_readData_1_en = mem_readData_1_en_pipe_0;
  assign mem_readData_1_addr = mem_readData_1_addr_pipe_0;
  assign mem_readData_1_data = mem[mem_readData_1_addr]; // @[dut.scala 30:24]
  assign mem_MPORT_data = io_portADataIn;
  assign mem_MPORT_addr = io_portAAddr;
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = io_portAEnable & io_portAWrite;
  assign mem_MPORT_1_data = io_portBDataIn;
  assign mem_MPORT_1_addr = io_portBAddr;
  assign mem_MPORT_1_mask = 1'h1;
  assign mem_MPORT_1_en = io_portBEnable & io_portBWrite;
  assign io_portADataOut = portADataOutReg; // @[dut.scala 85:21]
  assign io_portBDataOut = portBDataOutReg; // @[dut.scala 86:21]
  always @(posedge clock) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[dut.scala 30:24]
    end
    if (mem_MPORT_1_en & mem_MPORT_1_mask) begin
      mem[mem_MPORT_1_addr] <= mem_MPORT_1_data; // @[dut.scala 30:24]
    end
    mem_readData_en_pipe_0 <= io_portAEnable & _GEN_10;
    if (io_portAEnable & _GEN_10) begin
      mem_readData_addr_pipe_0 <= io_portAAddr;
    end
    mem_readData_1_en_pipe_0 <= io_portBEnable & _GEN_30;
    if (io_portBEnable & _GEN_30) begin
      mem_readData_1_addr_pipe_0 <= io_portBAddr;
    end
    if (reset) begin // @[dut.scala 33:32]
      portADataOutReg <= 32'h0; // @[dut.scala 33:32]
    end else if (io_portAEnable) begin // @[dut.scala 39:24]
      portADataOutReg <= _GEN_9;
    end
    if (reset) begin // @[dut.scala 36:32]
      portBDataOutReg <= 32'h0; // @[dut.scala 36:32]
    end else if (io_portBEnable) begin // @[dut.scala 60:26]
      portBDataOutReg <= _GEN_29;
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_4 & ~reset) begin
          $fwrite(32'h80000002,"Warning: Potential read/write collision detected at address %d\n",io_portAAddr); // @[dut.scala 93:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
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
  for (initvar = 0; initvar < 16384; initvar = initvar+1)
    mem[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem_readData_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_readData_addr_pipe_0 = _RAND_2[13:0];
  _RAND_3 = {1{`RANDOM}};
  mem_readData_1_en_pipe_0 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  mem_readData_1_addr_pipe_0 = _RAND_4[13:0];
  _RAND_5 = {1{`RANDOM}};
  portADataOutReg = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  portBDataOutReg = _RAND_6[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
