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
  reg [3:0] enqPtr; // @[dut.scala 16:23]
  reg [3:0] deqPtr; // @[dut.scala 17:23]
  reg  maybeFull; // @[dut.scala 18:26]
  wire  ptrMatch = enqPtr == deqPtr; // @[dut.scala 20:25]
  wire  empty = ptrMatch & ~maybeFull; // @[dut.scala 21:24]
  wire  full = ptrMatch & maybeFull; // @[dut.scala 22:23]
  wire  _T = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  wire  _enqPtr_T = enqPtr == 4'hf; // @[dut.scala 28:26]
  wire [3:0] _enqPtr_T_2 = enqPtr + 4'h1; // @[dut.scala 28:59]
  wire  _GEN_0 = _enqPtr_T | maybeFull; // @[dut.scala 29:38 30:17 18:26]
  wire  _GEN_7 = _T ? _GEN_0 : maybeFull; // @[dut.scala 26:23 18:26]
  wire  _T_2 = io_deq_ready & io_deq_valid; // @[Decoupled.scala 51:35]
  wire  _deqPtr_T = deqPtr == 4'hf; // @[dut.scala 38:26]
  wire [3:0] _deqPtr_T_2 = deqPtr + 4'h1; // @[dut.scala 38:59]
  wire [4:0] _io_count_T = maybeFull ? 5'h10 : 5'h0; // @[dut.scala 55:8]
  wire [4:0] _GEN_11 = {{1'd0}, enqPtr}; // @[dut.scala 56:37]
  wire [4:0] _io_count_T_3 = 5'h10 + _GEN_11; // @[dut.scala 56:37]
  wire [4:0] _GEN_12 = {{1'd0}, deqPtr}; // @[dut.scala 56:47]
  wire [4:0] _io_count_T_5 = _io_count_T_3 - _GEN_12; // @[dut.scala 56:47]
  wire [3:0] _io_count_T_7 = enqPtr - deqPtr; // @[dut.scala 56:64]
  wire [4:0] _io_count_T_8 = deqPtr > enqPtr ? _io_count_T_5 : {{1'd0}, _io_count_T_7}; // @[dut.scala 56:8]
  assign ram_io_deq_bits_MPORT_en = 1'h1;
  assign ram_io_deq_bits_MPORT_addr = deqPtr;
  assign ram_io_deq_bits_MPORT_data = ram[ram_io_deq_bits_MPORT_addr]; // @[dut.scala 13:16]
  assign ram_MPORT_data = io_enq_bits;
  assign ram_MPORT_addr = enqPtr;
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[dut.scala 25:19]
  assign io_deq_valid = ~empty; // @[dut.scala 35:19]
  assign io_deq_bits = ram_io_deq_bits_MPORT_data; // @[dut.scala 36:15]
  assign io_count = ptrMatch ? _io_count_T : _io_count_T_8; // @[dut.scala 54:18]
  always @(posedge clock) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[dut.scala 13:16]
    end
    if (reset) begin // @[dut.scala 16:23]
      enqPtr <= 4'h0; // @[dut.scala 16:23]
    end else if (_T) begin // @[dut.scala 26:23]
      if (enqPtr == 4'hf) begin // @[dut.scala 28:18]
        enqPtr <= 4'h0;
      end else begin
        enqPtr <= _enqPtr_T_2;
      end
    end
    if (reset) begin // @[dut.scala 17:23]
      deqPtr <= 4'h0; // @[dut.scala 17:23]
    end else if (_T_2) begin // @[dut.scala 37:23]
      if (deqPtr == 4'hf) begin // @[dut.scala 38:18]
        deqPtr <= 4'h0;
      end else begin
        deqPtr <= _deqPtr_T_2;
      end
    end
    if (reset) begin // @[dut.scala 18:26]
      maybeFull <= 1'h0; // @[dut.scala 18:26]
    end else if (_T_2) begin // @[dut.scala 37:23]
      if (_deqPtr_T) begin // @[dut.scala 39:38]
        maybeFull <= 1'h0; // @[dut.scala 40:17]
      end else begin
        maybeFull <= _GEN_7;
      end
    end else begin
      maybeFull <= _GEN_7;
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
  enqPtr = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  deqPtr = _RAND_2[3:0];
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
