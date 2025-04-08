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
  reg [3:0] enqPtr; // @[dut.scala 18:23]
  reg [3:0] deqPtr; // @[dut.scala 19:23]
  wire  ptrMatch = enqPtr == deqPtr; // @[dut.scala 20:25]
  reg  maybeFull; // @[dut.scala 23:26]
  wire  empty = ptrMatch & ~maybeFull; // @[dut.scala 24:24]
  wire  full = ptrMatch & maybeFull; // @[dut.scala 25:23]
  wire  _T = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  wire [3:0] _enqPtr_T_1 = enqPtr + 4'h1; // @[dut.scala 31:22]
  wire  _T_4 = io_deq_ready & io_deq_valid; // @[Decoupled.scala 51:35]
  wire [3:0] _deqPtr_T_1 = deqPtr + 4'h1; // @[dut.scala 46:22]
  wire  _T_7 = io_enq_valid & ~io_enq_ready; // @[dut.scala 50:23]
  wire [3:0] diff = enqPtr - deqPtr; // @[dut.scala 67:21]
  wire [4:0] _GEN_13 = {{1'd0}, diff}; // @[dut.scala 68:67]
  assign ram_io_deq_bits_MPORT_en = 1'h1;
  assign ram_io_deq_bits_MPORT_addr = deqPtr;
  assign ram_io_deq_bits_MPORT_data = ram[ram_io_deq_bits_MPORT_addr]; // @[dut.scala 15:16]
  assign ram_MPORT_data = io_enq_bits;
  assign ram_MPORT_addr = enqPtr;
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[dut.scala 28:19]
  assign io_deq_valid = ~empty; // @[dut.scala 43:19]
  assign io_deq_bits = ram_io_deq_bits_MPORT_data; // @[dut.scala 44:15]
  assign io_count = maybeFull ? 5'h10 : _GEN_13; // @[dut.scala 68:18]
  always @(posedge clock) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[dut.scala 15:16]
    end
    if (reset) begin // @[dut.scala 18:23]
      enqPtr <= 4'h0; // @[dut.scala 18:23]
    end else if (_T) begin // @[dut.scala 29:23]
      if (enqPtr == 4'hf) begin // @[dut.scala 32:38]
        enqPtr <= 4'h0; // @[dut.scala 33:14]
      end else begin
        enqPtr <= _enqPtr_T_1; // @[dut.scala 31:12]
      end
    end
    if (reset) begin // @[dut.scala 19:23]
      deqPtr <= 4'h0; // @[dut.scala 19:23]
    end else if (_T_4) begin // @[dut.scala 45:23]
      if (deqPtr == 4'hf) begin // @[dut.scala 47:38]
        deqPtr <= 4'h0; // @[dut.scala 48:14]
      end else begin
        deqPtr <= _deqPtr_T_1; // @[dut.scala 46:12]
      end
    end
    if (reset) begin // @[dut.scala 23:26]
      maybeFull <= 1'h0; // @[dut.scala 23:26]
    end else if (_T_4) begin // @[dut.scala 45:23]
      maybeFull <= _T_7;
    end else if (_T) begin // @[dut.scala 29:23]
      if (io_deq_ready & ~io_deq_valid) begin // @[dut.scala 35:41]
        maybeFull <= 1'h0; // @[dut.scala 36:17]
      end else begin
        maybeFull <= 1'h1; // @[dut.scala 38:17]
      end
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
