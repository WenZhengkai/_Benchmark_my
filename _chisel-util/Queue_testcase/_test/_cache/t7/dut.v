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
  wire  ptrMatch = enqPtr == deqPtr; // @[dut.scala 18:25]
  reg  maybeFull; // @[dut.scala 21:26]
  wire  full = ptrMatch & maybeFull; // @[dut.scala 22:23]
  wire  empty = ptrMatch & ~maybeFull; // @[dut.scala 23:24]
  wire  _doEnq_T = ~full; // @[dut.scala 26:31]
  wire  doEnq = io_enq_valid & ~full; // @[dut.scala 26:28]
  wire [3:0] _enqPtr_T_2 = enqPtr + 4'h1; // @[dut.scala 29:59]
  wire  _GEN_0 = ptrMatch | maybeFull; // @[dut.scala 21:26 30:{29,41}]
  wire  _GEN_7 = doEnq ? _GEN_0 : maybeFull; // @[dut.scala 27:15 21:26]
  wire  doDeq = io_deq_ready & ~empty; // @[dut.scala 34:28]
  wire [3:0] _deqPtr_T_2 = deqPtr + 4'h1; // @[dut.scala 37:59]
  wire  _io_count_T = enqPtr >= deqPtr; // @[dut.scala 52:12]
  wire [3:0] _io_count_T_2 = enqPtr - deqPtr; // @[dut.scala 53:12]
  wire [4:0] _GEN_11 = {{1'd0}, enqPtr}; // @[dut.scala 54:15]
  wire [4:0] _io_count_T_4 = 5'h10 + _GEN_11; // @[dut.scala 54:15]
  wire [4:0] _GEN_12 = {{1'd0}, deqPtr}; // @[dut.scala 54:24]
  wire [4:0] _io_count_T_6 = _io_count_T_4 - _GEN_12; // @[dut.scala 54:24]
  assign ram_io_deq_bits_MPORT_en = 1'h1;
  assign ram_io_deq_bits_MPORT_addr = deqPtr;
  assign ram_io_deq_bits_MPORT_data = ram[ram_io_deq_bits_MPORT_addr]; // @[dut.scala 13:16]
  assign ram_MPORT_data = io_enq_bits;
  assign ram_MPORT_addr = enqPtr;
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_enq_valid & _doEnq_T;
  assign io_enq_ready = ~full; // @[dut.scala 58:19]
  assign io_deq_valid = ~empty; // @[dut.scala 59:19]
  assign io_deq_bits = ram_io_deq_bits_MPORT_data; // @[dut.scala 35:15]
  assign io_count = _io_count_T ? {{1'd0}, _io_count_T_2} : _io_count_T_6; // @[dut.scala 51:18]
  always @(posedge clock) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[dut.scala 13:16]
    end
    if (reset) begin // @[dut.scala 16:23]
      enqPtr <= 4'h0; // @[dut.scala 16:23]
    end else if (doEnq) begin // @[dut.scala 27:15]
      if (enqPtr == 4'hf) begin // @[dut.scala 29:18]
        enqPtr <= 4'h0;
      end else begin
        enqPtr <= _enqPtr_T_2;
      end
    end
    if (reset) begin // @[dut.scala 17:23]
      deqPtr <= 4'h0; // @[dut.scala 17:23]
    end else if (doDeq) begin // @[dut.scala 36:15]
      if (deqPtr == 4'hf) begin // @[dut.scala 37:18]
        deqPtr <= 4'h0;
      end else begin
        deqPtr <= _deqPtr_T_2;
      end
    end
    if (reset) begin // @[dut.scala 21:26]
      maybeFull <= 1'h0; // @[dut.scala 21:26]
    end else if (doDeq) begin // @[dut.scala 36:15]
      if (deqPtr == enqPtr) begin // @[dut.scala 38:29]
        maybeFull <= 1'h0; // @[dut.scala 38:41]
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
