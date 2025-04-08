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
  reg [7:0] ram [0:15]; // @[dut.scala 13:16]
  wire  ram_io_deq_bits_MPORT_en; // @[dut.scala 13:16]
  wire [3:0] ram_io_deq_bits_MPORT_addr; // @[dut.scala 13:16]
  wire [7:0] ram_io_deq_bits_MPORT_data; // @[dut.scala 13:16]
  wire [7:0] ram_MPORT_data; // @[dut.scala 13:16]
  wire [3:0] ram_MPORT_addr; // @[dut.scala 13:16]
  wire  ram_MPORT_mask; // @[dut.scala 13:16]
  wire  ram_MPORT_en; // @[dut.scala 13:16]
  reg [3:0] enq_ptr; // @[dut.scala 16:24]
  reg [3:0] deq_ptr; // @[dut.scala 17:24]
  reg  maybe_full; // @[dut.scala 18:27]
  wire  ptr_match = enq_ptr == deq_ptr; // @[dut.scala 20:27]
  wire  full = ptr_match & maybe_full; // @[dut.scala 23:24]
  wire  empty = ptr_match & ~maybe_full; // @[dut.scala 24:25]
  wire  _T = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  wire [3:0] _enq_ptr_T_2 = enq_ptr + 4'h1; // @[dut.scala 32:62]
  wire  _T_1 = io_deq_ready & io_deq_valid; // @[Decoupled.scala 51:35]
  wire [3:0] _deq_ptr_T_2 = deq_ptr + 4'h1; // @[dut.scala 38:62]
  wire [3:0] ptr_diff = enq_ptr - deq_ptr; // @[dut.scala 56:26]
  wire [4:0] _io_count_T = maybe_full ? 5'h10 : 5'h0; // @[dut.scala 57:18]
  wire [4:0] _GEN_8 = {{1'd0}, ptr_diff}; // @[dut.scala 57:47]
  assign ram_io_deq_bits_MPORT_en = 1'h1;
  assign ram_io_deq_bits_MPORT_addr = deq_ptr;
  assign ram_io_deq_bits_MPORT_data = ram[ram_io_deq_bits_MPORT_addr]; // @[dut.scala 13:16]
  assign ram_MPORT_data = io_enq_bits;
  assign ram_MPORT_addr = enq_ptr;
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[dut.scala 26:19]
  assign io_deq_valid = ~empty; // @[dut.scala 27:19]
  assign io_deq_bits = ram_io_deq_bits_MPORT_data; // @[dut.scala 36:15]
  assign io_count = _io_count_T + _GEN_8; // @[dut.scala 57:47]
  always @(posedge clock) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[dut.scala 13:16]
    end
    if (reset) begin // @[dut.scala 16:24]
      enq_ptr <= 4'h0; // @[dut.scala 16:24]
    end else if (_T) begin // @[dut.scala 30:23]
      if (enq_ptr == 4'hf) begin // @[dut.scala 32:19]
        enq_ptr <= 4'h0;
      end else begin
        enq_ptr <= _enq_ptr_T_2;
      end
    end
    if (reset) begin // @[dut.scala 17:24]
      deq_ptr <= 4'h0; // @[dut.scala 17:24]
    end else if (_T_1) begin // @[dut.scala 37:23]
      if (deq_ptr == 4'hf) begin // @[dut.scala 38:19]
        deq_ptr <= 4'h0;
      end else begin
        deq_ptr <= _deq_ptr_T_2;
      end
    end
    if (reset) begin // @[dut.scala 18:27]
      maybe_full <= 1'h0; // @[dut.scala 18:27]
    end else if (_T != _T_1) begin // @[dut.scala 42:41]
      maybe_full <= _T; // @[dut.scala 43:16]
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
