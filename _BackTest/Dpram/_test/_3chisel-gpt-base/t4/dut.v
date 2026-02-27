module dut(
  input         clock,
  input         reset,
  input         io_porta_we,
  input         io_porta_en,
  input         io_porta_clk,
  input  [31:0] io_porta_data_in,
  input  [13:0] io_porta_addr,
  output [31:0] io_porta_data_out,
  input         io_portb_we,
  input         io_portb_en,
  input         io_portb_clk,
  input  [31:0] io_portb_data_in,
  input  [13:0] io_portb_addr,
  output [31:0] io_portb_data_out
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
  reg [31:0] mem [0:16383]; // @[dut.scala 34:24]
  wire  mem_porta_reg_out_MPORT_en; // @[dut.scala 34:24]
  wire [13:0] mem_porta_reg_out_MPORT_addr; // @[dut.scala 34:24]
  wire [31:0] mem_porta_reg_out_MPORT_data; // @[dut.scala 34:24]
  wire  mem_portb_reg_out_MPORT_en; // @[dut.scala 34:24]
  wire [13:0] mem_portb_reg_out_MPORT_addr; // @[dut.scala 34:24]
  wire [31:0] mem_portb_reg_out_MPORT_data; // @[dut.scala 34:24]
  wire [31:0] mem_MPORT_data; // @[dut.scala 34:24]
  wire [13:0] mem_MPORT_addr; // @[dut.scala 34:24]
  wire  mem_MPORT_mask; // @[dut.scala 34:24]
  wire  mem_MPORT_en; // @[dut.scala 34:24]
  wire [31:0] mem_MPORT_1_data; // @[dut.scala 34:24]
  wire [13:0] mem_MPORT_1_addr; // @[dut.scala 34:24]
  wire  mem_MPORT_1_mask; // @[dut.scala 34:24]
  wire  mem_MPORT_1_en; // @[dut.scala 34:24]
  reg  mem_porta_reg_out_MPORT_en_pipe_0;
  reg [13:0] mem_porta_reg_out_MPORT_addr_pipe_0;
  reg  mem_portb_reg_out_MPORT_en_pipe_0;
  reg [13:0] mem_portb_reg_out_MPORT_addr_pipe_0;
  wire  _porta_reg_out_T = ~io_porta_we; // @[dut.scala 49:59]
  reg [31:0] porta_data_out_reg; // @[dut.scala 53:37]
  wire  _portb_reg_out_T = ~io_portb_we; // @[dut.scala 72:59]
  reg [31:0] portb_data_out_reg; // @[dut.scala 76:37]
  assign mem_porta_reg_out_MPORT_en = mem_porta_reg_out_MPORT_en_pipe_0;
  assign mem_porta_reg_out_MPORT_addr = mem_porta_reg_out_MPORT_addr_pipe_0;
  assign mem_porta_reg_out_MPORT_data = mem[mem_porta_reg_out_MPORT_addr]; // @[dut.scala 34:24]
  assign mem_portb_reg_out_MPORT_en = mem_portb_reg_out_MPORT_en_pipe_0;
  assign mem_portb_reg_out_MPORT_addr = mem_portb_reg_out_MPORT_addr_pipe_0;
  assign mem_portb_reg_out_MPORT_data = mem[mem_portb_reg_out_MPORT_addr]; // @[dut.scala 34:24]
  assign mem_MPORT_data = io_porta_data_in;
  assign mem_MPORT_addr = io_porta_addr;
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = io_porta_we & io_porta_en;
  assign mem_MPORT_1_data = io_portb_data_in;
  assign mem_MPORT_1_addr = io_portb_addr;
  assign mem_MPORT_1_mask = 1'h1;
  assign mem_MPORT_1_en = io_portb_we & io_portb_en;
  assign io_porta_data_out = porta_data_out_reg; // @[dut.scala 54:23]
  assign io_portb_data_out = portb_data_out_reg; // @[dut.scala 77:23]
  always @(posedge io_porta_clk) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[dut.scala 34:24]
    end
  end
  always @(posedge io_portb_clk) begin
    if (mem_MPORT_1_en & mem_MPORT_1_mask) begin
      mem[mem_MPORT_1_addr] <= mem_MPORT_1_data; // @[dut.scala 34:24]
    end
  end
  always @(posedge clock) begin
    mem_porta_reg_out_MPORT_en_pipe_0 <= io_porta_en & _porta_reg_out_T;
    if (io_porta_en & _porta_reg_out_T) begin
      mem_porta_reg_out_MPORT_addr_pipe_0 <= io_porta_addr;
    end
    mem_portb_reg_out_MPORT_en_pipe_0 <= io_portb_en & _portb_reg_out_T;
    if (io_portb_en & _portb_reg_out_T) begin
      mem_portb_reg_out_MPORT_addr_pipe_0 <= io_portb_addr;
    end
    porta_data_out_reg <= mem_porta_reg_out_MPORT_data; // @[dut.scala 48:34 49:17]
    portb_data_out_reg <= mem_portb_reg_out_MPORT_data; // @[dut.scala 71:34 72:17]
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
  mem_porta_reg_out_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_porta_reg_out_MPORT_addr_pipe_0 = _RAND_2[13:0];
  _RAND_3 = {1{`RANDOM}};
  mem_portb_reg_out_MPORT_en_pipe_0 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  mem_portb_reg_out_MPORT_addr_pipe_0 = _RAND_4[13:0];
  _RAND_5 = {1{`RANDOM}};
  porta_data_out_reg = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  portb_data_out_reg = _RAND_6[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
