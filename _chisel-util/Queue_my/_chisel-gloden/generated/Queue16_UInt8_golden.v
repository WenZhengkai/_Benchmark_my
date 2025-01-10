module Queue16_UInt8_golden(
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
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] ram [0:15]; // @[golden.scala 33:44]
  wire  ram_io_deq_bits_MPORT_en; // @[golden.scala 33:44]
  wire [3:0] ram_io_deq_bits_MPORT_addr; // @[golden.scala 33:44]
  wire [7:0] ram_io_deq_bits_MPORT_data; // @[golden.scala 33:44]
  wire [7:0] ram_MPORT_data; // @[golden.scala 33:44]
  wire [3:0] ram_MPORT_addr; // @[golden.scala 33:44]
  wire  ram_MPORT_mask; // @[golden.scala 33:44]
  wire  ram_MPORT_en; // @[golden.scala 33:44]
  reg  ram_io_deq_bits_MPORT_en_pipe_0;
  reg [3:0] ram_io_deq_bits_MPORT_addr_pipe_0;
  reg [3:0] enq_ptr_value; // @[Counter.scala 61:40]
  reg [3:0] deq_ptr_value; // @[Counter.scala 61:40]
  reg  maybe_full; // @[golden.scala 36:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[golden.scala 37:33]
  wire  empty = ptr_match & ~maybe_full; // @[golden.scala 38:25]
  wire  full = ptr_match & maybe_full; // @[golden.scala 39:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 51:35]
  wire [3:0] _value_T_1 = enq_ptr_value + 4'h1; // @[Counter.scala 77:24]
  wire [3:0] _value_T_3 = deq_ptr_value + 4'h1; // @[Counter.scala 77:24]
  wire [4:0] _deq_ptr_next_T_1 = 5'h10 - 5'h1; // @[golden.scala 66:57]
  wire [4:0] _GEN_15 = {{1'd0}, deq_ptr_value}; // @[golden.scala 66:42]
  wire [3:0] ptr_diff = enq_ptr_value - deq_ptr_value; // @[golden.scala 86:32]
  wire [4:0] _io_count_T_1 = maybe_full & ptr_match ? 5'h10 : 5'h0; // @[golden.scala 89:20]
  wire [4:0] _GEN_16 = {{1'd0}, ptr_diff}; // @[golden.scala 89:62]
  assign ram_io_deq_bits_MPORT_en = ram_io_deq_bits_MPORT_en_pipe_0;
  assign ram_io_deq_bits_MPORT_addr = ram_io_deq_bits_MPORT_addr_pipe_0;
  assign ram_io_deq_bits_MPORT_data = ram[ram_io_deq_bits_MPORT_addr]; // @[golden.scala 33:44]
  assign ram_MPORT_data = io_enq_bits;
  assign ram_MPORT_addr = enq_ptr_value;
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[golden.scala 63:19]
  assign io_deq_valid = ~empty; // @[golden.scala 62:19]
  assign io_deq_bits = ram_io_deq_bits_MPORT_data; // @[golden.scala 68:17]
  assign io_count = _io_count_T_1 | _GEN_16; // @[golden.scala 89:62]
  always @(posedge clock) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[golden.scala 33:44]
    end
    ram_io_deq_bits_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      if (do_deq) begin
        if (_GEN_15 == _deq_ptr_next_T_1) begin // @[golden.scala 66:27]
          ram_io_deq_bits_MPORT_addr_pipe_0 <= 4'h0;
        end else begin
          ram_io_deq_bits_MPORT_addr_pipe_0 <= _value_T_3;
        end
      end else begin
        ram_io_deq_bits_MPORT_addr_pipe_0 <= deq_ptr_value;
      end
    end
    if (reset) begin // @[Counter.scala 61:40]
      enq_ptr_value <= 4'h0; // @[Counter.scala 61:40]
    end else if (do_enq) begin // @[golden.scala 46:16]
      enq_ptr_value <= _value_T_1; // @[Counter.scala 77:15]
    end
    if (reset) begin // @[Counter.scala 61:40]
      deq_ptr_value <= 4'h0; // @[Counter.scala 61:40]
    end else if (do_deq) begin // @[golden.scala 50:16]
      deq_ptr_value <= _value_T_3; // @[Counter.scala 77:15]
    end
    if (reset) begin // @[golden.scala 36:27]
      maybe_full <= 1'h0; // @[golden.scala 36:27]
    end else if (do_enq != do_deq) begin // @[golden.scala 53:27]
      maybe_full <= do_enq; // @[golden.scala 54:16]
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
  ram_io_deq_bits_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  ram_io_deq_bits_MPORT_addr_pipe_0 = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  enq_ptr_value = _RAND_3[3:0];
  _RAND_4 = {1{`RANDOM}};
  deq_ptr_value = _RAND_4[3:0];
  _RAND_5 = {1{`RANDOM}};
  maybe_full = _RAND_5[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
