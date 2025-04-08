module dut(
  input        clock,
  input        reset,
  input  [3:0] io_dataIn,
  input        io_RW,
  input        io_EN,
  output       io_EMPTY,
  output       io_FULL,
  output [3:0] io_dataOut
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [3:0] stack_mem [0:3]; // @[dut.scala 15:22]
  wire  stack_mem_io_dataOut_MPORT_en; // @[dut.scala 15:22]
  wire [1:0] stack_mem_io_dataOut_MPORT_addr; // @[dut.scala 15:22]
  wire [3:0] stack_mem_io_dataOut_MPORT_data; // @[dut.scala 15:22]
  wire [3:0] stack_mem_MPORT_data; // @[dut.scala 15:22]
  wire [1:0] stack_mem_MPORT_addr; // @[dut.scala 15:22]
  wire  stack_mem_MPORT_mask; // @[dut.scala 15:22]
  wire  stack_mem_MPORT_en; // @[dut.scala 15:22]
  wire [3:0] stack_mem_MPORT_1_data; // @[dut.scala 15:22]
  wire [1:0] stack_mem_MPORT_1_addr; // @[dut.scala 15:22]
  wire  stack_mem_MPORT_1_mask; // @[dut.scala 15:22]
  wire  stack_mem_MPORT_1_en; // @[dut.scala 15:22]
  wire [3:0] stack_mem_MPORT_2_data; // @[dut.scala 15:22]
  wire [1:0] stack_mem_MPORT_2_addr; // @[dut.scala 15:22]
  wire  stack_mem_MPORT_2_mask; // @[dut.scala 15:22]
  wire  stack_mem_MPORT_2_en; // @[dut.scala 15:22]
  wire [3:0] stack_mem_MPORT_3_data; // @[dut.scala 15:22]
  wire [1:0] stack_mem_MPORT_3_addr; // @[dut.scala 15:22]
  wire  stack_mem_MPORT_3_mask; // @[dut.scala 15:22]
  wire  stack_mem_MPORT_3_en; // @[dut.scala 15:22]
  wire [3:0] stack_mem_MPORT_4_data; // @[dut.scala 15:22]
  wire [1:0] stack_mem_MPORT_4_addr; // @[dut.scala 15:22]
  wire  stack_mem_MPORT_4_mask; // @[dut.scala 15:22]
  wire  stack_mem_MPORT_4_en; // @[dut.scala 15:22]
  wire [3:0] stack_mem_MPORT_5_data; // @[dut.scala 15:22]
  wire [1:0] stack_mem_MPORT_5_addr; // @[dut.scala 15:22]
  wire  stack_mem_MPORT_5_mask; // @[dut.scala 15:22]
  wire  stack_mem_MPORT_5_en; // @[dut.scala 15:22]
  reg [2:0] SP; // @[dut.scala 18:19]
  wire  _T_3 = ~io_RW & ~io_FULL; // @[dut.scala 35:17]
  wire [2:0] _T_5 = SP - 3'h1; // @[dut.scala 37:26]
  wire  _T_8 = io_RW & ~io_EMPTY; // @[dut.scala 39:23]
  wire [2:0] _SP_T_3 = SP + 3'h1; // @[dut.scala 43:16]
  wire [3:0] _GEN_3 = io_RW & ~io_EMPTY ? stack_mem_io_dataOut_MPORT_data : 4'h0; // @[dut.scala 21:14 39:37 41:18]
  wire [2:0] _GEN_7 = io_RW & ~io_EMPTY ? _SP_T_3 : SP; // @[dut.scala 39:37 43:10 18:19]
  wire  _GEN_16 = ~io_RW & ~io_FULL ? 1'h0 : _T_8; // @[dut.scala 15:22 35:30]
  wire [3:0] _GEN_17 = ~io_RW & ~io_FULL ? 4'h0 : _GEN_3; // @[dut.scala 21:14 35:30]
  wire  _GEN_23 = io_EN & _T_3; // @[dut.scala 15:22 34:22]
  wire  _GEN_29 = io_EN & _GEN_16; // @[dut.scala 15:22 34:22]
  wire [3:0] _GEN_30 = io_EN ? _GEN_17 : 4'h0; // @[dut.scala 21:14 34:22]
  assign stack_mem_io_dataOut_MPORT_en = reset ? 1'h0 : _GEN_29;
  assign stack_mem_io_dataOut_MPORT_addr = SP[1:0];
  assign stack_mem_io_dataOut_MPORT_data = stack_mem[stack_mem_io_dataOut_MPORT_addr]; // @[dut.scala 15:22]
  assign stack_mem_MPORT_data = 4'h0;
  assign stack_mem_MPORT_addr = 2'h0;
  assign stack_mem_MPORT_mask = 1'h1;
  assign stack_mem_MPORT_en = reset;
  assign stack_mem_MPORT_1_data = 4'h0;
  assign stack_mem_MPORT_1_addr = 2'h1;
  assign stack_mem_MPORT_1_mask = 1'h1;
  assign stack_mem_MPORT_1_en = reset;
  assign stack_mem_MPORT_2_data = 4'h0;
  assign stack_mem_MPORT_2_addr = 2'h2;
  assign stack_mem_MPORT_2_mask = 1'h1;
  assign stack_mem_MPORT_2_en = reset;
  assign stack_mem_MPORT_3_data = 4'h0;
  assign stack_mem_MPORT_3_addr = 2'h3;
  assign stack_mem_MPORT_3_mask = 1'h1;
  assign stack_mem_MPORT_3_en = reset;
  assign stack_mem_MPORT_4_data = io_dataIn;
  assign stack_mem_MPORT_4_addr = _T_5[1:0];
  assign stack_mem_MPORT_4_mask = 1'h1;
  assign stack_mem_MPORT_4_en = reset ? 1'h0 : _GEN_23;
  assign stack_mem_MPORT_5_data = 4'h0;
  assign stack_mem_MPORT_5_addr = SP[1:0];
  assign stack_mem_MPORT_5_mask = 1'h1;
  assign stack_mem_MPORT_5_en = reset ? 1'h0 : _GEN_29;
  assign io_EMPTY = SP == 3'h4; // @[dut.scala 24:19]
  assign io_FULL = SP == 3'h0; // @[dut.scala 25:18]
  assign io_dataOut = reset ? 4'h0 : _GEN_30; // @[dut.scala 21:14 28:22]
  always @(posedge clock) begin
    if (stack_mem_MPORT_en & stack_mem_MPORT_mask) begin
      stack_mem[stack_mem_MPORT_addr] <= stack_mem_MPORT_data; // @[dut.scala 15:22]
    end
    if (stack_mem_MPORT_1_en & stack_mem_MPORT_1_mask) begin
      stack_mem[stack_mem_MPORT_1_addr] <= stack_mem_MPORT_1_data; // @[dut.scala 15:22]
    end
    if (stack_mem_MPORT_2_en & stack_mem_MPORT_2_mask) begin
      stack_mem[stack_mem_MPORT_2_addr] <= stack_mem_MPORT_2_data; // @[dut.scala 15:22]
    end
    if (stack_mem_MPORT_3_en & stack_mem_MPORT_3_mask) begin
      stack_mem[stack_mem_MPORT_3_addr] <= stack_mem_MPORT_3_data; // @[dut.scala 15:22]
    end
    if (stack_mem_MPORT_4_en & stack_mem_MPORT_4_mask) begin
      stack_mem[stack_mem_MPORT_4_addr] <= stack_mem_MPORT_4_data; // @[dut.scala 15:22]
    end
    if (stack_mem_MPORT_5_en & stack_mem_MPORT_5_mask) begin
      stack_mem[stack_mem_MPORT_5_addr] <= stack_mem_MPORT_5_data; // @[dut.scala 15:22]
    end
    if (reset) begin // @[dut.scala 18:19]
      SP <= 3'h4; // @[dut.scala 18:19]
    end else if (reset) begin // @[dut.scala 28:22]
      SP <= 3'h4; // @[dut.scala 33:8]
    end else if (io_EN) begin // @[dut.scala 34:22]
      if (~io_RW & ~io_FULL) begin // @[dut.scala 35:30]
        SP <= _T_5; // @[dut.scala 38:10]
      end else begin
        SP <= _GEN_7;
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
  for (initvar = 0; initvar < 4; initvar = initvar+1)
    stack_mem[initvar] = _RAND_0[3:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  SP = _RAND_1[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
