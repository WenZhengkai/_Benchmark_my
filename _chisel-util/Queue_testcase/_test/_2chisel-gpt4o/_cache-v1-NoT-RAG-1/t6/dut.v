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
  reg [7:0] ram [0:15]; // @[dut.scala 20:16]
  wire  ram_io_deq_bits_MPORT_en; // @[dut.scala 20:16]
  wire [3:0] ram_io_deq_bits_MPORT_addr; // @[dut.scala 20:16]
  wire [7:0] ram_io_deq_bits_MPORT_data; // @[dut.scala 20:16]
  wire [7:0] ram_MPORT_data; // @[dut.scala 20:16]
  wire [3:0] ram_MPORT_addr; // @[dut.scala 20:16]
  wire  ram_MPORT_mask; // @[dut.scala 20:16]
  wire  ram_MPORT_en; // @[dut.scala 20:16]
  reg [3:0] enq_ptr; // @[dut.scala 23:24]
  reg [3:0] deq_ptr; // @[dut.scala 24:24]
  reg  maybe_full; // @[dut.scala 25:27]
  wire  ptr_match = enq_ptr == deq_ptr; // @[dut.scala 27:27]
  wire  full = ptr_match & maybe_full; // @[dut.scala 30:24]
  wire  empty = ptr_match & ~maybe_full; // @[dut.scala 31:25]
  wire  do_enq = io_enq_valid & io_enq_ready; // @[dut.scala 37:29]
  wire [3:0] _enq_ptr_T_1 = enq_ptr + 4'h1; // @[dut.scala 40:24]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[dut.scala 47:29]
  wire [3:0] _deq_ptr_T_1 = deq_ptr + 4'h1; // @[dut.scala 49:24]
  wire  _GEN_9 = ~do_enq & do_deq ? 1'h0 : maybe_full; // @[dut.scala 58:33 59:16 25:27]
  wire  _GEN_10 = do_enq & ~do_deq | _GEN_9; // @[dut.scala 56:27 57:16]
  wire [3:0] io_count_diff = enq_ptr - deq_ptr; // @[dut.scala 73:24]
  wire [4:0] _io_count_T = maybe_full ? 5'h10 : 5'h0; // @[dut.scala 74:23]
  wire [4:0] _GEN_11 = {{1'd0}, io_count_diff}; // @[dut.scala 74:92]
  wire [4:0] _io_count_T_3 = 5'h10 - _GEN_11; // @[dut.scala 74:92]
  wire [4:0] _io_count_T_4 = enq_ptr > deq_ptr ? {{1'd0}, io_count_diff} : _io_count_T_3; // @[dut.scala 74:56]
  assign ram_io_deq_bits_MPORT_en = 1'h1;
  assign ram_io_deq_bits_MPORT_addr = deq_ptr;
  assign ram_io_deq_bits_MPORT_data = ram[ram_io_deq_bits_MPORT_addr]; // @[dut.scala 20:16]
  assign ram_MPORT_data = io_enq_bits;
  assign ram_MPORT_addr = enq_ptr;
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_enq_valid & io_enq_ready;
  assign io_enq_ready = ~full; // @[dut.scala 33:19]
  assign io_deq_valid = ~empty; // @[dut.scala 34:19]
  assign io_deq_bits = ram_io_deq_bits_MPORT_data; // @[dut.scala 78:15]
  assign io_count = ptr_match ? _io_count_T : _io_count_T_4; // @[dut.scala 74:8]
  always @(posedge clock) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[dut.scala 20:16]
    end
    if (reset) begin // @[dut.scala 23:24]
      enq_ptr <= 4'h0; // @[dut.scala 23:24]
    end else if (do_enq) begin // @[dut.scala 38:16]
      if (enq_ptr == 4'hf) begin // @[dut.scala 41:39]
        enq_ptr <= 4'h0; // @[dut.scala 42:15]
      end else begin
        enq_ptr <= _enq_ptr_T_1; // @[dut.scala 40:13]
      end
    end
    if (reset) begin // @[dut.scala 24:24]
      deq_ptr <= 4'h0; // @[dut.scala 24:24]
    end else if (do_deq) begin // @[dut.scala 48:16]
      if (deq_ptr == 4'hf) begin // @[dut.scala 50:39]
        deq_ptr <= 4'h0; // @[dut.scala 51:15]
      end else begin
        deq_ptr <= _deq_ptr_T_1; // @[dut.scala 49:13]
      end
    end
    if (reset) begin // @[dut.scala 25:27]
      maybe_full <= 1'h0; // @[dut.scala 25:27]
    end else begin
      maybe_full <= _GEN_10;
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
