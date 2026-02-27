module dut(
  input         clock,
  input         reset,
  input         io_portaWE,
  input         io_portaEn,
  input         io_portaClk,
  input  [13:0] io_portaAddr,
  input  [31:0] io_portaDataIn,
  output [31:0] io_portaDataOut,
  input         io_portbWE,
  input         io_portbEn,
  input         io_portbClk,
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
`endif // RANDOMIZE_REG_INIT
  reg [31:0] dpram [0:16383]; // @[dut.scala 30:26]
  wire  dpram_portaReadData_MPORT_en; // @[dut.scala 30:26]
  wire [13:0] dpram_portaReadData_MPORT_addr; // @[dut.scala 30:26]
  wire [31:0] dpram_portaReadData_MPORT_data; // @[dut.scala 30:26]
  wire  dpram_portbReadData_MPORT_en; // @[dut.scala 30:26]
  wire [13:0] dpram_portbReadData_MPORT_addr; // @[dut.scala 30:26]
  wire [31:0] dpram_portbReadData_MPORT_data; // @[dut.scala 30:26]
  wire [31:0] dpram_MPORT_data; // @[dut.scala 30:26]
  wire [13:0] dpram_MPORT_addr; // @[dut.scala 30:26]
  wire  dpram_MPORT_mask; // @[dut.scala 30:26]
  wire  dpram_MPORT_en; // @[dut.scala 30:26]
  wire [31:0] dpram_MPORT_1_data; // @[dut.scala 30:26]
  wire [13:0] dpram_MPORT_1_addr; // @[dut.scala 30:26]
  wire  dpram_MPORT_1_mask; // @[dut.scala 30:26]
  wire  dpram_MPORT_1_en; // @[dut.scala 30:26]
  reg  dpram_portaReadData_MPORT_en_pipe_0;
  reg [13:0] dpram_portaReadData_MPORT_addr_pipe_0;
  reg  dpram_portbReadData_MPORT_en_pipe_0;
  reg [13:0] dpram_portbReadData_MPORT_addr_pipe_0;
  reg [31:0] portARegOut; // @[dut.scala 33:28]
  reg [31:0] portBRegOut; // @[dut.scala 34:28]
  wire  _portaReadData_T = ~io_portaWE; // @[dut.scala 46:49]
  wire  _portbReadData_T = ~io_portbWE; // @[dut.scala 68:49]
  assign dpram_portaReadData_MPORT_en = dpram_portaReadData_MPORT_en_pipe_0;
  assign dpram_portaReadData_MPORT_addr = dpram_portaReadData_MPORT_addr_pipe_0;
  assign dpram_portaReadData_MPORT_data = dpram[dpram_portaReadData_MPORT_addr]; // @[dut.scala 30:26]
  assign dpram_portbReadData_MPORT_en = dpram_portbReadData_MPORT_en_pipe_0;
  assign dpram_portbReadData_MPORT_addr = dpram_portbReadData_MPORT_addr_pipe_0;
  assign dpram_portbReadData_MPORT_data = dpram[dpram_portbReadData_MPORT_addr]; // @[dut.scala 30:26]
  assign dpram_MPORT_data = io_portaDataIn;
  assign dpram_MPORT_addr = io_portaAddr;
  assign dpram_MPORT_mask = 1'h1;
  assign dpram_MPORT_en = io_portaWE & io_portaEn;
  assign dpram_MPORT_1_data = io_portbDataIn;
  assign dpram_MPORT_1_addr = io_portbAddr;
  assign dpram_MPORT_1_mask = 1'h1;
  assign dpram_MPORT_1_en = io_portbWE & io_portbEn;
  assign io_portaDataOut = portARegOut; // @[dut.scala 52:23]
  assign io_portbDataOut = portBRegOut; // @[dut.scala 74:23]
  always @(posedge io_portaClk) begin
    if (dpram_MPORT_en & dpram_MPORT_mask) begin
      dpram[dpram_MPORT_addr] <= dpram_MPORT_data; // @[dut.scala 30:26]
    end
    dpram_portaReadData_MPORT_en_pipe_0 <= io_portaEn & _portaReadData_T;
    if (io_portaEn & _portaReadData_T) begin
      dpram_portaReadData_MPORT_addr_pipe_0 <= io_portaAddr;
    end
  end
  always @(posedge io_portbClk) begin
    if (dpram_MPORT_1_en & dpram_MPORT_1_mask) begin
      dpram[dpram_MPORT_1_addr] <= dpram_MPORT_1_data; // @[dut.scala 30:26]
    end
    dpram_portbReadData_MPORT_en_pipe_0 <= io_portbEn & _portbReadData_T;
    if (io_portbEn & _portbReadData_T) begin
      dpram_portbReadData_MPORT_addr_pipe_0 <= io_portbAddr;
    end
  end
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 33:28]
      portARegOut <= 32'h0; // @[dut.scala 33:28]
    end else if (io_portaEn) begin // @[dut.scala 45:22]
      portARegOut <= dpram_portaReadData_MPORT_data; // @[dut.scala 46:21]
    end else begin
      portARegOut <= 32'h0; // @[dut.scala 43:19]
    end
    if (reset) begin // @[dut.scala 34:28]
      portBRegOut <= 32'h0; // @[dut.scala 34:28]
    end else if (io_portbEn) begin // @[dut.scala 67:22]
      portBRegOut <= dpram_portbReadData_MPORT_data; // @[dut.scala 68:21]
    end else begin
      portBRegOut <= 32'h0; // @[dut.scala 65:19]
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
  dpram_portaReadData_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  dpram_portaReadData_MPORT_addr_pipe_0 = _RAND_2[13:0];
  _RAND_3 = {1{`RANDOM}};
  dpram_portbReadData_MPORT_en_pipe_0 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  dpram_portbReadData_MPORT_addr_pipe_0 = _RAND_4[13:0];
  _RAND_5 = {1{`RANDOM}};
  portARegOut = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  portBRegOut = _RAND_6[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
