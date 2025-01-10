module Buffer(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [15:0] io_enq_bits,
  input         io_deq_ready,
  output        io_deq_valid,
  output [15:0] io_deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  fullReg; // @[BubbleFifo.scala 17:26]
  reg [15:0] dataReg; // @[BubbleFifo.scala 18:22]
  wire  _GEN_1 = io_enq_valid | fullReg; // @[BubbleFifo.scala 25:26 26:17 17:26]
  assign io_enq_ready = ~fullReg; // @[BubbleFifo.scala 31:21]
  assign io_deq_valid = fullReg; // @[BubbleFifo.scala 32:18]
  assign io_deq_bits = dataReg; // @[BubbleFifo.scala 33:17]
  always @(posedge clock) begin
    if (reset) begin // @[BubbleFifo.scala 17:26]
      fullReg <= 1'h0; // @[BubbleFifo.scala 17:26]
    end else if (fullReg) begin // @[BubbleFifo.scala 20:19]
      if (io_deq_ready) begin // @[BubbleFifo.scala 21:26]
        fullReg <= 1'h0; // @[BubbleFifo.scala 22:17]
      end
    end else begin
      fullReg <= _GEN_1;
    end
    if (!(fullReg)) begin // @[BubbleFifo.scala 20:19]
      if (io_enq_valid) begin // @[BubbleFifo.scala 25:26]
        dataReg <= io_enq_bits; // @[BubbleFifo.scala 27:17]
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
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  fullReg = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  dataReg = _RAND_1[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module BubbleFifo(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [15:0] io_enq_bits,
  input         io_deq_ready,
  output        io_deq_valid,
  output [15:0] io_deq_bits
);
  wire  Buffer_clock; // @[BubbleFifo.scala 36:51]
  wire  Buffer_reset; // @[BubbleFifo.scala 36:51]
  wire  Buffer_io_enq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_io_enq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_io_enq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_io_deq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_io_deq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_io_deq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_1_clock; // @[BubbleFifo.scala 36:51]
  wire  Buffer_1_reset; // @[BubbleFifo.scala 36:51]
  wire  Buffer_1_io_enq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_1_io_enq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_1_io_enq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_1_io_deq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_1_io_deq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_1_io_deq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_2_clock; // @[BubbleFifo.scala 36:51]
  wire  Buffer_2_reset; // @[BubbleFifo.scala 36:51]
  wire  Buffer_2_io_enq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_2_io_enq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_2_io_enq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_2_io_deq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_2_io_deq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_2_io_deq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_3_clock; // @[BubbleFifo.scala 36:51]
  wire  Buffer_3_reset; // @[BubbleFifo.scala 36:51]
  wire  Buffer_3_io_enq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_3_io_enq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_3_io_enq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_3_io_deq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_3_io_deq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_3_io_deq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_4_clock; // @[BubbleFifo.scala 36:51]
  wire  Buffer_4_reset; // @[BubbleFifo.scala 36:51]
  wire  Buffer_4_io_enq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_4_io_enq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_4_io_enq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_4_io_deq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_4_io_deq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_4_io_deq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_5_clock; // @[BubbleFifo.scala 36:51]
  wire  Buffer_5_reset; // @[BubbleFifo.scala 36:51]
  wire  Buffer_5_io_enq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_5_io_enq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_5_io_enq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_5_io_deq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_5_io_deq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_5_io_deq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_6_clock; // @[BubbleFifo.scala 36:51]
  wire  Buffer_6_reset; // @[BubbleFifo.scala 36:51]
  wire  Buffer_6_io_enq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_6_io_enq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_6_io_enq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_6_io_deq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_6_io_deq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_6_io_deq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_7_clock; // @[BubbleFifo.scala 36:51]
  wire  Buffer_7_reset; // @[BubbleFifo.scala 36:51]
  wire  Buffer_7_io_enq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_7_io_enq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_7_io_enq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_7_io_deq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_7_io_deq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_7_io_deq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_8_clock; // @[BubbleFifo.scala 36:51]
  wire  Buffer_8_reset; // @[BubbleFifo.scala 36:51]
  wire  Buffer_8_io_enq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_8_io_enq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_8_io_enq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_8_io_deq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_8_io_deq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_8_io_deq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_9_clock; // @[BubbleFifo.scala 36:51]
  wire  Buffer_9_reset; // @[BubbleFifo.scala 36:51]
  wire  Buffer_9_io_enq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_9_io_enq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_9_io_enq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_9_io_deq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_9_io_deq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_9_io_deq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_10_clock; // @[BubbleFifo.scala 36:51]
  wire  Buffer_10_reset; // @[BubbleFifo.scala 36:51]
  wire  Buffer_10_io_enq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_10_io_enq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_10_io_enq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_10_io_deq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_10_io_deq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_10_io_deq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_11_clock; // @[BubbleFifo.scala 36:51]
  wire  Buffer_11_reset; // @[BubbleFifo.scala 36:51]
  wire  Buffer_11_io_enq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_11_io_enq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_11_io_enq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_11_io_deq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_11_io_deq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_11_io_deq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_12_clock; // @[BubbleFifo.scala 36:51]
  wire  Buffer_12_reset; // @[BubbleFifo.scala 36:51]
  wire  Buffer_12_io_enq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_12_io_enq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_12_io_enq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_12_io_deq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_12_io_deq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_12_io_deq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_13_clock; // @[BubbleFifo.scala 36:51]
  wire  Buffer_13_reset; // @[BubbleFifo.scala 36:51]
  wire  Buffer_13_io_enq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_13_io_enq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_13_io_enq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_13_io_deq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_13_io_deq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_13_io_deq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_14_clock; // @[BubbleFifo.scala 36:51]
  wire  Buffer_14_reset; // @[BubbleFifo.scala 36:51]
  wire  Buffer_14_io_enq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_14_io_enq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_14_io_enq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_14_io_deq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_14_io_deq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_14_io_deq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_15_clock; // @[BubbleFifo.scala 36:51]
  wire  Buffer_15_reset; // @[BubbleFifo.scala 36:51]
  wire  Buffer_15_io_enq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_15_io_enq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_15_io_enq_bits; // @[BubbleFifo.scala 36:51]
  wire  Buffer_15_io_deq_ready; // @[BubbleFifo.scala 36:51]
  wire  Buffer_15_io_deq_valid; // @[BubbleFifo.scala 36:51]
  wire [15:0] Buffer_15_io_deq_bits; // @[BubbleFifo.scala 36:51]
  Buffer Buffer ( // @[BubbleFifo.scala 36:51]
    .clock(Buffer_clock),
    .reset(Buffer_reset),
    .io_enq_ready(Buffer_io_enq_ready),
    .io_enq_valid(Buffer_io_enq_valid),
    .io_enq_bits(Buffer_io_enq_bits),
    .io_deq_ready(Buffer_io_deq_ready),
    .io_deq_valid(Buffer_io_deq_valid),
    .io_deq_bits(Buffer_io_deq_bits)
  );
  Buffer Buffer_1 ( // @[BubbleFifo.scala 36:51]
    .clock(Buffer_1_clock),
    .reset(Buffer_1_reset),
    .io_enq_ready(Buffer_1_io_enq_ready),
    .io_enq_valid(Buffer_1_io_enq_valid),
    .io_enq_bits(Buffer_1_io_enq_bits),
    .io_deq_ready(Buffer_1_io_deq_ready),
    .io_deq_valid(Buffer_1_io_deq_valid),
    .io_deq_bits(Buffer_1_io_deq_bits)
  );
  Buffer Buffer_2 ( // @[BubbleFifo.scala 36:51]
    .clock(Buffer_2_clock),
    .reset(Buffer_2_reset),
    .io_enq_ready(Buffer_2_io_enq_ready),
    .io_enq_valid(Buffer_2_io_enq_valid),
    .io_enq_bits(Buffer_2_io_enq_bits),
    .io_deq_ready(Buffer_2_io_deq_ready),
    .io_deq_valid(Buffer_2_io_deq_valid),
    .io_deq_bits(Buffer_2_io_deq_bits)
  );
  Buffer Buffer_3 ( // @[BubbleFifo.scala 36:51]
    .clock(Buffer_3_clock),
    .reset(Buffer_3_reset),
    .io_enq_ready(Buffer_3_io_enq_ready),
    .io_enq_valid(Buffer_3_io_enq_valid),
    .io_enq_bits(Buffer_3_io_enq_bits),
    .io_deq_ready(Buffer_3_io_deq_ready),
    .io_deq_valid(Buffer_3_io_deq_valid),
    .io_deq_bits(Buffer_3_io_deq_bits)
  );
  Buffer Buffer_4 ( // @[BubbleFifo.scala 36:51]
    .clock(Buffer_4_clock),
    .reset(Buffer_4_reset),
    .io_enq_ready(Buffer_4_io_enq_ready),
    .io_enq_valid(Buffer_4_io_enq_valid),
    .io_enq_bits(Buffer_4_io_enq_bits),
    .io_deq_ready(Buffer_4_io_deq_ready),
    .io_deq_valid(Buffer_4_io_deq_valid),
    .io_deq_bits(Buffer_4_io_deq_bits)
  );
  Buffer Buffer_5 ( // @[BubbleFifo.scala 36:51]
    .clock(Buffer_5_clock),
    .reset(Buffer_5_reset),
    .io_enq_ready(Buffer_5_io_enq_ready),
    .io_enq_valid(Buffer_5_io_enq_valid),
    .io_enq_bits(Buffer_5_io_enq_bits),
    .io_deq_ready(Buffer_5_io_deq_ready),
    .io_deq_valid(Buffer_5_io_deq_valid),
    .io_deq_bits(Buffer_5_io_deq_bits)
  );
  Buffer Buffer_6 ( // @[BubbleFifo.scala 36:51]
    .clock(Buffer_6_clock),
    .reset(Buffer_6_reset),
    .io_enq_ready(Buffer_6_io_enq_ready),
    .io_enq_valid(Buffer_6_io_enq_valid),
    .io_enq_bits(Buffer_6_io_enq_bits),
    .io_deq_ready(Buffer_6_io_deq_ready),
    .io_deq_valid(Buffer_6_io_deq_valid),
    .io_deq_bits(Buffer_6_io_deq_bits)
  );
  Buffer Buffer_7 ( // @[BubbleFifo.scala 36:51]
    .clock(Buffer_7_clock),
    .reset(Buffer_7_reset),
    .io_enq_ready(Buffer_7_io_enq_ready),
    .io_enq_valid(Buffer_7_io_enq_valid),
    .io_enq_bits(Buffer_7_io_enq_bits),
    .io_deq_ready(Buffer_7_io_deq_ready),
    .io_deq_valid(Buffer_7_io_deq_valid),
    .io_deq_bits(Buffer_7_io_deq_bits)
  );
  Buffer Buffer_8 ( // @[BubbleFifo.scala 36:51]
    .clock(Buffer_8_clock),
    .reset(Buffer_8_reset),
    .io_enq_ready(Buffer_8_io_enq_ready),
    .io_enq_valid(Buffer_8_io_enq_valid),
    .io_enq_bits(Buffer_8_io_enq_bits),
    .io_deq_ready(Buffer_8_io_deq_ready),
    .io_deq_valid(Buffer_8_io_deq_valid),
    .io_deq_bits(Buffer_8_io_deq_bits)
  );
  Buffer Buffer_9 ( // @[BubbleFifo.scala 36:51]
    .clock(Buffer_9_clock),
    .reset(Buffer_9_reset),
    .io_enq_ready(Buffer_9_io_enq_ready),
    .io_enq_valid(Buffer_9_io_enq_valid),
    .io_enq_bits(Buffer_9_io_enq_bits),
    .io_deq_ready(Buffer_9_io_deq_ready),
    .io_deq_valid(Buffer_9_io_deq_valid),
    .io_deq_bits(Buffer_9_io_deq_bits)
  );
  Buffer Buffer_10 ( // @[BubbleFifo.scala 36:51]
    .clock(Buffer_10_clock),
    .reset(Buffer_10_reset),
    .io_enq_ready(Buffer_10_io_enq_ready),
    .io_enq_valid(Buffer_10_io_enq_valid),
    .io_enq_bits(Buffer_10_io_enq_bits),
    .io_deq_ready(Buffer_10_io_deq_ready),
    .io_deq_valid(Buffer_10_io_deq_valid),
    .io_deq_bits(Buffer_10_io_deq_bits)
  );
  Buffer Buffer_11 ( // @[BubbleFifo.scala 36:51]
    .clock(Buffer_11_clock),
    .reset(Buffer_11_reset),
    .io_enq_ready(Buffer_11_io_enq_ready),
    .io_enq_valid(Buffer_11_io_enq_valid),
    .io_enq_bits(Buffer_11_io_enq_bits),
    .io_deq_ready(Buffer_11_io_deq_ready),
    .io_deq_valid(Buffer_11_io_deq_valid),
    .io_deq_bits(Buffer_11_io_deq_bits)
  );
  Buffer Buffer_12 ( // @[BubbleFifo.scala 36:51]
    .clock(Buffer_12_clock),
    .reset(Buffer_12_reset),
    .io_enq_ready(Buffer_12_io_enq_ready),
    .io_enq_valid(Buffer_12_io_enq_valid),
    .io_enq_bits(Buffer_12_io_enq_bits),
    .io_deq_ready(Buffer_12_io_deq_ready),
    .io_deq_valid(Buffer_12_io_deq_valid),
    .io_deq_bits(Buffer_12_io_deq_bits)
  );
  Buffer Buffer_13 ( // @[BubbleFifo.scala 36:51]
    .clock(Buffer_13_clock),
    .reset(Buffer_13_reset),
    .io_enq_ready(Buffer_13_io_enq_ready),
    .io_enq_valid(Buffer_13_io_enq_valid),
    .io_enq_bits(Buffer_13_io_enq_bits),
    .io_deq_ready(Buffer_13_io_deq_ready),
    .io_deq_valid(Buffer_13_io_deq_valid),
    .io_deq_bits(Buffer_13_io_deq_bits)
  );
  Buffer Buffer_14 ( // @[BubbleFifo.scala 36:51]
    .clock(Buffer_14_clock),
    .reset(Buffer_14_reset),
    .io_enq_ready(Buffer_14_io_enq_ready),
    .io_enq_valid(Buffer_14_io_enq_valid),
    .io_enq_bits(Buffer_14_io_enq_bits),
    .io_deq_ready(Buffer_14_io_deq_ready),
    .io_deq_valid(Buffer_14_io_deq_valid),
    .io_deq_bits(Buffer_14_io_deq_bits)
  );
  Buffer Buffer_15 ( // @[BubbleFifo.scala 36:51]
    .clock(Buffer_15_clock),
    .reset(Buffer_15_reset),
    .io_enq_ready(Buffer_15_io_enq_ready),
    .io_enq_valid(Buffer_15_io_enq_valid),
    .io_enq_bits(Buffer_15_io_enq_bits),
    .io_deq_ready(Buffer_15_io_deq_ready),
    .io_deq_valid(Buffer_15_io_deq_valid),
    .io_deq_bits(Buffer_15_io_deq_bits)
  );
  assign io_enq_ready = Buffer_io_enq_ready; // @[BubbleFifo.scala 41:10]
  assign io_deq_valid = Buffer_15_io_deq_valid; // @[BubbleFifo.scala 42:10]
  assign io_deq_bits = Buffer_15_io_deq_bits; // @[BubbleFifo.scala 42:10]
  assign Buffer_clock = clock;
  assign Buffer_reset = reset;
  assign Buffer_io_enq_valid = io_enq_valid; // @[BubbleFifo.scala 41:10]
  assign Buffer_io_enq_bits = io_enq_bits; // @[BubbleFifo.scala 41:10]
  assign Buffer_io_deq_ready = Buffer_1_io_enq_ready; // @[BubbleFifo.scala 38:27]
  assign Buffer_1_clock = clock;
  assign Buffer_1_reset = reset;
  assign Buffer_1_io_enq_valid = Buffer_io_deq_valid; // @[BubbleFifo.scala 38:27]
  assign Buffer_1_io_enq_bits = Buffer_io_deq_bits; // @[BubbleFifo.scala 38:27]
  assign Buffer_1_io_deq_ready = Buffer_2_io_enq_ready; // @[BubbleFifo.scala 38:27]
  assign Buffer_2_clock = clock;
  assign Buffer_2_reset = reset;
  assign Buffer_2_io_enq_valid = Buffer_1_io_deq_valid; // @[BubbleFifo.scala 38:27]
  assign Buffer_2_io_enq_bits = Buffer_1_io_deq_bits; // @[BubbleFifo.scala 38:27]
  assign Buffer_2_io_deq_ready = Buffer_3_io_enq_ready; // @[BubbleFifo.scala 38:27]
  assign Buffer_3_clock = clock;
  assign Buffer_3_reset = reset;
  assign Buffer_3_io_enq_valid = Buffer_2_io_deq_valid; // @[BubbleFifo.scala 38:27]
  assign Buffer_3_io_enq_bits = Buffer_2_io_deq_bits; // @[BubbleFifo.scala 38:27]
  assign Buffer_3_io_deq_ready = Buffer_4_io_enq_ready; // @[BubbleFifo.scala 38:27]
  assign Buffer_4_clock = clock;
  assign Buffer_4_reset = reset;
  assign Buffer_4_io_enq_valid = Buffer_3_io_deq_valid; // @[BubbleFifo.scala 38:27]
  assign Buffer_4_io_enq_bits = Buffer_3_io_deq_bits; // @[BubbleFifo.scala 38:27]
  assign Buffer_4_io_deq_ready = Buffer_5_io_enq_ready; // @[BubbleFifo.scala 38:27]
  assign Buffer_5_clock = clock;
  assign Buffer_5_reset = reset;
  assign Buffer_5_io_enq_valid = Buffer_4_io_deq_valid; // @[BubbleFifo.scala 38:27]
  assign Buffer_5_io_enq_bits = Buffer_4_io_deq_bits; // @[BubbleFifo.scala 38:27]
  assign Buffer_5_io_deq_ready = Buffer_6_io_enq_ready; // @[BubbleFifo.scala 38:27]
  assign Buffer_6_clock = clock;
  assign Buffer_6_reset = reset;
  assign Buffer_6_io_enq_valid = Buffer_5_io_deq_valid; // @[BubbleFifo.scala 38:27]
  assign Buffer_6_io_enq_bits = Buffer_5_io_deq_bits; // @[BubbleFifo.scala 38:27]
  assign Buffer_6_io_deq_ready = Buffer_7_io_enq_ready; // @[BubbleFifo.scala 38:27]
  assign Buffer_7_clock = clock;
  assign Buffer_7_reset = reset;
  assign Buffer_7_io_enq_valid = Buffer_6_io_deq_valid; // @[BubbleFifo.scala 38:27]
  assign Buffer_7_io_enq_bits = Buffer_6_io_deq_bits; // @[BubbleFifo.scala 38:27]
  assign Buffer_7_io_deq_ready = Buffer_8_io_enq_ready; // @[BubbleFifo.scala 38:27]
  assign Buffer_8_clock = clock;
  assign Buffer_8_reset = reset;
  assign Buffer_8_io_enq_valid = Buffer_7_io_deq_valid; // @[BubbleFifo.scala 38:27]
  assign Buffer_8_io_enq_bits = Buffer_7_io_deq_bits; // @[BubbleFifo.scala 38:27]
  assign Buffer_8_io_deq_ready = Buffer_9_io_enq_ready; // @[BubbleFifo.scala 38:27]
  assign Buffer_9_clock = clock;
  assign Buffer_9_reset = reset;
  assign Buffer_9_io_enq_valid = Buffer_8_io_deq_valid; // @[BubbleFifo.scala 38:27]
  assign Buffer_9_io_enq_bits = Buffer_8_io_deq_bits; // @[BubbleFifo.scala 38:27]
  assign Buffer_9_io_deq_ready = Buffer_10_io_enq_ready; // @[BubbleFifo.scala 38:27]
  assign Buffer_10_clock = clock;
  assign Buffer_10_reset = reset;
  assign Buffer_10_io_enq_valid = Buffer_9_io_deq_valid; // @[BubbleFifo.scala 38:27]
  assign Buffer_10_io_enq_bits = Buffer_9_io_deq_bits; // @[BubbleFifo.scala 38:27]
  assign Buffer_10_io_deq_ready = Buffer_11_io_enq_ready; // @[BubbleFifo.scala 38:27]
  assign Buffer_11_clock = clock;
  assign Buffer_11_reset = reset;
  assign Buffer_11_io_enq_valid = Buffer_10_io_deq_valid; // @[BubbleFifo.scala 38:27]
  assign Buffer_11_io_enq_bits = Buffer_10_io_deq_bits; // @[BubbleFifo.scala 38:27]
  assign Buffer_11_io_deq_ready = Buffer_12_io_enq_ready; // @[BubbleFifo.scala 38:27]
  assign Buffer_12_clock = clock;
  assign Buffer_12_reset = reset;
  assign Buffer_12_io_enq_valid = Buffer_11_io_deq_valid; // @[BubbleFifo.scala 38:27]
  assign Buffer_12_io_enq_bits = Buffer_11_io_deq_bits; // @[BubbleFifo.scala 38:27]
  assign Buffer_12_io_deq_ready = Buffer_13_io_enq_ready; // @[BubbleFifo.scala 38:27]
  assign Buffer_13_clock = clock;
  assign Buffer_13_reset = reset;
  assign Buffer_13_io_enq_valid = Buffer_12_io_deq_valid; // @[BubbleFifo.scala 38:27]
  assign Buffer_13_io_enq_bits = Buffer_12_io_deq_bits; // @[BubbleFifo.scala 38:27]
  assign Buffer_13_io_deq_ready = Buffer_14_io_enq_ready; // @[BubbleFifo.scala 38:27]
  assign Buffer_14_clock = clock;
  assign Buffer_14_reset = reset;
  assign Buffer_14_io_enq_valid = Buffer_13_io_deq_valid; // @[BubbleFifo.scala 38:27]
  assign Buffer_14_io_enq_bits = Buffer_13_io_deq_bits; // @[BubbleFifo.scala 38:27]
  assign Buffer_14_io_deq_ready = Buffer_15_io_enq_ready; // @[BubbleFifo.scala 38:27]
  assign Buffer_15_clock = clock;
  assign Buffer_15_reset = reset;
  assign Buffer_15_io_enq_valid = Buffer_14_io_deq_valid; // @[BubbleFifo.scala 38:27]
  assign Buffer_15_io_enq_bits = Buffer_14_io_deq_bits; // @[BubbleFifo.scala 38:27]
  assign Buffer_15_io_deq_ready = io_deq_ready; // @[BubbleFifo.scala 42:10]
endmodule
