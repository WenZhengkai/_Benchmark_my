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
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] mem [0:16383]; // @[dut.scala 36:24]
  wire  mem_portADataOutReg_MPORT_en; // @[dut.scala 36:24]
  wire [13:0] mem_portADataOutReg_MPORT_addr; // @[dut.scala 36:24]
  wire [31:0] mem_portADataOutReg_MPORT_data; // @[dut.scala 36:24]
  wire  mem_portBDataOutReg_MPORT_en; // @[dut.scala 36:24]
  wire [13:0] mem_portBDataOutReg_MPORT_addr; // @[dut.scala 36:24]
  wire [31:0] mem_portBDataOutReg_MPORT_data; // @[dut.scala 36:24]
  wire [31:0] mem_MPORT_data; // @[dut.scala 36:24]
  wire [13:0] mem_MPORT_addr; // @[dut.scala 36:24]
  wire  mem_MPORT_mask; // @[dut.scala 36:24]
  wire  mem_MPORT_en; // @[dut.scala 36:24]
  wire [31:0] mem_MPORT_1_data; // @[dut.scala 36:24]
  wire [13:0] mem_MPORT_1_addr; // @[dut.scala 36:24]
  wire  mem_MPORT_1_mask; // @[dut.scala 36:24]
  wire  mem_MPORT_1_en; // @[dut.scala 36:24]
  reg  mem_portADataOutReg_MPORT_en_pipe_0;
  reg [13:0] mem_portADataOutReg_MPORT_addr_pipe_0;
  reg  mem_portBDataOutReg_MPORT_en_pipe_0;
  reg [13:0] mem_portBDataOutReg_MPORT_addr_pipe_0;
  reg [31:0] portADataOutReg; // @[dut.scala 40:12]
  wire  _GEN_9 = io_portAWe ? 1'h0 : 1'h1; // @[dut.scala 36:24 45:24]
  reg [31:0] portBDataOutReg; // @[dut.scala 58:12]
  wire  _GEN_30 = io_portBWe ? 1'h0 : 1'h1; // @[dut.scala 36:24 63:24]
  assign mem_portADataOutReg_MPORT_en = mem_portADataOutReg_MPORT_en_pipe_0;
  assign mem_portADataOutReg_MPORT_addr = mem_portADataOutReg_MPORT_addr_pipe_0;
  assign mem_portADataOutReg_MPORT_data = mem[mem_portADataOutReg_MPORT_addr]; // @[dut.scala 36:24]
  assign mem_portBDataOutReg_MPORT_en = mem_portBDataOutReg_MPORT_en_pipe_0;
  assign mem_portBDataOutReg_MPORT_addr = mem_portBDataOutReg_MPORT_addr_pipe_0;
  assign mem_portBDataOutReg_MPORT_data = mem[mem_portBDataOutReg_MPORT_addr]; // @[dut.scala 36:24]
  assign mem_MPORT_data = io_portADataIn;
  assign mem_MPORT_addr = io_portAAddr;
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = io_portAEna & io_portAWe;
  assign mem_MPORT_1_data = io_portBDataIn;
  assign mem_MPORT_1_addr = io_portBAddr;
  assign mem_MPORT_1_mask = 1'h1;
  assign mem_MPORT_1_en = io_portBEna & io_portBWe;
  assign io_portADataOut = portADataOutReg; // @[dut.scala 86:23]
  assign io_portBDataOut = portBDataOutReg; // @[dut.scala 87:23]
  always @(posedge io_portAClk) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[dut.scala 36:24]
    end
    mem_portADataOutReg_MPORT_en_pipe_0 <= io_portAEna & _GEN_9;
    if (io_portAEna & _GEN_9) begin
      mem_portADataOutReg_MPORT_addr_pipe_0 <= io_portAAddr;
    end
    if (reset) begin // @[dut.scala 40:12]
      portADataOutReg <= 32'h0; // @[dut.scala 40:12]
    end else if (io_portAEna) begin // @[dut.scala 44:23]
      if (!(io_portAWe)) begin // @[dut.scala 45:24]
        portADataOutReg <= mem_portADataOutReg_MPORT_data; // @[dut.scala 50:27]
      end
    end
  end
  always @(posedge io_portBClk) begin
    if (mem_MPORT_1_en & mem_MPORT_1_mask) begin
      mem[mem_MPORT_1_addr] <= mem_MPORT_1_data; // @[dut.scala 36:24]
    end
    mem_portBDataOutReg_MPORT_en_pipe_0 <= io_portBEna & _GEN_30;
    if (io_portBEna & _GEN_30) begin
      mem_portBDataOutReg_MPORT_addr_pipe_0 <= io_portBAddr;
    end
    if (reset) begin // @[dut.scala 58:12]
      portBDataOutReg <= 32'h0; // @[dut.scala 58:12]
    end else if (io_portBEna) begin // @[dut.scala 62:23]
      if (!(io_portBWe)) begin // @[dut.scala 63:24]
        portBDataOutReg <= mem_portBDataOutReg_MPORT_data; // @[dut.scala 68:27]
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
  mem_portADataOutReg_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_portADataOutReg_MPORT_addr_pipe_0 = _RAND_2[13:0];
  _RAND_3 = {1{`RANDOM}};
  mem_portBDataOutReg_MPORT_en_pipe_0 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  mem_portBDataOutReg_MPORT_addr_pipe_0 = _RAND_4[13:0];
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
