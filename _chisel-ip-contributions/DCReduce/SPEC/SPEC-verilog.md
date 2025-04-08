
# Specification

## Module Name
DCReduce

## Overview
The `DCReduce` module is a hardware module that implements a multi-input decoupled operator. It makes use of `DCInput` and `DCOutput` to create a module with registered-output timing. The module takes multiple data inputs, performs a reduction operation on the inputs using a specified binary operator, and outputs the result.

## Library
 `DCInput` and `DCOutput`, they both have their Helper function for functional inference:
``` verilog
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
```



## Input/Output Interface
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

## Internal Logic
1. **Initialization:** 
   - The module generates a vector of internal decoupled inputs `aInt` using `DCInput` for each input in `io.a`.
   - An internal wire `zInt` of type `Decoupled` acts as an intermediary for the output computation.

2. **Logic Computation:**
   - Compute an `all_valid` signal that checks if all of the inputs in `aInt` are valid.
   - Perform the reduction operation using the provided `op` function on the `bits` of all valid inputs in `aInt` to produce the result stored in `zInt.bits`.

3. **Output Control:**
   - If all the inputs are valid and `zInt` is ready to accept new data, set `zInt.valid` to `true` and set all `aInt(n).ready` signals to `true`.
   - Otherwise, set `zInt.valid` to `false` and all `aInt(n).ready` signals to `false`.
   - Connect `zInt` to `zDcout` using `DCOutput` and interface `io.z` with `zDcout`.

