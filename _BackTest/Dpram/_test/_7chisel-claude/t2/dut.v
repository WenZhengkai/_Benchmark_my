module DualPortRam(
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
  reg [31:0] mem [0:16383]; // @[dut.scala 32:24]
  wire  mem_portaDataOutReg_MPORT_en; // @[dut.scala 32:24]
  wire [13:0] mem_portaDataOutReg_MPORT_addr; // @[dut.scala 32:24]
  wire [31:0] mem_portaDataOutReg_MPORT_data; // @[dut.scala 32:24]
  wire  mem_portbDataOutReg_MPORT_en; // @[dut.scala 32:24]
  wire [13:0] mem_portbDataOutReg_MPORT_addr; // @[dut.scala 32:24]
  wire [31:0] mem_portbDataOutReg_MPORT_data; // @[dut.scala 32:24]
  wire [31:0] mem_MPORT_data; // @[dut.scala 32:24]
  wire [13:0] mem_MPORT_addr; // @[dut.scala 32:24]
  wire  mem_MPORT_mask; // @[dut.scala 32:24]
  wire  mem_MPORT_en; // @[dut.scala 32:24]
  wire [31:0] mem_MPORT_1_data; // @[dut.scala 32:24]
  wire [13:0] mem_MPORT_1_addr; // @[dut.scala 32:24]
  wire  mem_MPORT_1_mask; // @[dut.scala 32:24]
  wire  mem_MPORT_1_en; // @[dut.scala 32:24]
  reg  mem_portaDataOutReg_MPORT_en_pipe_0;
  reg [13:0] mem_portaDataOutReg_MPORT_addr_pipe_0;
  reg  mem_portbDataOutReg_MPORT_en_pipe_0;
  reg [13:0] mem_portbDataOutReg_MPORT_addr_pipe_0;
  reg [31:0] portaDataOutReg; // @[dut.scala 35:32]
  reg [31:0] portbDataOutReg; // @[dut.scala 36:32]
  wire  _GEN_9 = io_portawe ? 1'h0 : 1'h1; // @[dut.scala 32:24 41:24]
  wire  _GEN_30 = io_portbwe ? 1'h0 : 1'h1; // @[dut.scala 32:24 57:26]
  assign mem_portaDataOutReg_MPORT_en = mem_portaDataOutReg_MPORT_en_pipe_0;
  assign mem_portaDataOutReg_MPORT_addr = mem_portaDataOutReg_MPORT_addr_pipe_0;
  assign mem_portaDataOutReg_MPORT_data = mem[mem_portaDataOutReg_MPORT_addr]; // @[dut.scala 32:24]
  assign mem_portbDataOutReg_MPORT_en = mem_portbDataOutReg_MPORT_en_pipe_0;
  assign mem_portbDataOutReg_MPORT_addr = mem_portbDataOutReg_MPORT_addr_pipe_0;
  assign mem_portbDataOutReg_MPORT_data = mem[mem_portbDataOutReg_MPORT_addr]; // @[dut.scala 32:24]
  assign mem_MPORT_data = io_portadatain;
  assign mem_MPORT_addr = io_portaaddr;
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = io_portaena & io_portawe;
  assign mem_MPORT_1_data = io_portbdatain;
  assign mem_MPORT_1_addr = io_portbaddr;
  assign mem_MPORT_1_mask = 1'h1;
  assign mem_MPORT_1_en = io_portbena & io_portbwe;
  assign io_portadataout = portaDataOutReg; // @[dut.scala 72:21]
  assign io_portbdataout = portbDataOutReg; // @[dut.scala 73:21]
  always @(posedge io_portaclk) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[dut.scala 32:24]
    end
    mem_portaDataOutReg_MPORT_en_pipe_0 <= io_portaena & _GEN_9;
    if (io_portaena & _GEN_9) begin
      mem_portaDataOutReg_MPORT_addr_pipe_0 <= io_portaaddr;
    end
  end
  always @(posedge io_portbclk) begin
    if (mem_MPORT_1_en & mem_MPORT_1_mask) begin
      mem[mem_MPORT_1_addr] <= mem_MPORT_1_data; // @[dut.scala 32:24]
    end
    mem_portbDataOutReg_MPORT_en_pipe_0 <= io_portbena & _GEN_30;
    if (io_portbena & _GEN_30) begin
      mem_portbDataOutReg_MPORT_addr_pipe_0 <= io_portbaddr;
    end
  end
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 35:32]
      portaDataOutReg <= 32'h0; // @[dut.scala 35:32]
    end else if (io_portaena) begin // @[dut.scala 40:23]
      if (!(io_portawe)) begin // @[dut.scala 41:24]
        portaDataOutReg <= mem_portaDataOutReg_MPORT_data; // @[dut.scala 47:27]
      end
    end
    if (reset) begin // @[dut.scala 36:32]
      portbDataOutReg <= 32'h0; // @[dut.scala 36:32]
    end else if (io_portbena) begin // @[dut.scala 56:25]
      if (!(io_portbwe)) begin // @[dut.scala 57:26]
        portbDataOutReg <= mem_portbDataOutReg_MPORT_data; // @[dut.scala 63:29]
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
  mem_portaDataOutReg_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_portaDataOutReg_MPORT_addr_pipe_0 = _RAND_2[13:0];
  _RAND_3 = {1{`RANDOM}};
  mem_portbDataOutReg_MPORT_en_pipe_0 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  mem_portbDataOutReg_MPORT_addr_pipe_0 = _RAND_4[13:0];
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
module dut(
  input         clock,
  input         reset,
  input         io_portaena,
  input         io_portawe,
  input  [13:0] io_portaaddr,
  input  [31:0] io_portadatain,
  output [31:0] io_portadataout,
  input         io_portbena,
  input         io_portbwe,
  input  [13:0] io_portbaddr,
  input  [31:0] io_portbdatain,
  output [31:0] io_portbdataout
);
  wire  ram_clock; // @[dut.scala 120:19]
  wire  ram_reset; // @[dut.scala 120:19]
  wire  ram_io_portaclk; // @[dut.scala 120:19]
  wire  ram_io_portaena; // @[dut.scala 120:19]
  wire  ram_io_portawe; // @[dut.scala 120:19]
  wire [13:0] ram_io_portaaddr; // @[dut.scala 120:19]
  wire [31:0] ram_io_portadatain; // @[dut.scala 120:19]
  wire [31:0] ram_io_portadataout; // @[dut.scala 120:19]
  wire  ram_io_portbclk; // @[dut.scala 120:19]
  wire  ram_io_portbena; // @[dut.scala 120:19]
  wire  ram_io_portbwe; // @[dut.scala 120:19]
  wire [13:0] ram_io_portbaddr; // @[dut.scala 120:19]
  wire [31:0] ram_io_portbdatain; // @[dut.scala 120:19]
  wire [31:0] ram_io_portbdataout; // @[dut.scala 120:19]
  DualPortRam ram ( // @[dut.scala 120:19]
    .clock(ram_clock),
    .reset(ram_reset),
    .io_portaclk(ram_io_portaclk),
    .io_portaena(ram_io_portaena),
    .io_portawe(ram_io_portawe),
    .io_portaaddr(ram_io_portaaddr),
    .io_portadatain(ram_io_portadatain),
    .io_portadataout(ram_io_portadataout),
    .io_portbclk(ram_io_portbclk),
    .io_portbena(ram_io_portbena),
    .io_portbwe(ram_io_portbwe),
    .io_portbaddr(ram_io_portbaddr),
    .io_portbdatain(ram_io_portbdatain),
    .io_portbdataout(ram_io_portbdataout)
  );
  assign io_portadataout = ram_io_portadataout; // @[dut.scala 134:19]
  assign io_portbdataout = ram_io_portbdataout; // @[dut.scala 141:19]
  assign ram_clock = clock;
  assign ram_reset = reset;
  assign ram_io_portaclk = clock; // @[dut.scala 129:19]
  assign ram_io_portaena = io_portaena; // @[dut.scala 130:19]
  assign ram_io_portawe = io_portawe; // @[dut.scala 131:18]
  assign ram_io_portaaddr = io_portaaddr; // @[dut.scala 132:20]
  assign ram_io_portadatain = io_portadatain; // @[dut.scala 133:22]
  assign ram_io_portbclk = clock; // @[dut.scala 136:19]
  assign ram_io_portbena = io_portbena; // @[dut.scala 137:19]
  assign ram_io_portbwe = io_portbwe; // @[dut.scala 138:18]
  assign ram_io_portbaddr = io_portbaddr; // @[dut.scala 139:20]
  assign ram_io_portbdatain = io_portbdatain; // @[dut.scala 140:22]
endmodule
