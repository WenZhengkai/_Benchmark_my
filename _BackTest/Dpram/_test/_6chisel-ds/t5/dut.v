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
  reg [31:0] dpram_content [0:16383]; // @[dut.scala 33:34]
  wire  dpram_content_readData_en; // @[dut.scala 33:34]
  wire [13:0] dpram_content_readData_addr; // @[dut.scala 33:34]
  wire [31:0] dpram_content_readData_data; // @[dut.scala 33:34]
  wire  dpram_content_readData_1_en; // @[dut.scala 33:34]
  wire [13:0] dpram_content_readData_1_addr; // @[dut.scala 33:34]
  wire [31:0] dpram_content_readData_1_data; // @[dut.scala 33:34]
  wire [31:0] dpram_content_MPORT_data; // @[dut.scala 33:34]
  wire [13:0] dpram_content_MPORT_addr; // @[dut.scala 33:34]
  wire  dpram_content_MPORT_mask; // @[dut.scala 33:34]
  wire  dpram_content_MPORT_en; // @[dut.scala 33:34]
  wire [31:0] dpram_content_MPORT_1_data; // @[dut.scala 33:34]
  wire [13:0] dpram_content_MPORT_1_addr; // @[dut.scala 33:34]
  wire  dpram_content_MPORT_1_mask; // @[dut.scala 33:34]
  wire  dpram_content_MPORT_1_en; // @[dut.scala 33:34]
  reg  dpram_content_readData_en_pipe_0;
  reg [13:0] dpram_content_readData_addr_pipe_0;
  reg  dpram_content_readData_1_en_pipe_0;
  reg [13:0] dpram_content_readData_1_addr_pipe_0;
  reg [31:0] portadataout_reg; // @[dut.scala 36:29]
  reg [31:0] portbdataout_reg; // @[dut.scala 37:29]
  wire  _GEN_9 = io_portawe ? 1'h0 : 1'h1; // @[dut.scala 42:24 33:34]
  wire  _GEN_30 = io_portbwe ? 1'h0 : 1'h1; // @[dut.scala 60:24 33:34]
  assign dpram_content_readData_en = dpram_content_readData_en_pipe_0;
  assign dpram_content_readData_addr = dpram_content_readData_addr_pipe_0;
  assign dpram_content_readData_data = dpram_content[dpram_content_readData_addr]; // @[dut.scala 33:34]
  assign dpram_content_readData_1_en = dpram_content_readData_1_en_pipe_0;
  assign dpram_content_readData_1_addr = dpram_content_readData_1_addr_pipe_0;
  assign dpram_content_readData_1_data = dpram_content[dpram_content_readData_1_addr]; // @[dut.scala 33:34]
  assign dpram_content_MPORT_data = io_portadatain;
  assign dpram_content_MPORT_addr = io_portaaddr;
  assign dpram_content_MPORT_mask = 1'h1;
  assign dpram_content_MPORT_en = io_portaena & io_portawe;
  assign dpram_content_MPORT_1_data = io_portbdatain;
  assign dpram_content_MPORT_1_addr = io_portbaddr;
  assign dpram_content_MPORT_1_mask = 1'h1;
  assign dpram_content_MPORT_1_en = io_portbena & io_portbwe;
  assign io_portadataout = portadataout_reg; // @[dut.scala 77:21]
  assign io_portbdataout = portbdataout_reg; // @[dut.scala 78:21]
  always @(posedge io_portaclk) begin
    if (dpram_content_MPORT_en & dpram_content_MPORT_mask) begin
      dpram_content[dpram_content_MPORT_addr] <= dpram_content_MPORT_data; // @[dut.scala 33:34]
    end
    dpram_content_readData_en_pipe_0 <= io_portaena & _GEN_9;
    if (io_portaena & _GEN_9) begin
      dpram_content_readData_addr_pipe_0 <= io_portaaddr;
    end
  end
  always @(posedge io_portbclk) begin
    if (dpram_content_MPORT_1_en & dpram_content_MPORT_1_mask) begin
      dpram_content[dpram_content_MPORT_1_addr] <= dpram_content_MPORT_1_data; // @[dut.scala 33:34]
    end
    dpram_content_readData_1_en_pipe_0 <= io_portbena & _GEN_30;
    if (io_portbena & _GEN_30) begin
      dpram_content_readData_1_addr_pipe_0 <= io_portbaddr;
    end
  end
  always @(posedge clock) begin
    if (io_portaena) begin // @[dut.scala 41:23]
      if (!(io_portawe)) begin // @[dut.scala 42:24]
        portadataout_reg <= dpram_content_readData_data; // @[dut.scala 49:28]
      end
    end
    if (io_portbena) begin // @[dut.scala 59:23]
      if (!(io_portbwe)) begin // @[dut.scala 60:24]
        portbdataout_reg <= dpram_content_readData_1_data; // @[dut.scala 67:28]
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
    dpram_content[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  dpram_content_readData_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  dpram_content_readData_addr_pipe_0 = _RAND_2[13:0];
  _RAND_3 = {1{`RANDOM}};
  dpram_content_readData_1_en_pipe_0 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  dpram_content_readData_1_addr_pipe_0 = _RAND_4[13:0];
  _RAND_5 = {1{`RANDOM}};
  portadataout_reg = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  portbdataout_reg = _RAND_6[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
