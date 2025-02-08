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
  reg [7:0] ram [0:15]; // @[dut.scala 15:16]
  wire  ram_io_deq_bits_MPORT_en; // @[dut.scala 15:16]
  wire [3:0] ram_io_deq_bits_MPORT_addr; // @[dut.scala 15:16]
  wire [7:0] ram_io_deq_bits_MPORT_data; // @[dut.scala 15:16]
  wire [7:0] ram_MPORT_data; // @[dut.scala 15:16]
  wire [3:0] ram_MPORT_addr; // @[dut.scala 15:16]
  wire  ram_MPORT_mask; // @[dut.scala 15:16]
  wire  ram_MPORT_en; // @[dut.scala 15:16]
  reg [3:0] enq_ptr; // @[dut.scala 18:24]
  reg [3:0] deq_ptr; // @[dut.scala 19:24]
  wire  ptr_match = enq_ptr == deq_ptr; // @[dut.scala 20:27]
  reg  maybe_full; // @[dut.scala 23:27]
  wire  full = ptr_match & maybe_full; // @[dut.scala 24:24]
  wire  empty = ptr_match & ~maybe_full; // @[dut.scala 25:25]
  wire  _T = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  wire [3:0] _enq_ptr_T_1 = enq_ptr + 4'h1; // @[dut.scala 30:24]
  wire  _GEN_1 = ~io_deq_ready | maybe_full; // @[dut.scala 34:36 35:18 23:27]
  wire  _T_3 = io_deq_ready & io_deq_valid; // @[Decoupled.scala 51:35]
  wire [3:0] _deq_ptr_T_1 = deq_ptr + 4'h1; // @[dut.scala 43:24]
  wire [3:0] ptr_diff = enq_ptr - deq_ptr; // @[dut.scala 60:26]
  assign ram_io_deq_bits_MPORT_en = io_deq_ready & io_deq_valid;
  assign ram_io_deq_bits_MPORT_addr = deq_ptr;
  assign ram_io_deq_bits_MPORT_data = ram[ram_io_deq_bits_MPORT_addr]; // @[dut.scala 15:16]
  assign ram_MPORT_data = io_enq_bits;
  assign ram_MPORT_addr = enq_ptr;
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[dut.scala 64:19]
  assign io_deq_valid = ~empty; // @[dut.scala 65:19]
  assign io_deq_bits = _T_3 ? ram_io_deq_bits_MPORT_data : 8'h0; // @[dut.scala 40:15 41:23 42:17]
  assign io_count = maybe_full & ptr_match ? 5'h10 : {{1'd0}, ptr_diff}; // @[dut.scala 61:18]
  always @(posedge clock) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[dut.scala 15:16]
    end
    if (reset) begin // @[dut.scala 18:24]
      enq_ptr <= 4'h0; // @[dut.scala 18:24]
    end else if (_T) begin // @[dut.scala 28:23]
      if (enq_ptr == 4'hf) begin // @[dut.scala 31:39]
        enq_ptr <= 4'h0; // @[dut.scala 32:15]
      end else begin
        enq_ptr <= _enq_ptr_T_1; // @[dut.scala 30:13]
      end
    end
    if (reset) begin // @[dut.scala 19:24]
      deq_ptr <= 4'h0; // @[dut.scala 19:24]
    end else if (_T_3) begin // @[dut.scala 41:23]
      if (deq_ptr == 4'hf) begin // @[dut.scala 44:39]
        deq_ptr <= 4'h0; // @[dut.scala 45:15]
      end else begin
        deq_ptr <= _deq_ptr_T_1; // @[dut.scala 43:13]
      end
    end
    if (reset) begin // @[dut.scala 23:27]
      maybe_full <= 1'h0; // @[dut.scala 23:27]
    end else if (_T_3) begin // @[dut.scala 41:23]
      maybe_full <= 1'h0; // @[dut.scala 47:16]
    end else if (_T) begin // @[dut.scala 28:23]
      maybe_full <= _GEN_1;
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
