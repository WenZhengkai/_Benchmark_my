module dut(
  input         clock,
  input         reset,
  input         io_portaClk,
  input         io_portaWE,
  input         io_portaEnA,
  input  [13:0] io_portaAddr,
  input  [31:0] io_portaDataIn,
  output [31:0] io_portaDataOut,
  input         io_portbClk,
  input         io_portbWE,
  input         io_portbEnA,
  input  [13:0] io_portbAddr,
  input  [31:0] io_portbDataIn,
  output [31:0] io_portbDataOut
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
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] mem [0:16383]; // @[dut.scala 37:24]
  wire  mem_portaReg_MPORT_en; // @[dut.scala 37:24]
  wire [13:0] mem_portaReg_MPORT_addr; // @[dut.scala 37:24]
  wire [31:0] mem_portaReg_MPORT_data; // @[dut.scala 37:24]
  wire  mem_io_portaDataOut_MPORT_en; // @[dut.scala 37:24]
  wire [13:0] mem_io_portaDataOut_MPORT_addr; // @[dut.scala 37:24]
  wire [31:0] mem_io_portaDataOut_MPORT_data; // @[dut.scala 37:24]
  wire  mem_portbReg_MPORT_en; // @[dut.scala 37:24]
  wire [13:0] mem_portbReg_MPORT_addr; // @[dut.scala 37:24]
  wire [31:0] mem_portbReg_MPORT_data; // @[dut.scala 37:24]
  wire  mem_io_portbDataOut_MPORT_en; // @[dut.scala 37:24]
  wire [13:0] mem_io_portbDataOut_MPORT_addr; // @[dut.scala 37:24]
  wire [31:0] mem_io_portbDataOut_MPORT_data; // @[dut.scala 37:24]
  wire [31:0] mem_MPORT_data; // @[dut.scala 37:24]
  wire [13:0] mem_MPORT_addr; // @[dut.scala 37:24]
  wire  mem_MPORT_mask; // @[dut.scala 37:24]
  wire  mem_MPORT_en; // @[dut.scala 37:24]
  wire [31:0] mem_MPORT_1_data; // @[dut.scala 37:24]
  wire [13:0] mem_MPORT_1_addr; // @[dut.scala 37:24]
  wire  mem_MPORT_1_mask; // @[dut.scala 37:24]
  wire  mem_MPORT_1_en; // @[dut.scala 37:24]
  reg  mem_portaReg_MPORT_en_pipe_0;
  reg [13:0] mem_portaReg_MPORT_addr_pipe_0;
  reg  mem_io_portaDataOut_MPORT_en_pipe_0;
  reg [13:0] mem_io_portaDataOut_MPORT_addr_pipe_0;
  reg  mem_portbReg_MPORT_en_pipe_0;
  reg [13:0] mem_portbReg_MPORT_addr_pipe_0;
  reg  mem_io_portbDataOut_MPORT_en_pipe_0;
  reg [13:0] mem_io_portbDataOut_MPORT_addr_pipe_0;
  reg [31:0] portaReg; // @[dut.scala 41:23]
  wire  _portaReg_T = ~io_portaWE; // @[dut.scala 48:42]
  reg [31:0] portbReg; // @[dut.scala 55:23]
  wire  _portbReg_T = ~io_portbWE; // @[dut.scala 62:42]
  assign mem_portaReg_MPORT_en = mem_portaReg_MPORT_en_pipe_0;
  assign mem_portaReg_MPORT_addr = mem_portaReg_MPORT_addr_pipe_0;
  assign mem_portaReg_MPORT_data = mem[mem_portaReg_MPORT_addr]; // @[dut.scala 37:24]
  assign mem_io_portaDataOut_MPORT_en = mem_io_portaDataOut_MPORT_en_pipe_0;
  assign mem_io_portaDataOut_MPORT_addr = mem_io_portaDataOut_MPORT_addr_pipe_0;
  assign mem_io_portaDataOut_MPORT_data = mem[mem_io_portaDataOut_MPORT_addr]; // @[dut.scala 37:24]
  assign mem_portbReg_MPORT_en = mem_portbReg_MPORT_en_pipe_0;
  assign mem_portbReg_MPORT_addr = mem_portbReg_MPORT_addr_pipe_0;
  assign mem_portbReg_MPORT_data = mem[mem_portbReg_MPORT_addr]; // @[dut.scala 37:24]
  assign mem_io_portbDataOut_MPORT_en = mem_io_portbDataOut_MPORT_en_pipe_0;
  assign mem_io_portbDataOut_MPORT_addr = mem_io_portbDataOut_MPORT_addr_pipe_0;
  assign mem_io_portbDataOut_MPORT_data = mem[mem_io_portbDataOut_MPORT_addr]; // @[dut.scala 37:24]
  assign mem_MPORT_data = io_portaDataIn;
  assign mem_MPORT_addr = io_portaAddr;
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = io_portaEnA & io_portaWE;
  assign mem_MPORT_1_data = io_portbDataIn;
  assign mem_MPORT_1_addr = io_portbAddr;
  assign mem_MPORT_1_mask = 1'h1;
  assign mem_MPORT_1_en = io_portbEnA & io_portbWE;
  assign io_portaDataOut = portaReg; // @[dut.scala 50:27]
  assign io_portbDataOut = portbReg; // @[dut.scala 64:27]
  always @(posedge io_portaClk) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[dut.scala 37:24]
    end
    mem_portaReg_MPORT_en_pipe_0 <= io_portaEnA & _portaReg_T;
    if (io_portaEnA & _portaReg_T) begin
      mem_portaReg_MPORT_addr_pipe_0 <= io_portaAddr;
    end
    mem_io_portaDataOut_MPORT_en_pipe_0 <= ~io_portaWE;
    if (~io_portaWE) begin
      mem_io_portaDataOut_MPORT_addr_pipe_0 <= io_portaAddr;
    end
    if (io_portaEnA) begin // @[dut.scala 42:23]
      portaReg <= mem_portaReg_MPORT_data; // @[dut.scala 48:16]
    end
  end
  always @(posedge io_portbClk) begin
    if (mem_MPORT_1_en & mem_MPORT_1_mask) begin
      mem[mem_MPORT_1_addr] <= mem_MPORT_1_data; // @[dut.scala 37:24]
    end
    mem_portbReg_MPORT_en_pipe_0 <= io_portbEnA & _portbReg_T;
    if (io_portbEnA & _portbReg_T) begin
      mem_portbReg_MPORT_addr_pipe_0 <= io_portbAddr;
    end
    mem_io_portbDataOut_MPORT_en_pipe_0 <= ~io_portbWE;
    if (~io_portbWE) begin
      mem_io_portbDataOut_MPORT_addr_pipe_0 <= io_portbAddr;
    end
    if (io_portbEnA) begin // @[dut.scala 56:23]
      portbReg <= mem_portbReg_MPORT_data; // @[dut.scala 62:16]
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
  mem_portaReg_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_portaReg_MPORT_addr_pipe_0 = _RAND_2[13:0];
  _RAND_3 = {1{`RANDOM}};
  mem_io_portaDataOut_MPORT_en_pipe_0 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  mem_io_portaDataOut_MPORT_addr_pipe_0 = _RAND_4[13:0];
  _RAND_5 = {1{`RANDOM}};
  mem_portbReg_MPORT_en_pipe_0 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  mem_portbReg_MPORT_addr_pipe_0 = _RAND_6[13:0];
  _RAND_7 = {1{`RANDOM}};
  mem_io_portbDataOut_MPORT_en_pipe_0 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  mem_io_portbDataOut_MPORT_addr_pipe_0 = _RAND_8[13:0];
  _RAND_9 = {1{`RANDOM}};
  portaReg = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  portbReg = _RAND_10[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
