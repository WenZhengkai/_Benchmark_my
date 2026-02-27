module DualPortRam(
  input         io_portaclk,
  input         io_portaena,
  input         io_portawe,
  input  [13:0] io_portaaddr,
  input  [31:0] io_portadatain,
  output [31:0] io_portadataout,
  input         io_portbclk,
  input         io_portbena,
  input         io_portbwe,
  input  [13:0] io_portbaddr,
  input  [31:0] io_portbdatain,
  output [31:0] io_portbdataout
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
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] memory [0:16383]; // @[dut.scala 34:27]
  wire  memory_portaClockDomain_portaDataOut_MPORT_en; // @[dut.scala 34:27]
  wire [13:0] memory_portaClockDomain_portaDataOut_MPORT_addr; // @[dut.scala 34:27]
  wire [31:0] memory_portaClockDomain_portaDataOut_MPORT_data; // @[dut.scala 34:27]
  wire  memory_portaClockDomain_portaDataOut_MPORT_1_en; // @[dut.scala 34:27]
  wire [13:0] memory_portaClockDomain_portaDataOut_MPORT_1_addr; // @[dut.scala 34:27]
  wire [31:0] memory_portaClockDomain_portaDataOut_MPORT_1_data; // @[dut.scala 34:27]
  wire  memory_portbClockDomain_portbDataOut_MPORT_en; // @[dut.scala 34:27]
  wire [13:0] memory_portbClockDomain_portbDataOut_MPORT_addr; // @[dut.scala 34:27]
  wire [31:0] memory_portbClockDomain_portbDataOut_MPORT_data; // @[dut.scala 34:27]
  wire  memory_portbClockDomain_portbDataOut_MPORT_1_en; // @[dut.scala 34:27]
  wire [13:0] memory_portbClockDomain_portbDataOut_MPORT_1_addr; // @[dut.scala 34:27]
  wire [31:0] memory_portbClockDomain_portbDataOut_MPORT_1_data; // @[dut.scala 34:27]
  wire [31:0] memory_portaClockDomain_MPORT_data; // @[dut.scala 34:27]
  wire [13:0] memory_portaClockDomain_MPORT_addr; // @[dut.scala 34:27]
  wire  memory_portaClockDomain_MPORT_mask; // @[dut.scala 34:27]
  wire  memory_portaClockDomain_MPORT_en; // @[dut.scala 34:27]
  wire [31:0] memory_portbClockDomain_MPORT_data; // @[dut.scala 34:27]
  wire [13:0] memory_portbClockDomain_MPORT_addr; // @[dut.scala 34:27]
  wire  memory_portbClockDomain_MPORT_mask; // @[dut.scala 34:27]
  wire  memory_portbClockDomain_MPORT_en; // @[dut.scala 34:27]
  reg  memory_portaClockDomain_portaDataOut_MPORT_en_pipe_0;
  reg [13:0] memory_portaClockDomain_portaDataOut_MPORT_addr_pipe_0;
  reg  memory_portaClockDomain_portaDataOut_MPORT_1_en_pipe_0;
  reg [13:0] memory_portaClockDomain_portaDataOut_MPORT_1_addr_pipe_0;
  reg  memory_portbClockDomain_portbDataOut_MPORT_en_pipe_0;
  reg [13:0] memory_portbClockDomain_portbDataOut_MPORT_addr_pipe_0;
  reg  memory_portbClockDomain_portbDataOut_MPORT_1_en_pipe_0;
  reg [13:0] memory_portbClockDomain_portbDataOut_MPORT_1_addr_pipe_0;
  wire  _GEN_14 = io_portawe ? 1'h0 : 1'h1; // @[dut.scala 42:25 34:27]
  reg [31:0] portaClockDomain_portaOutput_outReg; // @[dut.scala 59:27]
  reg  portaClockDomain_portaOutput_enableReg; // @[dut.scala 60:30]
  wire  _GEN_42 = io_portbwe ? 1'h0 : 1'h1; // @[dut.scala 75:25 34:27]
  reg [31:0] portbClockDomain_portbOutput_outReg; // @[dut.scala 94:27]
  reg  portbClockDomain_portbOutput_enableReg; // @[dut.scala 95:30]
  assign memory_portaClockDomain_portaDataOut_MPORT_en = memory_portaClockDomain_portaDataOut_MPORT_en_pipe_0;
  assign memory_portaClockDomain_portaDataOut_MPORT_addr = memory_portaClockDomain_portaDataOut_MPORT_addr_pipe_0;
  assign memory_portaClockDomain_portaDataOut_MPORT_data = memory[memory_portaClockDomain_portaDataOut_MPORT_addr]; // @[dut.scala 34:27]
  assign memory_portaClockDomain_portaDataOut_MPORT_1_en = memory_portaClockDomain_portaDataOut_MPORT_1_en_pipe_0;
  assign memory_portaClockDomain_portaDataOut_MPORT_1_addr = memory_portaClockDomain_portaDataOut_MPORT_1_addr_pipe_0;
  assign memory_portaClockDomain_portaDataOut_MPORT_1_data = memory[memory_portaClockDomain_portaDataOut_MPORT_1_addr]; // @[dut.scala 34:27]
  assign memory_portbClockDomain_portbDataOut_MPORT_en = memory_portbClockDomain_portbDataOut_MPORT_en_pipe_0;
  assign memory_portbClockDomain_portbDataOut_MPORT_addr = memory_portbClockDomain_portbDataOut_MPORT_addr_pipe_0;
  assign memory_portbClockDomain_portbDataOut_MPORT_data = memory[memory_portbClockDomain_portbDataOut_MPORT_addr]; // @[dut.scala 34:27]
  assign memory_portbClockDomain_portbDataOut_MPORT_1_en = memory_portbClockDomain_portbDataOut_MPORT_1_en_pipe_0;
  assign memory_portbClockDomain_portbDataOut_MPORT_1_addr = memory_portbClockDomain_portbDataOut_MPORT_1_addr_pipe_0;
  assign memory_portbClockDomain_portbDataOut_MPORT_1_data = memory[memory_portbClockDomain_portbDataOut_MPORT_1_addr]; // @[dut.scala 34:27]
  assign memory_portaClockDomain_MPORT_data = io_portadatain;
  assign memory_portaClockDomain_MPORT_addr = io_portaaddr;
  assign memory_portaClockDomain_MPORT_mask = 1'h1;
  assign memory_portaClockDomain_MPORT_en = io_portaena & io_portawe;
  assign memory_portbClockDomain_MPORT_data = io_portbdatain;
  assign memory_portbClockDomain_MPORT_addr = io_portbaddr;
  assign memory_portbClockDomain_MPORT_mask = 1'h1;
  assign memory_portbClockDomain_MPORT_en = io_portbena & io_portbwe;
  assign io_portadataout = portaClockDomain_portaOutput_enableReg ? portaClockDomain_portaOutput_outReg : 32'h0; // @[dut.scala 61:10]
  assign io_portbdataout = portbClockDomain_portbOutput_enableReg ? portbClockDomain_portbOutput_outReg : 32'h0; // @[dut.scala 96:10]
  always @(posedge io_portaclk) begin
    if (memory_portaClockDomain_MPORT_en & memory_portaClockDomain_MPORT_mask) begin
      memory[memory_portaClockDomain_MPORT_addr] <= memory_portaClockDomain_MPORT_data; // @[dut.scala 34:27]
    end
    memory_portaClockDomain_portaDataOut_MPORT_en_pipe_0 <= io_portaena & io_portawe;
    if (io_portaena & io_portawe) begin
      memory_portaClockDomain_portaDataOut_MPORT_addr_pipe_0 <= io_portaaddr;
    end
    memory_portaClockDomain_portaDataOut_MPORT_1_en_pipe_0 <= io_portaena & _GEN_14;
    if (io_portaena & _GEN_14) begin
      memory_portaClockDomain_portaDataOut_MPORT_1_addr_pipe_0 <= io_portaaddr;
    end
    if (io_portawe) begin // @[dut.scala 42:25]
      portaClockDomain_portaOutput_outReg <= memory_portaClockDomain_portaDataOut_MPORT_data; // @[dut.scala 46:24]
    end else begin
      portaClockDomain_portaOutput_outReg <= memory_portaClockDomain_portaDataOut_MPORT_1_data; // @[dut.scala 51:22]
    end
    portaClockDomain_portaOutput_enableReg <= io_portaena; // @[dut.scala 60:30]
  end
  always @(posedge io_portbclk) begin
    if (memory_portbClockDomain_MPORT_en & memory_portbClockDomain_MPORT_mask) begin
      memory[memory_portbClockDomain_MPORT_addr] <= memory_portbClockDomain_MPORT_data; // @[dut.scala 34:27]
    end
    memory_portbClockDomain_portbDataOut_MPORT_en_pipe_0 <= io_portbena & io_portbwe;
    if (io_portbena & io_portbwe) begin
      memory_portbClockDomain_portbDataOut_MPORT_addr_pipe_0 <= io_portbaddr;
    end
    memory_portbClockDomain_portbDataOut_MPORT_1_en_pipe_0 <= io_portbena & _GEN_42;
    if (io_portbena & _GEN_42) begin
      memory_portbClockDomain_portbDataOut_MPORT_1_addr_pipe_0 <= io_portbaddr;
    end
    if (io_portbwe) begin // @[dut.scala 75:25]
      portbClockDomain_portbOutput_outReg <= memory_portbClockDomain_portbDataOut_MPORT_data; // @[dut.scala 81:24]
    end else begin
      portbClockDomain_portbOutput_outReg <= memory_portbClockDomain_portbDataOut_MPORT_1_data; // @[dut.scala 86:22]
    end
    portbClockDomain_portbOutput_enableReg <= io_portbena; // @[dut.scala 95:30]
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
    memory[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  memory_portaClockDomain_portaDataOut_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  memory_portaClockDomain_portaDataOut_MPORT_addr_pipe_0 = _RAND_2[13:0];
  _RAND_3 = {1{`RANDOM}};
  memory_portaClockDomain_portaDataOut_MPORT_1_en_pipe_0 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  memory_portaClockDomain_portaDataOut_MPORT_1_addr_pipe_0 = _RAND_4[13:0];
  _RAND_5 = {1{`RANDOM}};
  memory_portbClockDomain_portbDataOut_MPORT_en_pipe_0 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  memory_portbClockDomain_portbDataOut_MPORT_addr_pipe_0 = _RAND_6[13:0];
  _RAND_7 = {1{`RANDOM}};
  memory_portbClockDomain_portbDataOut_MPORT_1_en_pipe_0 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  memory_portbClockDomain_portbDataOut_MPORT_1_addr_pipe_0 = _RAND_8[13:0];
  _RAND_9 = {1{`RANDOM}};
  portaClockDomain_portaOutput_outReg = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  portaClockDomain_portaOutput_enableReg = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  portbClockDomain_portbOutput_outReg = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  portbClockDomain_portbOutput_enableReg = _RAND_12[0:0];
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
  input         io_portaclk,
  input         io_portaena,
  input         io_portawe,
  input  [13:0] io_portaaddr,
  input  [31:0] io_portadatain,
  output [31:0] io_portadataout,
  input         io_portbclk,
  input         io_portbena,
  input         io_portbwe,
  input  [13:0] io_portbaddr,
  input  [31:0] io_portbdatain,
  output [31:0] io_portbdataout
);
  wire  dpram_io_portaclk; // @[dut.scala 140:21]
  wire  dpram_io_portaena; // @[dut.scala 140:21]
  wire  dpram_io_portawe; // @[dut.scala 140:21]
  wire [13:0] dpram_io_portaaddr; // @[dut.scala 140:21]
  wire [31:0] dpram_io_portadatain; // @[dut.scala 140:21]
  wire [31:0] dpram_io_portadataout; // @[dut.scala 140:21]
  wire  dpram_io_portbclk; // @[dut.scala 140:21]
  wire  dpram_io_portbena; // @[dut.scala 140:21]
  wire  dpram_io_portbwe; // @[dut.scala 140:21]
  wire [13:0] dpram_io_portbaddr; // @[dut.scala 140:21]
  wire [31:0] dpram_io_portbdatain; // @[dut.scala 140:21]
  wire [31:0] dpram_io_portbdataout; // @[dut.scala 140:21]
  DualPortRam dpram ( // @[dut.scala 140:21]
    .io_portaclk(dpram_io_portaclk),
    .io_portaena(dpram_io_portaena),
    .io_portawe(dpram_io_portawe),
    .io_portaaddr(dpram_io_portaaddr),
    .io_portadatain(dpram_io_portadatain),
    .io_portadataout(dpram_io_portadataout),
    .io_portbclk(dpram_io_portbclk),
    .io_portbena(dpram_io_portbena),
    .io_portbwe(dpram_io_portbwe),
    .io_portbaddr(dpram_io_portbaddr),
    .io_portbdatain(dpram_io_portbdatain),
    .io_portbdataout(dpram_io_portbdataout)
  );
  assign io_portadataout = dpram_io_portadataout; // @[dut.scala 155:19]
  assign io_portbdataout = dpram_io_portbdataout; // @[dut.scala 162:19]
  assign dpram_io_portaclk = io_portaclk; // @[dut.scala 150:21]
  assign dpram_io_portaena = io_portaena; // @[dut.scala 151:21]
  assign dpram_io_portawe = io_portawe; // @[dut.scala 152:20]
  assign dpram_io_portaaddr = io_portaaddr; // @[dut.scala 153:22]
  assign dpram_io_portadatain = io_portadatain; // @[dut.scala 154:24]
  assign dpram_io_portbclk = io_portbclk; // @[dut.scala 157:21]
  assign dpram_io_portbena = io_portbena; // @[dut.scala 158:21]
  assign dpram_io_portbwe = io_portbwe; // @[dut.scala 159:20]
  assign dpram_io_portbaddr = io_portbaddr; // @[dut.scala 160:22]
  assign dpram_io_portbdatain = io_portbdatain; // @[dut.scala 161:24]
endmodule
