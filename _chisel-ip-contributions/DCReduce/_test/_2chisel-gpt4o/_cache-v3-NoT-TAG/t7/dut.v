module DCInput_UInt8(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg  ready_r; // @[DCInput.scala 23:24]
  reg  occupied; // @[DCInput.scala 24:25]
  reg [7:0] hold; // @[DCInput.scala 25:17]
  wire  drain = occupied & io_deq_ready; // @[DCInput.scala 29:21]
  wire  load = io_enq_valid & ready_r & (~io_deq_ready | drain); // @[DCInput.scala 30:35]
  wire  _GEN_1 = drain ? 1'h0 : occupied; // @[DCInput.scala 42:21 43:14 24:25]
  wire  _GEN_2 = load | _GEN_1; // @[DCInput.scala 39:14 40:14]
  assign io_enq_ready = ready_r; // @[DCInput.scala 47:16]
  assign io_deq_valid = io_enq_valid | occupied; // @[DCInput.scala 38:32]
  assign io_deq_bits = occupied ? hold : io_enq_bits; // @[DCInput.scala 32:18 33:17 35:17]
  always @(posedge clock) begin
    ready_r <= reset | (~occupied & ~load | drain & ~load); // @[DCInput.scala 23:{24,24} 46:11]
    if (reset) begin // @[DCInput.scala 24:25]
      occupied <= 1'h0; // @[DCInput.scala 24:25]
    end else begin
      occupied <= _GEN_2;
    end
    if (load) begin // @[DCInput.scala 39:14]
      hold <= io_enq_bits; // @[DCInput.scala 41:10]
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
  ready_r = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  occupied = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  hold = _RAND_2[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module DCOutput_UInt8(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg  rValid; // @[DCOutput.scala 18:23]
  wire  _rValid_T = io_enq_ready & io_enq_valid; // @[Decoupled.scala 51:35]
  reg [7:0] io_deq_bits_r; // @[Reg.scala 19:16]
  assign io_enq_ready = io_deq_ready | ~rValid; // @[DCOutput.scala 20:32]
  assign io_deq_valid = rValid; // @[DCOutput.scala 23:16]
  assign io_deq_bits = io_deq_bits_r; // @[DCOutput.scala 22:15]
  always @(posedge clock) begin
    if (reset) begin // @[DCOutput.scala 18:23]
      rValid <= 1'h0; // @[DCOutput.scala 18:23]
    end else begin
      rValid <= _rValid_T | rValid & ~io_deq_ready; // @[DCOutput.scala 21:10]
    end
    if (_rValid_T) begin // @[Reg.scala 20:18]
      io_deq_bits_r <= io_enq_bits; // @[Reg.scala 20:22]
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
  rValid = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  io_deq_bits_r = _RAND_1[7:0];
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
  output       io_a_0_ready,
  input        io_a_0_valid,
  input  [7:0] io_a_0_bits,
  output       io_a_1_ready,
  input        io_a_1_valid,
  input  [7:0] io_a_1_bits,
  output       io_a_2_ready,
  input        io_a_2_valid,
  input  [7:0] io_a_2_bits,
  output       io_a_3_ready,
  input        io_a_3_valid,
  input  [7:0] io_a_3_bits,
  output       io_a_4_ready,
  input        io_a_4_valid,
  input  [7:0] io_a_4_bits,
  output       io_a_5_ready,
  input        io_a_5_valid,
  input  [7:0] io_a_5_bits,
  input        io_z_ready,
  output       io_z_valid,
  output [7:0] io_z_bits
);
  wire  aInt_tout_clock; // @[DCInput.scala 53:22]
  wire  aInt_tout_reset; // @[DCInput.scala 53:22]
  wire  aInt_tout_io_enq_ready; // @[DCInput.scala 53:22]
  wire  aInt_tout_io_enq_valid; // @[DCInput.scala 53:22]
  wire [7:0] aInt_tout_io_enq_bits; // @[DCInput.scala 53:22]
  wire  aInt_tout_io_deq_ready; // @[DCInput.scala 53:22]
  wire  aInt_tout_io_deq_valid; // @[DCInput.scala 53:22]
  wire [7:0] aInt_tout_io_deq_bits; // @[DCInput.scala 53:22]
  wire  aInt_tout_1_clock; // @[DCInput.scala 53:22]
  wire  aInt_tout_1_reset; // @[DCInput.scala 53:22]
  wire  aInt_tout_1_io_enq_ready; // @[DCInput.scala 53:22]
  wire  aInt_tout_1_io_enq_valid; // @[DCInput.scala 53:22]
  wire [7:0] aInt_tout_1_io_enq_bits; // @[DCInput.scala 53:22]
  wire  aInt_tout_1_io_deq_ready; // @[DCInput.scala 53:22]
  wire  aInt_tout_1_io_deq_valid; // @[DCInput.scala 53:22]
  wire [7:0] aInt_tout_1_io_deq_bits; // @[DCInput.scala 53:22]
  wire  aInt_tout_2_clock; // @[DCInput.scala 53:22]
  wire  aInt_tout_2_reset; // @[DCInput.scala 53:22]
  wire  aInt_tout_2_io_enq_ready; // @[DCInput.scala 53:22]
  wire  aInt_tout_2_io_enq_valid; // @[DCInput.scala 53:22]
  wire [7:0] aInt_tout_2_io_enq_bits; // @[DCInput.scala 53:22]
  wire  aInt_tout_2_io_deq_ready; // @[DCInput.scala 53:22]
  wire  aInt_tout_2_io_deq_valid; // @[DCInput.scala 53:22]
  wire [7:0] aInt_tout_2_io_deq_bits; // @[DCInput.scala 53:22]
  wire  aInt_tout_3_clock; // @[DCInput.scala 53:22]
  wire  aInt_tout_3_reset; // @[DCInput.scala 53:22]
  wire  aInt_tout_3_io_enq_ready; // @[DCInput.scala 53:22]
  wire  aInt_tout_3_io_enq_valid; // @[DCInput.scala 53:22]
  wire [7:0] aInt_tout_3_io_enq_bits; // @[DCInput.scala 53:22]
  wire  aInt_tout_3_io_deq_ready; // @[DCInput.scala 53:22]
  wire  aInt_tout_3_io_deq_valid; // @[DCInput.scala 53:22]
  wire [7:0] aInt_tout_3_io_deq_bits; // @[DCInput.scala 53:22]
  wire  aInt_tout_4_clock; // @[DCInput.scala 53:22]
  wire  aInt_tout_4_reset; // @[DCInput.scala 53:22]
  wire  aInt_tout_4_io_enq_ready; // @[DCInput.scala 53:22]
  wire  aInt_tout_4_io_enq_valid; // @[DCInput.scala 53:22]
  wire [7:0] aInt_tout_4_io_enq_bits; // @[DCInput.scala 53:22]
  wire  aInt_tout_4_io_deq_ready; // @[DCInput.scala 53:22]
  wire  aInt_tout_4_io_deq_valid; // @[DCInput.scala 53:22]
  wire [7:0] aInt_tout_4_io_deq_bits; // @[DCInput.scala 53:22]
  wire  aInt_tout_5_clock; // @[DCInput.scala 53:22]
  wire  aInt_tout_5_reset; // @[DCInput.scala 53:22]
  wire  aInt_tout_5_io_enq_ready; // @[DCInput.scala 53:22]
  wire  aInt_tout_5_io_enq_valid; // @[DCInput.scala 53:22]
  wire [7:0] aInt_tout_5_io_enq_bits; // @[DCInput.scala 53:22]
  wire  aInt_tout_5_io_deq_ready; // @[DCInput.scala 53:22]
  wire  aInt_tout_5_io_deq_valid; // @[DCInput.scala 53:22]
  wire [7:0] aInt_tout_5_io_deq_bits; // @[DCInput.scala 53:22]
  wire  zDcout_tout_clock; // @[DCOutput.scala 29:22]
  wire  zDcout_tout_reset; // @[DCOutput.scala 29:22]
  wire  zDcout_tout_io_enq_ready; // @[DCOutput.scala 29:22]
  wire  zDcout_tout_io_enq_valid; // @[DCOutput.scala 29:22]
  wire [7:0] zDcout_tout_io_enq_bits; // @[DCOutput.scala 29:22]
  wire  zDcout_tout_io_deq_ready; // @[DCOutput.scala 29:22]
  wire  zDcout_tout_io_deq_valid; // @[DCOutput.scala 29:22]
  wire [7:0] zDcout_tout_io_deq_bits; // @[DCOutput.scala 29:22]
  wire  aInt_0_valid = aInt_tout_io_deq_valid; // @[dut.scala 16:{21,21}]
  wire  aInt_1_valid = aInt_tout_1_io_deq_valid; // @[dut.scala 16:{21,21}]
  wire  aInt_2_valid = aInt_tout_2_io_deq_valid; // @[dut.scala 16:{21,21}]
  wire  aInt_3_valid = aInt_tout_3_io_deq_valid; // @[dut.scala 16:{21,21}]
  wire  aInt_4_valid = aInt_tout_4_io_deq_valid; // @[dut.scala 16:{21,21}]
  wire  aInt_5_valid = aInt_tout_5_io_deq_valid; // @[dut.scala 16:{21,21}]
  wire  all_valid = aInt_0_valid & aInt_1_valid & aInt_2_valid & aInt_3_valid & aInt_4_valid & aInt_5_valid; // @[dut.scala 23:46]
  wire [7:0] aInt_0_bits = aInt_tout_io_deq_bits; // @[dut.scala 16:{21,21}]
  wire [7:0] aInt_1_bits = aInt_tout_1_io_deq_bits; // @[dut.scala 16:{21,21}]
  wire [7:0] _zInt_bits_T = aInt_0_bits ^ aInt_1_bits; // @[driver.scala 6:39]
  wire [7:0] aInt_2_bits = aInt_tout_2_io_deq_bits; // @[dut.scala 16:{21,21}]
  wire [7:0] _zInt_bits_T_1 = _zInt_bits_T ^ aInt_2_bits; // @[driver.scala 6:39]
  wire [7:0] aInt_3_bits = aInt_tout_3_io_deq_bits; // @[dut.scala 16:{21,21}]
  wire [7:0] _zInt_bits_T_2 = _zInt_bits_T_1 ^ aInt_3_bits; // @[driver.scala 6:39]
  wire [7:0] aInt_4_bits = aInt_tout_4_io_deq_bits; // @[dut.scala 16:{21,21}]
  wire [7:0] _zInt_bits_T_3 = _zInt_bits_T_2 ^ aInt_4_bits; // @[driver.scala 6:39]
  wire [7:0] aInt_5_bits = aInt_tout_5_io_deq_bits; // @[dut.scala 16:{21,21}]
  wire  zInt_ready = zDcout_tout_io_enq_ready; // @[dut.scala 18:18 DCOutput.scala 30:17]
  DCInput_UInt8 aInt_tout ( // @[DCInput.scala 53:22]
    .clock(aInt_tout_clock),
    .reset(aInt_tout_reset),
    .io_enq_ready(aInt_tout_io_enq_ready),
    .io_enq_valid(aInt_tout_io_enq_valid),
    .io_enq_bits(aInt_tout_io_enq_bits),
    .io_deq_ready(aInt_tout_io_deq_ready),
    .io_deq_valid(aInt_tout_io_deq_valid),
    .io_deq_bits(aInt_tout_io_deq_bits)
  );
  DCInput_UInt8 aInt_tout_1 ( // @[DCInput.scala 53:22]
    .clock(aInt_tout_1_clock),
    .reset(aInt_tout_1_reset),
    .io_enq_ready(aInt_tout_1_io_enq_ready),
    .io_enq_valid(aInt_tout_1_io_enq_valid),
    .io_enq_bits(aInt_tout_1_io_enq_bits),
    .io_deq_ready(aInt_tout_1_io_deq_ready),
    .io_deq_valid(aInt_tout_1_io_deq_valid),
    .io_deq_bits(aInt_tout_1_io_deq_bits)
  );
  DCInput_UInt8 aInt_tout_2 ( // @[DCInput.scala 53:22]
    .clock(aInt_tout_2_clock),
    .reset(aInt_tout_2_reset),
    .io_enq_ready(aInt_tout_2_io_enq_ready),
    .io_enq_valid(aInt_tout_2_io_enq_valid),
    .io_enq_bits(aInt_tout_2_io_enq_bits),
    .io_deq_ready(aInt_tout_2_io_deq_ready),
    .io_deq_valid(aInt_tout_2_io_deq_valid),
    .io_deq_bits(aInt_tout_2_io_deq_bits)
  );
  DCInput_UInt8 aInt_tout_3 ( // @[DCInput.scala 53:22]
    .clock(aInt_tout_3_clock),
    .reset(aInt_tout_3_reset),
    .io_enq_ready(aInt_tout_3_io_enq_ready),
    .io_enq_valid(aInt_tout_3_io_enq_valid),
    .io_enq_bits(aInt_tout_3_io_enq_bits),
    .io_deq_ready(aInt_tout_3_io_deq_ready),
    .io_deq_valid(aInt_tout_3_io_deq_valid),
    .io_deq_bits(aInt_tout_3_io_deq_bits)
  );
  DCInput_UInt8 aInt_tout_4 ( // @[DCInput.scala 53:22]
    .clock(aInt_tout_4_clock),
    .reset(aInt_tout_4_reset),
    .io_enq_ready(aInt_tout_4_io_enq_ready),
    .io_enq_valid(aInt_tout_4_io_enq_valid),
    .io_enq_bits(aInt_tout_4_io_enq_bits),
    .io_deq_ready(aInt_tout_4_io_deq_ready),
    .io_deq_valid(aInt_tout_4_io_deq_valid),
    .io_deq_bits(aInt_tout_4_io_deq_bits)
  );
  DCInput_UInt8 aInt_tout_5 ( // @[DCInput.scala 53:22]
    .clock(aInt_tout_5_clock),
    .reset(aInt_tout_5_reset),
    .io_enq_ready(aInt_tout_5_io_enq_ready),
    .io_enq_valid(aInt_tout_5_io_enq_valid),
    .io_enq_bits(aInt_tout_5_io_enq_bits),
    .io_deq_ready(aInt_tout_5_io_deq_ready),
    .io_deq_valid(aInt_tout_5_io_deq_valid),
    .io_deq_bits(aInt_tout_5_io_deq_bits)
  );
  DCOutput_UInt8 zDcout_tout ( // @[DCOutput.scala 29:22]
    .clock(zDcout_tout_clock),
    .reset(zDcout_tout_reset),
    .io_enq_ready(zDcout_tout_io_enq_ready),
    .io_enq_valid(zDcout_tout_io_enq_valid),
    .io_enq_bits(zDcout_tout_io_enq_bits),
    .io_deq_ready(zDcout_tout_io_deq_ready),
    .io_deq_valid(zDcout_tout_io_deq_valid),
    .io_deq_bits(zDcout_tout_io_deq_bits)
  );
  assign io_a_0_ready = aInt_tout_io_enq_ready; // @[DCInput.scala 54:17]
  assign io_a_1_ready = aInt_tout_1_io_enq_ready; // @[DCInput.scala 54:17]
  assign io_a_2_ready = aInt_tout_2_io_enq_ready; // @[DCInput.scala 54:17]
  assign io_a_3_ready = aInt_tout_3_io_enq_ready; // @[DCInput.scala 54:17]
  assign io_a_4_ready = aInt_tout_4_io_enq_ready; // @[DCInput.scala 54:17]
  assign io_a_5_ready = aInt_tout_5_io_enq_ready; // @[DCInput.scala 54:17]
  assign io_z_valid = zDcout_tout_io_deq_valid; // @[dut.scala 46:8]
  assign io_z_bits = zDcout_tout_io_deq_bits; // @[dut.scala 46:8]
  assign aInt_tout_clock = clock;
  assign aInt_tout_reset = reset;
  assign aInt_tout_io_enq_valid = io_a_0_valid; // @[DCInput.scala 54:17]
  assign aInt_tout_io_enq_bits = io_a_0_bits; // @[DCInput.scala 54:17]
  assign aInt_tout_io_deq_ready = all_valid & zInt_ready; // @[dut.scala 33:18]
  assign aInt_tout_1_clock = clock;
  assign aInt_tout_1_reset = reset;
  assign aInt_tout_1_io_enq_valid = io_a_1_valid; // @[DCInput.scala 54:17]
  assign aInt_tout_1_io_enq_bits = io_a_1_bits; // @[DCInput.scala 54:17]
  assign aInt_tout_1_io_deq_ready = all_valid & zInt_ready; // @[dut.scala 33:18]
  assign aInt_tout_2_clock = clock;
  assign aInt_tout_2_reset = reset;
  assign aInt_tout_2_io_enq_valid = io_a_2_valid; // @[DCInput.scala 54:17]
  assign aInt_tout_2_io_enq_bits = io_a_2_bits; // @[DCInput.scala 54:17]
  assign aInt_tout_2_io_deq_ready = all_valid & zInt_ready; // @[dut.scala 33:18]
  assign aInt_tout_3_clock = clock;
  assign aInt_tout_3_reset = reset;
  assign aInt_tout_3_io_enq_valid = io_a_3_valid; // @[DCInput.scala 54:17]
  assign aInt_tout_3_io_enq_bits = io_a_3_bits; // @[DCInput.scala 54:17]
  assign aInt_tout_3_io_deq_ready = all_valid & zInt_ready; // @[dut.scala 33:18]
  assign aInt_tout_4_clock = clock;
  assign aInt_tout_4_reset = reset;
  assign aInt_tout_4_io_enq_valid = io_a_4_valid; // @[DCInput.scala 54:17]
  assign aInt_tout_4_io_enq_bits = io_a_4_bits; // @[DCInput.scala 54:17]
  assign aInt_tout_4_io_deq_ready = all_valid & zInt_ready; // @[dut.scala 33:18]
  assign aInt_tout_5_clock = clock;
  assign aInt_tout_5_reset = reset;
  assign aInt_tout_5_io_enq_valid = io_a_5_valid; // @[DCInput.scala 54:17]
  assign aInt_tout_5_io_enq_bits = io_a_5_bits; // @[DCInput.scala 54:17]
  assign aInt_tout_5_io_deq_ready = all_valid & zInt_ready; // @[dut.scala 33:18]
  assign zDcout_tout_clock = clock;
  assign zDcout_tout_reset = reset;
  assign zDcout_tout_io_enq_valid = all_valid & zInt_ready; // @[dut.scala 33:18]
  assign zDcout_tout_io_enq_bits = _zInt_bits_T_3 ^ aInt_5_bits; // @[driver.scala 6:39]
  assign zDcout_tout_io_deq_ready = io_z_ready; // @[dut.scala 46:8]
endmodule
