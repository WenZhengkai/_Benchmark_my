# Specification Document

## Module Name
DCDemux

## Overview
The `DCDemux` module is a hardware design unit that demultiplexes a stream of tokens identified by a selector signal (`sel`). It acts as the inverse of a round-robin arbiter (`RRArbiter`), where a single input channel is distributed across multiple output channels based on the selector's value. The data flow is controlled using a valid-ready handshake mechanism implemented via the `DecoupledIO` interface for both the input and output channels.



## Input/Output Interface
  input        clock,
  input        reset,
  input  [2:0] io_sel,
  output       io_c_ready,
  input        io_c_valid,
  input  [7:0] io_c_bits,
  input        io_p_0_ready,
  output       io_p_0_valid,
  output [7:0] io_p_0_bits,
  input        io_p_1_ready,
  output       io_p_1_valid,
  output [7:0] io_p_1_bits,
  input        io_p_2_ready,
  output       io_p_2_valid,
  output [7:0] io_p_2_bits,
  input        io_p_3_ready,
  output       io_p_3_valid,
  output [7:0] io_p_3_bits,
  input        io_p_4_ready,
  output       io_p_4_valid,
  output [7:0] io_p_4_bits

## Internal Logic
The internal logic of the `DCDemux` module revolves around the control of the ready-valid handshake signals to properly route the input data to one of the output channels `p(i)`. The logic proceeds as follows:

1. **Initialize Ready Signal**: Start by setting the `ready` signal of the input channel `c` to `0.U`, indicating that it is not ready by default.
2. **Iterate Over Outputs**: For each output channel `p(i)` (where `i` ranges from `0` to `n-1`), perform the following operations:
   - Assign the data bits from `c` to `p(i)`.
   - Use a conditional statement to check if the current index `i.U` matches the selector `sel` value:
     - If `i.U === sel`: Set the `valid` signal of `p(i)` to the `valid` state of `c`, and update the `ready` signal of `c` to the `ready` state of `p(i)`, indicating that the input can be received.
     - Otherwise, set the `valid` signal of `p(i)` to `0.U`, indicating that this output channel is inactive for the current input data.
