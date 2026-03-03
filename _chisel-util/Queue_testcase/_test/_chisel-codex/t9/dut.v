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
  reg [7:0] ram [0:15]; // @[dut.scala 11:22]
  wire  ram_io_deq_bits_MPORT_en; // @[dut.scala 11:22]
  wire [3:0] ram_io_deq_bits_MPORT_addr; // @[dut.scala 11:22]
  wire [7:0] ram_io_deq_bits_MPORT_data; // @[dut.scala 11:22]
  wire [7:0] ram_MPORT_data; // @[dut.scala 11:22]
  wire [3:0] ram_MPORT_addr; // @[dut.scala 11:22]
  wire  ram_MPORT_mask; // @[dut.scala 11:22]
  wire  ram_MPORT_en; // @[dut.scala 11:22]
  reg [3:0] enq_ptr; // @[dut.scala 12:26]
  reg [3:0] deq_ptr; // @[dut.scala 13:26]
  reg  maybeFull; // @[dut.scala 14:26]
  wire  ptrMatch = enq_ptr == deq_ptr; // @[dut.scala 21:26]
  wire  empty = ptrMatch & ~maybeFull; // @[dut.scala 22:27]
  wire  full = ptrMatch & maybeFull; // @[dut.scala 23:27]
  wire  do_enq = io_enq_valid & io_enq_ready; // @[dut.scala 29:29]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[dut.scala 30:29]
  wire [3:0] _enq_ptr_T_2 = enq_ptr + 4'h1; // @[dut.scala 18:48]
  wire [3:0] _deq_ptr_T_2 = deq_ptr + 4'h1; // @[dut.scala 18:48]
  wire [4:0] _wrappedDistance_T_1 = {1'b0,$signed(deq_ptr)}; // @[dut.scala 56:63]
  wire [4:0] _wrappedDistance_T_3 = 5'h10 - _wrappedDistance_T_1; // @[dut.scala 56:48]
  wire [4:0] _GEN_10 = {{1'd0}, enq_ptr}; // @[dut.scala 56:88]
  wire [4:0] wrappedDistance = _wrappedDistance_T_3 + _GEN_10; // @[dut.scala 56:88]
  wire [3:0] linearDistance = enq_ptr - deq_ptr; // @[dut.scala 57:33]
  wire [4:0] _countWire_T = maybeFull ? 5'h10 : 5'h0; // @[dut.scala 60:21]
  wire [4:0] _GEN_8 = deq_ptr > enq_ptr ? wrappedDistance : {{1'd0}, linearDistance}; // @[dut.scala 61:33 62:15 64:15]
  assign ram_io_deq_bits_MPORT_en = 1'h1;
  assign ram_io_deq_bits_MPORT_addr = deq_ptr;
  assign ram_io_deq_bits_MPORT_data = ram[ram_io_deq_bits_MPORT_addr]; // @[dut.scala 11:22]
  assign ram_MPORT_data = io_enq_bits;
  assign ram_MPORT_addr = enq_ptr;
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_enq_valid & io_enq_ready;
  assign io_enq_ready = ~full; // @[dut.scala 25:19]
  assign io_deq_valid = ~empty; // @[dut.scala 26:19]
  assign io_deq_bits = ram_io_deq_bits_MPORT_data; // @[dut.scala 27:16]
  assign io_count = ptrMatch ? _countWire_T : _GEN_8; // @[dut.scala 59:18 60:15]
  always @(posedge clock) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[dut.scala 11:22]
    end
    if (reset) begin // @[dut.scala 12:26]
      enq_ptr <= 4'h0; // @[dut.scala 12:26]
    end else if (do_enq) begin // @[dut.scala 32:16]
      if (enq_ptr == 4'hf) begin // @[dut.scala 18:13]
        enq_ptr <= 4'h0;
      end else begin
        enq_ptr <= _enq_ptr_T_2;
      end
    end
    if (reset) begin // @[dut.scala 13:26]
      deq_ptr <= 4'h0; // @[dut.scala 13:26]
    end else if (do_deq) begin // @[dut.scala 37:16]
      if (deq_ptr == 4'hf) begin // @[dut.scala 18:13]
        deq_ptr <= 4'h0;
      end else begin
        deq_ptr <= _deq_ptr_T_2;
      end
    end
    if (reset) begin // @[dut.scala 14:26]
      maybeFull <= 1'h0; // @[dut.scala 14:26]
    end else if (do_enq != do_deq) begin // @[dut.scala 41:27]
      maybeFull <= do_enq; // @[dut.scala 42:15]
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
  maybeFull = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
