module dut(
  input         clock,
  input         reset,
  input         io_portawe,
  input         io_portbwe,
  input         io_portaena,
  input         io_portbena,
  input         io_portaclk,
  input         io_portbclk,
  input  [31:0] io_portadatain,
  input  [31:0] io_portbdatain,
  input  [13:0] io_portaaddr,
  input  [13:0] io_portbaddr,
  output [31:0] io_portadataout,
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
  reg [31:0] dpram [0:16383]; // @[dut.scala 31:26]
  wire  dpram_readDataA_MPORT_en; // @[dut.scala 31:26]
  wire [13:0] dpram_readDataA_MPORT_addr; // @[dut.scala 31:26]
  wire [31:0] dpram_readDataA_MPORT_data; // @[dut.scala 31:26]
  wire  dpram_readDataB_MPORT_en; // @[dut.scala 31:26]
  wire [13:0] dpram_readDataB_MPORT_addr; // @[dut.scala 31:26]
  wire [31:0] dpram_readDataB_MPORT_data; // @[dut.scala 31:26]
  wire [31:0] dpram_MPORT_data; // @[dut.scala 31:26]
  wire [13:0] dpram_MPORT_addr; // @[dut.scala 31:26]
  wire  dpram_MPORT_mask; // @[dut.scala 31:26]
  wire  dpram_MPORT_en; // @[dut.scala 31:26]
  wire [31:0] dpram_MPORT_1_data; // @[dut.scala 31:26]
  wire [13:0] dpram_MPORT_1_addr; // @[dut.scala 31:26]
  wire  dpram_MPORT_1_mask; // @[dut.scala 31:26]
  wire  dpram_MPORT_1_en; // @[dut.scala 31:26]
  reg  dpram_readDataA_MPORT_en_pipe_0;
  reg [13:0] dpram_readDataA_MPORT_addr_pipe_0;
  reg  dpram_readDataB_MPORT_en_pipe_0;
  reg [13:0] dpram_readDataB_MPORT_addr_pipe_0;
  reg [31:0] portadataoutReg; // @[dut.scala 34:32]
  reg [31:0] portbdataoutReg; // @[dut.scala 35:32]
  wire [31:0] readDataA = dpram_readDataA_MPORT_data; // @[dut.scala 38:23 39:13]
  wire [31:0] readDataB = dpram_readDataB_MPORT_data; // @[dut.scala 42:23 43:13]
  assign dpram_readDataA_MPORT_en = dpram_readDataA_MPORT_en_pipe_0;
  assign dpram_readDataA_MPORT_addr = dpram_readDataA_MPORT_addr_pipe_0;
  assign dpram_readDataA_MPORT_data = dpram[dpram_readDataA_MPORT_addr]; // @[dut.scala 31:26]
  assign dpram_readDataB_MPORT_en = dpram_readDataB_MPORT_en_pipe_0;
  assign dpram_readDataB_MPORT_addr = dpram_readDataB_MPORT_addr_pipe_0;
  assign dpram_readDataB_MPORT_data = dpram[dpram_readDataB_MPORT_addr]; // @[dut.scala 31:26]
  assign dpram_MPORT_data = io_portadatain;
  assign dpram_MPORT_addr = io_portaaddr;
  assign dpram_MPORT_mask = 1'h1;
  assign dpram_MPORT_en = io_portaena & io_portawe;
  assign dpram_MPORT_1_data = io_portbdatain;
  assign dpram_MPORT_1_addr = io_portbaddr;
  assign dpram_MPORT_1_mask = 1'h1;
  assign dpram_MPORT_1_en = io_portbena & io_portbwe;
  assign io_portadataout = portadataoutReg; // @[dut.scala 68:21]
  assign io_portbdataout = portbdataoutReg; // @[dut.scala 69:21]
  always @(posedge io_portaclk) begin
    if (dpram_MPORT_en & dpram_MPORT_mask) begin
      dpram[dpram_MPORT_addr] <= dpram_MPORT_data; // @[dut.scala 31:26]
    end
  end
  always @(posedge io_portbclk) begin
    if (dpram_MPORT_1_en & dpram_MPORT_1_mask) begin
      dpram[dpram_MPORT_1_addr] <= dpram_MPORT_1_data; // @[dut.scala 31:26]
    end
  end
  always @(posedge clock) begin
    dpram_readDataA_MPORT_en_pipe_0 <= io_portaena;
    if (io_portaena) begin
      dpram_readDataA_MPORT_addr_pipe_0 <= io_portaaddr;
    end
    dpram_readDataB_MPORT_en_pipe_0 <= io_portbena;
    if (io_portbena) begin
      dpram_readDataB_MPORT_addr_pipe_0 <= io_portbaddr;
    end
    if (reset) begin // @[dut.scala 34:32]
      portadataoutReg <= 32'h0; // @[dut.scala 34:32]
    end else begin
      portadataoutReg <= readDataA; // @[dut.scala 63:23]
    end
    if (reset) begin // @[dut.scala 35:32]
      portbdataoutReg <= 32'h0; // @[dut.scala 35:32]
    end else begin
      portbdataoutReg <= readDataB; // @[dut.scala 66:23]
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
    dpram[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  dpram_readDataA_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  dpram_readDataA_MPORT_addr_pipe_0 = _RAND_2[13:0];
  _RAND_3 = {1{`RANDOM}};
  dpram_readDataB_MPORT_en_pipe_0 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  dpram_readDataB_MPORT_addr_pipe_0 = _RAND_4[13:0];
  _RAND_5 = {1{`RANDOM}};
  portadataoutReg = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  portbdataoutReg = _RAND_6[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
