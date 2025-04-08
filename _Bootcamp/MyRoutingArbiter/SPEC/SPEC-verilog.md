# Specification 2

## Module Name
MyRoutingArbiter
## Overview
The `MyRoutingArbiter` is a hardware design module which performs arbitration amongst multiple input channels to control access to a single output channel. When multiple input channels request access simultaneously, the arbiter selects the one with the highest priority (i.e., the lowest-indexed valid channel) and directs its data to the output.


## Input/Output Interface
  input        clock,
  input        reset,
  output       io_in_0_ready,
  input        io_in_0_valid,
  input  [7:0] io_in_0_bits,
  output       io_in_1_ready,
  input        io_in_1_valid,
  input  [7:0] io_in_1_bits,
  output       io_in_2_ready,
  input        io_in_2_valid,
  input  [7:0] io_in_2_bits,
  output       io_in_3_ready,
  input        io_in_3_valid,
  input  [7:0] io_in_3_bits,
  input        io_out_ready,
  output       io_out_valid,
  output [7:0] io_out_bits

## Internal Logic
The internal logic of the `MyRoutingArbiter` module involves the following components:

- **Output Validity:**  
  The `out.valid` signal is set to true if at least one of the input channels is valid. This is accomplished using a reduce operation with a logical OR (`||`) on the `valid` signals of all input channels.

- **Priority Selection (PriorityMux):**  
  A `PriorityMux` is used to select the channel number of the first valid input channel based on a priority order. It creates a mapping of valid signals to their respective indexes and selects the index of the first channel that is valid.

- **Data Routing:**  
  The `out.bits` signal is set to the `bits` of the input channel denoted by the selected channel index, effectively routing the data from the chosen input channel to the output.

- **Input Readiness:**  
  Each input channel's `ready` signal is determined by checking if the output is ready (`io.out.ready`) and whether the current channel is the one selected by the `PriorityMux`. This ensures that only the selected input channel, if its data is being forwarded, is marked as ready to accept new data.