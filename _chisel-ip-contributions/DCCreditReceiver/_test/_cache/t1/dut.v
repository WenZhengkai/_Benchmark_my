module Queue(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits,
  output [2:0] io_count
);
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] ram [0:4]; // @[Decoupled.scala 273:95]
  wire  ram_io_deq_bits_MPORT_en; // @[Decoupled.scala 273:95]
  wire [2:0] ram_io_deq_bits_MPORT_addr; // @[Decoupled.scala 273:95]
  wire [7:0] ram_io_deq_bits_MPORT_data; // @[Decoupled.scala 273:95]
  wire [7:0] ram_MPORT_data; // @[Decoupled.scala 273:95]
  wire [2:0] ram_MPORT_addr; // @[Decoupled.scala 273:95]
  wire  ram_MPORT_mask; // @[Decoupled.scala 273:95]
  wire  ram_MPORT_en; // @[Decoupled.scala 273:95]
  reg [2:0] enq_ptr_value; // @[Counter.scala 61:40]
  reg [2:0] deq_ptr_value; // @[Counter.scala 61:40]
  reg  maybe_full; // @[Decoupled.scala 276:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[Decoupled.scala 277:33]
  wire  empty = ptr_match & ~maybe_full; // @[Decoupled.scala 278:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 279:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 51:35]
  wire  wrap = enq_ptr_value == 3'h4; // @[Counter.scala 73:24]
  wire [2:0] _value_T_1 = enq_ptr_value + 3'h1; // @[Counter.scala 77:24]
  wire  wrap_1 = deq_ptr_value == 3'h4; // @[Counter.scala 73:24]
  wire [2:0] _value_T_3 = deq_ptr_value + 3'h1; // @[Counter.scala 77:24]
  wire [2:0] ptr_diff = enq_ptr_value - deq_ptr_value; // @[Decoupled.scala 326:32]
  wire [2:0] _io_count_T = maybe_full ? 3'h5 : 3'h0; // @[Decoupled.scala 333:10]
  wire [2:0] _io_count_T_3 = 3'h5 + ptr_diff; // @[Decoupled.scala 334:57]
  wire [2:0] _io_count_T_4 = deq_ptr_value > enq_ptr_value ? _io_count_T_3 : ptr_diff; // @[Decoupled.scala 334:10]
  assign ram_io_deq_bits_MPORT_en = 1'h1;
  assign ram_io_deq_bits_MPORT_addr = deq_ptr_value;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign ram_io_deq_bits_MPORT_data = ram[ram_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  `else
  assign ram_io_deq_bits_MPORT_data = ram_io_deq_bits_MPORT_addr >= 3'h5 ? _RAND_1[7:0] :
    ram[ram_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 273:95]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign ram_MPORT_data = io_enq_bits;
  assign ram_MPORT_addr = enq_ptr_value;
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[Decoupled.scala 303:19]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 302:19]
  assign io_deq_bits = ram_io_deq_bits_MPORT_data; // @[Decoupled.scala 310:17]
  assign io_count = ptr_match ? _io_count_T : _io_count_T_4; // @[Decoupled.scala 331:20]
  always @(posedge clock) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[Decoupled.scala 273:95]
    end
    if (reset) begin // @[Counter.scala 61:40]
      enq_ptr_value <= 3'h0; // @[Counter.scala 61:40]
    end else if (do_enq) begin // @[Decoupled.scala 286:16]
      if (wrap) begin // @[Counter.scala 87:20]
        enq_ptr_value <= 3'h0; // @[Counter.scala 87:28]
      end else begin
        enq_ptr_value <= _value_T_1; // @[Counter.scala 77:15]
      end
    end
    if (reset) begin // @[Counter.scala 61:40]
      deq_ptr_value <= 3'h0; // @[Counter.scala 61:40]
    end else if (do_deq) begin // @[Decoupled.scala 290:16]
      if (wrap_1) begin // @[Counter.scala 87:20]
        deq_ptr_value <= 3'h0; // @[Counter.scala 87:28]
      end else begin
        deq_ptr_value <= _value_T_3; // @[Counter.scala 77:15]
      end
    end
    if (reset) begin // @[Decoupled.scala 276:27]
      maybe_full <= 1'h0; // @[Decoupled.scala 276:27]
    end else if (do_enq != do_deq) begin // @[Decoupled.scala 293:27]
      maybe_full <= do_enq; // @[Decoupled.scala 294:16]
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
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  _RAND_1 = {1{`RANDOM}};
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 5; initvar = initvar+1)
    ram[initvar] = _RAND_0[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  enq_ptr_value = _RAND_2[2:0];
  _RAND_3 = {1{`RANDOM}};
  deq_ptr_value = _RAND_3[2:0];
  _RAND_4 = {1{`RANDOM}};
  maybe_full = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module dut(
  input        clock,
  input        reset,
  input        io_enq_valid,
  output       io_enq_credit,
  input  [7:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits,
  output [2:0] io_fifoCount
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  outFifo_clock; // @[dut.scala 18:23]
  wire  outFifo_reset; // @[dut.scala 18:23]
  wire  outFifo_io_enq_ready; // @[dut.scala 18:23]
  wire  outFifo_io_enq_valid; // @[dut.scala 18:23]
  wire [7:0] outFifo_io_enq_bits; // @[dut.scala 18:23]
  wire  outFifo_io_deq_ready; // @[dut.scala 18:23]
  wire  outFifo_io_deq_valid; // @[dut.scala 18:23]
  wire [7:0] outFifo_io_deq_bits; // @[dut.scala 18:23]
  wire [2:0] outFifo_io_count; // @[dut.scala 18:23]
  reg  ivalid; // @[dut.scala 21:23]
  reg [7:0] idata; // @[dut.scala 22:22]
  wire  _io_deq_bits_T_2 = ~outFifo_io_deq_valid & outFifo_io_count == 3'h0; // @[dut.scala 28:44]
  wire  _nextCredit_T = outFifo_io_deq_ready & outFifo_io_deq_valid; // @[Decoupled.scala 51:35]
  reg  ocredit; // @[dut.scala 41:24]
  Queue outFifo ( // @[dut.scala 18:23]
    .clock(outFifo_clock),
    .reset(outFifo_reset),
    .io_enq_ready(outFifo_io_enq_ready),
    .io_enq_valid(outFifo_io_enq_valid),
    .io_enq_bits(outFifo_io_enq_bits),
    .io_deq_ready(outFifo_io_deq_ready),
    .io_deq_valid(outFifo_io_deq_valid),
    .io_deq_bits(outFifo_io_deq_bits),
    .io_count(outFifo_io_count)
  );
  assign io_enq_credit = ocredit; // @[dut.scala 42:17]
  assign io_deq_valid = _io_deq_bits_T_2 ? ivalid : outFifo_io_deq_valid; // @[dut.scala 29:22]
  assign io_deq_bits = ~outFifo_io_deq_valid & outFifo_io_count == 3'h0 ? idata : outFifo_io_deq_bits; // @[dut.scala 28:21]
  assign io_fifoCount = outFifo_io_count; // @[dut.scala 30:16]
  assign outFifo_clock = clock;
  assign outFifo_reset = reset;
  assign outFifo_io_enq_valid = io_deq_ready ? 1'h0 : ivalid; // @[dut.scala 34:30]
  assign outFifo_io_enq_bits = idata; // @[dut.scala 33:23]
  assign outFifo_io_deq_ready = io_deq_ready; // @[dut.scala 37:24]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 21:23]
      ivalid <= 1'h0; // @[dut.scala 21:23]
    end else begin
      ivalid <= io_enq_valid; // @[dut.scala 21:23]
    end
    idata <= io_enq_bits; // @[dut.scala 22:22]
    if (reset) begin // @[dut.scala 41:24]
      ocredit <= 1'h0; // @[dut.scala 41:24]
    end else if (io_deq_ready) begin // @[dut.scala 40:20]
      ocredit <= ivalid;
    end else begin
      ocredit <= _nextCredit_T;
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
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  ivalid = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  idata = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  ocredit = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
