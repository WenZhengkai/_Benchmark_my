module PortLogic(
  input         clock,
  input         reset,
  input         io_ena,
  input         io_we,
  input  [31:0] io_readData,
  output [31:0] io_dataOut
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] dataOutReg; // @[dut.scala 151:29]
  assign io_dataOut = dataOutReg; // @[dut.scala 157:16]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 151:29]
      dataOutReg <= 32'h0; // @[dut.scala 151:29]
    end else if (io_ena & ~io_we) begin // @[dut.scala 153:28]
      dataOutReg <= io_readData; // @[dut.scala 154:18]
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
  dataOutReg = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module dut(
  input         clock,
  input         reset,
  input         io_portAClk,
  input         io_portAEna,
  input         io_portAWe,
  input  [13:0] io_portAAddr,
  input  [31:0] io_portADataIn,
  output [31:0] io_portADataOut,
  input         io_portBClk,
  input         io_portBEna,
  input         io_portBWe,
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
`endif // RANDOMIZE_REG_INIT
  reg [31:0] mem [0:16383]; // @[dut.scala 34:24]
  wire  mem_portALogic_io_readData_MPORT_en; // @[dut.scala 34:24]
  wire [13:0] mem_portALogic_io_readData_MPORT_addr; // @[dut.scala 34:24]
  wire [31:0] mem_portALogic_io_readData_MPORT_data; // @[dut.scala 34:24]
  wire  mem_portBLogic_io_readData_MPORT_en; // @[dut.scala 34:24]
  wire [13:0] mem_portBLogic_io_readData_MPORT_addr; // @[dut.scala 34:24]
  wire [31:0] mem_portBLogic_io_readData_MPORT_data; // @[dut.scala 34:24]
  wire [31:0] mem_MPORT_data; // @[dut.scala 34:24]
  wire [13:0] mem_MPORT_addr; // @[dut.scala 34:24]
  wire  mem_MPORT_mask; // @[dut.scala 34:24]
  wire  mem_MPORT_en; // @[dut.scala 34:24]
  wire [31:0] mem_MPORT_1_data; // @[dut.scala 34:24]
  wire [13:0] mem_MPORT_1_addr; // @[dut.scala 34:24]
  wire  mem_MPORT_1_mask; // @[dut.scala 34:24]
  wire  mem_MPORT_1_en; // @[dut.scala 34:24]
  reg  mem_portALogic_io_readData_MPORT_en_pipe_0;
  reg [13:0] mem_portALogic_io_readData_MPORT_addr_pipe_0;
  reg  mem_portBLogic_io_readData_MPORT_en_pipe_0;
  reg [13:0] mem_portBLogic_io_readData_MPORT_addr_pipe_0;
  wire  portALogic_clock; // @[dut.scala 38:11]
  wire  portALogic_reset; // @[dut.scala 38:11]
  wire  portALogic_io_ena; // @[dut.scala 38:11]
  wire  portALogic_io_we; // @[dut.scala 38:11]
  wire [31:0] portALogic_io_readData; // @[dut.scala 38:11]
  wire [31:0] portALogic_io_dataOut; // @[dut.scala 38:11]
  wire  portBLogic_clock; // @[dut.scala 49:11]
  wire  portBLogic_reset; // @[dut.scala 49:11]
  wire  portBLogic_io_ena; // @[dut.scala 49:11]
  wire  portBLogic_io_we; // @[dut.scala 49:11]
  wire [31:0] portBLogic_io_readData; // @[dut.scala 49:11]
  wire [31:0] portBLogic_io_dataOut; // @[dut.scala 49:11]
  wire  _GEN_10 = io_portAWe ? 1'h0 : 1'h1; // @[dut.scala 34:24 63:24]
  wire  _GEN_30 = io_portBWe ? 1'h0 : 1'h1; // @[dut.scala 34:24 75:24]
  PortLogic portALogic ( // @[dut.scala 38:11]
    .clock(portALogic_clock),
    .reset(portALogic_reset),
    .io_ena(portALogic_io_ena),
    .io_we(portALogic_io_we),
    .io_readData(portALogic_io_readData),
    .io_dataOut(portALogic_io_dataOut)
  );
  PortLogic portBLogic ( // @[dut.scala 49:11]
    .clock(portBLogic_clock),
    .reset(portBLogic_reset),
    .io_ena(portBLogic_io_ena),
    .io_we(portBLogic_io_we),
    .io_readData(portBLogic_io_readData),
    .io_dataOut(portBLogic_io_dataOut)
  );
  assign mem_portALogic_io_readData_MPORT_en = mem_portALogic_io_readData_MPORT_en_pipe_0;
  assign mem_portALogic_io_readData_MPORT_addr = mem_portALogic_io_readData_MPORT_addr_pipe_0;
  assign mem_portALogic_io_readData_MPORT_data = mem[mem_portALogic_io_readData_MPORT_addr]; // @[dut.scala 34:24]
  assign mem_portBLogic_io_readData_MPORT_en = mem_portBLogic_io_readData_MPORT_en_pipe_0;
  assign mem_portBLogic_io_readData_MPORT_addr = mem_portBLogic_io_readData_MPORT_addr_pipe_0;
  assign mem_portBLogic_io_readData_MPORT_data = mem[mem_portBLogic_io_readData_MPORT_addr]; // @[dut.scala 34:24]
  assign mem_MPORT_data = io_portADataIn;
  assign mem_MPORT_addr = io_portAAddr;
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = io_portAEna & io_portAWe;
  assign mem_MPORT_1_data = io_portBDataIn;
  assign mem_MPORT_1_addr = io_portBAddr;
  assign mem_MPORT_1_mask = 1'h1;
  assign mem_MPORT_1_en = io_portBEna & io_portBWe;
  assign io_portADataOut = portALogic_io_dataOut; // @[dut.scala 45:19]
  assign io_portBDataOut = portBLogic_io_dataOut; // @[dut.scala 56:19]
  assign portALogic_clock = io_portAClk;
  assign portALogic_reset = reset;
  assign portALogic_io_ena = io_portAEna; // @[dut.scala 41:21]
  assign portALogic_io_we = io_portAWe; // @[dut.scala 42:20]
  assign portALogic_io_readData = mem_portALogic_io_readData_MPORT_data; // @[dut.scala 63:24 67:32]
  assign portBLogic_clock = io_portBClk;
  assign portBLogic_reset = reset;
  assign portBLogic_io_ena = io_portBEna; // @[dut.scala 52:21]
  assign portBLogic_io_we = io_portBWe; // @[dut.scala 53:20]
  assign portBLogic_io_readData = mem_portBLogic_io_readData_MPORT_data; // @[dut.scala 75:24 79:32]
  always @(posedge clock) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[dut.scala 34:24]
    end
    if (mem_MPORT_1_en & mem_MPORT_1_mask) begin
      mem[mem_MPORT_1_addr] <= mem_MPORT_1_data; // @[dut.scala 34:24]
    end
    mem_portALogic_io_readData_MPORT_en_pipe_0 <= io_portAEna & _GEN_10;
    if (io_portAEna & _GEN_10) begin
      mem_portALogic_io_readData_MPORT_addr_pipe_0 <= io_portAAddr;
    end
    mem_portBLogic_io_readData_MPORT_en_pipe_0 <= io_portBEna & _GEN_30;
    if (io_portBEna & _GEN_30) begin
      mem_portBLogic_io_readData_MPORT_addr_pipe_0 <= io_portBAddr;
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
  for (initvar = 0; initvar < 16384; initvar = initvar+1)
    mem[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem_portALogic_io_readData_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_portALogic_io_readData_MPORT_addr_pipe_0 = _RAND_2[13:0];
  _RAND_3 = {1{`RANDOM}};
  mem_portBLogic_io_readData_MPORT_en_pipe_0 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  mem_portBLogic_io_readData_MPORT_addr_pipe_0 = _RAND_4[13:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
