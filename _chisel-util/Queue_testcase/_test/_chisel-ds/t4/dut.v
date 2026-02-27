module dut(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits,
  output [4:0] io_count,
  output       io_full,
  output       io_empty
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] ram [0:15]; // @[dut.scala 19:16]
  wire  ram_io_deq_bits_MPORT_en; // @[dut.scala 19:16]
  wire [3:0] ram_io_deq_bits_MPORT_addr; // @[dut.scala 19:16]
  wire [7:0] ram_io_deq_bits_MPORT_data; // @[dut.scala 19:16]
  wire [7:0] ram_MPORT_data; // @[dut.scala 19:16]
  wire [3:0] ram_MPORT_addr; // @[dut.scala 19:16]
  wire  ram_MPORT_mask; // @[dut.scala 19:16]
  wire  ram_MPORT_en; // @[dut.scala 19:16]
  reg [3:0] enq_ptr; // @[dut.scala 22:24]
  reg [3:0] deq_ptr; // @[dut.scala 23:24]
  reg  maybe_full; // @[dut.scala 24:27]
  wire  ptr_match = enq_ptr == deq_ptr; // @[dut.scala 27:27]
  wire  full = ptr_match & maybe_full; // @[dut.scala 30:24]
  wire  empty = ptr_match & ~maybe_full; // @[dut.scala 31:25]
  wire [4:0] _count_T = maybe_full ? 5'h10 : 5'h0; // @[dut.scala 34:33]
  wire [3:0] _count_T_3 = enq_ptr - deq_ptr; // @[dut.scala 34:94]
  wire [4:0] _GEN_9 = {{1'd0}, enq_ptr}; // @[dut.scala 34:115]
  wire [4:0] _count_T_5 = 5'h10 + _GEN_9; // @[dut.scala 34:115]
  wire [4:0] _GEN_10 = {{1'd0}, deq_ptr}; // @[dut.scala 34:125]
  wire [4:0] _count_T_7 = _count_T_5 - _GEN_10; // @[dut.scala 34:125]
  wire [4:0] _count_T_8 = enq_ptr > deq_ptr ? {{1'd0}, _count_T_3} : _count_T_7; // @[dut.scala 34:66]
  wire  _do_enq_T = ~full; // @[dut.scala 37:32]
  wire  do_enq = io_enq_valid & ~full; // @[dut.scala 37:29]
  wire [3:0] _enq_ptr_T_2 = enq_ptr + 4'h1; // @[dut.scala 40:62]
  wire  do_deq = io_deq_ready & ~empty; // @[dut.scala 45:29]
  wire [3:0] _deq_ptr_T_2 = deq_ptr + 4'h1; // @[dut.scala 47:62]
  assign ram_io_deq_bits_MPORT_en = 1'h1;
  assign ram_io_deq_bits_MPORT_addr = deq_ptr;
  assign ram_io_deq_bits_MPORT_data = ram[ram_io_deq_bits_MPORT_addr]; // @[dut.scala 19:16]
  assign ram_MPORT_data = io_enq_bits;
  assign ram_MPORT_addr = enq_ptr;
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_enq_valid & _do_enq_T;
  assign io_enq_ready = ~full; // @[dut.scala 61:19]
  assign io_deq_valid = ~empty; // @[dut.scala 62:19]
  assign io_deq_bits = ram_io_deq_bits_MPORT_data; // @[dut.scala 63:15]
  assign io_count = ptr_match ? _count_T : _count_T_8; // @[dut.scala 34:18]
  assign io_full = ptr_match & maybe_full; // @[dut.scala 30:24]
  assign io_empty = ptr_match & ~maybe_full; // @[dut.scala 31:25]
  always @(posedge clock) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[dut.scala 19:16]
    end
    if (reset) begin // @[dut.scala 22:24]
      enq_ptr <= 4'h0; // @[dut.scala 22:24]
    end else if (do_enq) begin // @[dut.scala 38:16]
      if (enq_ptr == 4'hf) begin // @[dut.scala 40:19]
        enq_ptr <= 4'h0;
      end else begin
        enq_ptr <= _enq_ptr_T_2;
      end
    end
    if (reset) begin // @[dut.scala 23:24]
      deq_ptr <= 4'h0; // @[dut.scala 23:24]
    end else if (do_deq) begin // @[dut.scala 46:16]
      if (deq_ptr == 4'hf) begin // @[dut.scala 47:19]
        deq_ptr <= 4'h0;
      end else begin
        deq_ptr <= _deq_ptr_T_2;
      end
    end
    if (reset) begin // @[dut.scala 24:27]
      maybe_full <= 1'h0; // @[dut.scala 24:27]
    end else if (do_deq) begin // @[dut.scala 46:16]
      maybe_full <= 1'h0; // @[dut.scala 48:16]
    end else if (do_enq) begin // @[dut.scala 38:16]
      maybe_full <= ptr_match; // @[dut.scala 41:16]
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
  enq_ptr = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  deq_ptr = _RAND_2[3:0];
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
