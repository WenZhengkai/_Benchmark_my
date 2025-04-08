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
  wire  ptr_match = enq_ptr == deq_ptr; // @[dut.scala 25:27]
  wire  full = ptr_match & maybe_full; // @[dut.scala 28:24]
  wire  empty = ptr_match & ~maybe_full; // @[dut.scala 29:25]
  wire  do_enq = io_enq_valid & io_enq_ready; // @[dut.scala 34:29]
  wire [3:0] _enq_ptr_T_2 = enq_ptr + 4'h1; // @[dut.scala 37:62]
  wire  _T = io_deq_ready & io_deq_valid; // @[Decoupled.scala 51:35]
  wire  _GEN_6 = do_enq & ~_T | maybe_full; // @[dut.scala 41:32 42:16 24:27]
  wire [3:0] _deq_ptr_T_2 = deq_ptr + 4'h1; // @[dut.scala 48:62]
  wire  _T_3 = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  wire  _diff_T = enq_ptr >= deq_ptr; // @[dut.scala 70:13]
  wire [3:0] _diff_T_2 = enq_ptr - deq_ptr; // @[dut.scala 71:13]
  wire [4:0] _GEN_9 = {{1'd0}, enq_ptr}; // @[dut.scala 72:16]
  wire [4:0] _diff_T_4 = 5'h10 + _GEN_9; // @[dut.scala 72:16]
  wire [4:0] _GEN_10 = {{1'd0}, deq_ptr}; // @[dut.scala 72:27]
  wire [4:0] _diff_T_6 = _diff_T_4 - _GEN_10; // @[dut.scala 72:27]
  wire [4:0] diff = _diff_T ? {{1'd0}, _diff_T_2} : _diff_T_6; // @[dut.scala 69:17]
  assign ram_io_deq_bits_MPORT_en = 1'h1;
  assign ram_io_deq_bits_MPORT_addr = deq_ptr;
  assign ram_io_deq_bits_MPORT_data = ram[ram_io_deq_bits_MPORT_addr]; // @[dut.scala 19:16]
  assign ram_MPORT_data = io_enq_bits;
  assign ram_MPORT_addr = enq_ptr;
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_enq_valid & io_enq_ready;
  assign io_enq_ready = ~full; // @[dut.scala 30:19]
  assign io_deq_valid = ~empty; // @[dut.scala 31:19]
  assign io_deq_bits = ram_io_deq_bits_MPORT_data; // @[dut.scala 57:15]
  assign io_count = full ? 5'h10 : diff; // @[dut.scala 74:18]
  always @(posedge clock) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[dut.scala 19:16]
    end
    if (reset) begin // @[dut.scala 22:24]
      enq_ptr <= 4'h0; // @[dut.scala 22:24]
    end else if (do_enq) begin // @[dut.scala 35:16]
      if (enq_ptr == 4'hf) begin // @[dut.scala 37:19]
        enq_ptr <= 4'h0;
      end else begin
        enq_ptr <= _enq_ptr_T_2;
      end
    end
    if (reset) begin // @[dut.scala 23:24]
      deq_ptr <= 4'h0; // @[dut.scala 23:24]
    end else if (_T) begin // @[dut.scala 47:16]
      if (deq_ptr == 4'hf) begin // @[dut.scala 48:19]
        deq_ptr <= 4'h0;
      end else begin
        deq_ptr <= _deq_ptr_T_2;
      end
    end
    if (reset) begin // @[dut.scala 24:27]
      maybe_full <= 1'h0; // @[dut.scala 24:27]
    end else if (_T & ~_T_3) begin // @[dut.scala 52:32]
      maybe_full <= 1'h0; // @[dut.scala 53:16]
    end else begin
      maybe_full <= _GEN_6;
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
