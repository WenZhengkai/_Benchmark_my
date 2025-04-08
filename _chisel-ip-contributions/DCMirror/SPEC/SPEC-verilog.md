# Specification

## Module Name
DCMirror

## Overview
The `DCMirror`  module is designed to distribute tokens (data payloads) to multiple output destinations. The module is controlled by a bit vector input, `dst`, which specifies the active output channels. The module ensures data is only sent if its corresponding bit in `dst` is set and handles flow control through a ready/valid handshake protocol. The `dst` bit vector must have at least one bit set for correct operation.


## Input/Output Interface

  input        clock,
  input        reset,
  input  [4:0] io_dst,
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

- **Data Register (`pData`)**:  
  A register that stores the incoming data (`io.c.bits`) when the module is ready to accept new data, indicated by `nxtAccept`. Not desided by `reset`

- **Valid Register (`pValid`)**:  
  A register initialized to zero that tracks which output channels are currently holding valid data, set according to `dst` and `io.c.valid`.

- **Ready Vector (`pReady`)**:  
  A concatenated signal of the `ready` signals from all output channels, indicating which outputs are ready to receive new data.

- **Next Accept Signal (`nxtAccept`)**:  
  A computed signal that determines when the module is ready to accept new data. It is true when no data is currently valid (`pValid === 0.U`) or when all currently valid data has been accepted by the respective outputs.

- **Data Flow Control**:  
  - When `nxtAccept` is true, The data payload is updated to the current `io.c.bits`, `pValid` is updated to reflect new valid data bits according to the active bits in `dst` and the incoming data validity (`io.c.valid`).
  **Hint**: `the data payload` do not be controled by  incoming data validity.
  - Otherwise, `pValid` retains only the bits of outputs that aren't ready (`~pReady`), effectively clearing out any accepted data.

- **Output Assignment**:  
  For each output channel `i` in `p`, the `valid` signal is driven by the corresponding bit in `pValid`, and the data `bits` is taken from the `pData` register, ensuring all active outputs receive the same data payload when valid.
