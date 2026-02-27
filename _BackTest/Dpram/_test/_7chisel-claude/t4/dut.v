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
  reg [31:0] mem [0:16383]; // @[dut.scala 33:24]
  wire  mem_readData_en; // @[dut.scala 33:24]
  wire [13:0] mem_readData_addr; // @[dut.scala 33:24]
  wire [31:0] mem_readData_data; // @[dut.scala 33:24]
  wire  mem_readData_1_en; // @[dut.scala 33:24]
  wire [13:0] mem_readData_1_addr; // @[dut.scala 33:24]
  wire [31:0] mem_readData_1_data; // @[dut.scala 33:24]
  wire [31:0] mem_MPORT_data; // @[dut.scala 33:24]
  wire [13:0] mem_MPORT_addr; // @[dut.scala 33:24]
  wire  mem_MPORT_mask; // @[dut.scala 33:24]
  wire  mem_MPORT_en; // @[dut.scala 33:24]
  wire [31:0] mem_MPORT_1_data; // @[dut.scala 33:24]
  wire [13:0] mem_MPORT_1_addr; // @[dut.scala 33:24]
  wire  mem_MPORT_1_mask; // @[dut.scala 33:24]
  wire  mem_MPORT_1_en; // @[dut.scala 33:24]
  reg  mem_readData_en_pipe_0;
  reg [13:0] mem_readData_addr_pipe_0;
  reg  mem_readData_1_en_pipe_0;
  reg [13:0] mem_readData_1_addr_pipe_0;
  reg [31:0] portaDataOutReg; // @[dut.scala 36:32]
  wire  _GEN_9 = io_portawe ? 1'h0 : 1'h1; // @[dut.scala 33:24 40:24]
  reg [31:0] portbDataOutReg; // @[dut.scala 55:32]
  wire  _GEN_30 = io_portbwe ? 1'h0 : 1'h1; // @[dut.scala 33:24 59:24]
  assign mem_readData_en = mem_readData_en_pipe_0;
  assign mem_readData_addr = mem_readData_addr_pipe_0;
  assign mem_readData_data = mem[mem_readData_addr]; // @[dut.scala 33:24]
  assign mem_readData_1_en = mem_readData_1_en_pipe_0;
  assign mem_readData_1_addr = mem_readData_1_addr_pipe_0;
  assign mem_readData_1_data = mem[mem_readData_1_addr]; // @[dut.scala 33:24]
  assign mem_MPORT_data = io_portadatain;
  assign mem_MPORT_addr = io_portaaddr;
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = io_portaena & io_portawe;
  assign mem_MPORT_1_data = io_portbdatain;
  assign mem_MPORT_1_addr = io_portbaddr;
  assign mem_MPORT_1_mask = 1'h1;
  assign mem_MPORT_1_en = io_portbena & io_portbwe;
  assign io_portadataout = portaDataOutReg; // @[dut.scala 75:21]
  assign io_portbdataout = portbDataOutReg; // @[dut.scala 76:21]
  always @(posedge io_portaclk) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[dut.scala 33:24]
    end
    mem_readData_en_pipe_0 <= io_portaena & _GEN_9;
    if (io_portaena & _GEN_9) begin
      mem_readData_addr_pipe_0 <= io_portaaddr;
    end
  end
  always @(posedge io_portbclk) begin
    if (mem_MPORT_1_en & mem_MPORT_1_mask) begin
      mem[mem_MPORT_1_addr] <= mem_MPORT_1_data; // @[dut.scala 33:24]
    end
    mem_readData_1_en_pipe_0 <= io_portbena & _GEN_30;
    if (io_portbena & _GEN_30) begin
      mem_readData_1_addr_pipe_0 <= io_portbaddr;
    end
  end
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 36:32]
      portaDataOutReg <= 32'h0; // @[dut.scala 36:32]
    end else if (io_portaena) begin // @[dut.scala 39:23]
      if (!(io_portawe)) begin // @[dut.scala 40:24]
        portaDataOutReg <= mem_readData_data; // @[dut.scala 46:27]
      end
    end
    if (reset) begin // @[dut.scala 55:32]
      portbDataOutReg <= 32'h0; // @[dut.scala 55:32]
    end else if (io_portbena) begin // @[dut.scala 58:23]
      if (!(io_portbwe)) begin // @[dut.scala 59:24]
        portbDataOutReg <= mem_readData_1_data; // @[dut.scala 65:27]
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
  portaDataOutReg = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  portbDataOutReg = _RAND_6[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
