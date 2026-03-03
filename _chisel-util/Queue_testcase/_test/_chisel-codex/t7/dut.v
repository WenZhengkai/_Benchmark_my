module dut(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits,
  output [4:0] io_count
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] ram [0:15]; // @[dut.scala 9:16]
  wire  ram_io_deq_bits_MPORT_en; // @[dut.scala 9:16]
  wire [3:0] ram_io_deq_bits_MPORT_addr; // @[dut.scala 9:16]
  wire [7:0] ram_io_deq_bits_MPORT_data; // @[dut.scala 9:16]
  wire [7:0] ram_MPORT_data; // @[dut.scala 9:16]
  wire [3:0] ram_MPORT_addr; // @[dut.scala 9:16]
  wire  ram_MPORT_mask; // @[dut.scala 9:16]
  wire  ram_MPORT_en; // @[dut.scala 9:16]
  reg [3:0] enq_ptr_value; // @[Counter.scala 61:40]
  reg [3:0] deq_ptr_value; // @[Counter.scala 61:40]
  reg  maybe_full; // @[dut.scala 13:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[dut.scala 15:33]
  wire  empty = ptr_match & ~maybe_full; // @[dut.scala 16:25]
  wire  full = ptr_match & maybe_full; // @[dut.scala 17:25]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 51:35]
  wire [3:0] _value_T_1 = enq_ptr_value + 4'h1; // @[Counter.scala 77:24]
  wire [3:0] _value_T_3 = deq_ptr_value + 4'h1; // @[Counter.scala 77:24]
  wire [3:0] ptr_diff = enq_ptr_value - deq_ptr_value; // @[dut.scala 47:32]
  wire [4:0] _io_count_T = maybe_full ? 5'h10 : 5'h0; // @[dut.scala 49:35]
  assign ram_io_deq_bits_MPORT_en = 1'h1;
  assign ram_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_io_deq_bits_MPORT_data = ram[ram_io_deq_bits_MPORT_addr]; // @[dut.scala 9:16]
  assign ram_MPORT_data = io_enq_bits;
  assign ram_MPORT_addr = enq_ptr_value;
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[dut.scala 19:19]
  assign io_deq_valid = ~empty; // @[dut.scala 20:19]
  assign io_deq_bits = ram_io_deq_bits_MPORT_data; // @[dut.scala 21:16]
  assign io_count = ptr_match ? _io_count_T : {{1'd0}, ptr_diff}; // @[dut.scala 49:20]
  always @(posedge clock) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[dut.scala 9:16]
    end
    if (reset) begin // @[Counter.scala 61:40]
      enq_ptr_value <= 4'h0; // @[Counter.scala 61:40]
    end else if (do_enq) begin // @[dut.scala 26:16]
      enq_ptr_value <= _value_T_1; // @[Counter.scala 77:15]
    end
    if (reset) begin // @[Counter.scala 61:40]
      deq_ptr_value <= 4'h0; // @[Counter.scala 61:40]
    end else if (do_deq) begin // @[dut.scala 31:16]
      deq_ptr_value <= _value_T_3; // @[Counter.scala 77:15]
    end
    if (reset) begin // @[dut.scala 13:27]
      maybe_full <= 1'h0; // @[dut.scala 13:27]
    end else if (do_enq != do_deq) begin // @[dut.scala 35:27]
      maybe_full <= do_enq; // @[dut.scala 36:16]
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
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    ram[initvar] = _RAND_0[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  enq_ptr_value = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  deq_ptr_value = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  maybe_full = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
