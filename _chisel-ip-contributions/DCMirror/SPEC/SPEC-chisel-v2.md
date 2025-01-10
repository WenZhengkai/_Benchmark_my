# Specification 2

## Module Name
DCMirror

## Overview
The `DCMirror` Chisel module is designed to distribute tokens (data payloads) to multiple output destinations. The module is controlled by a bit vector input, `dst`, which specifies the active output channels. The module ensures data is only sent if its corresponding bit in `dst` is set and handles flow control through a ready/valid handshake protocol. The `dst` bit vector must have at least one bit set for correct operation.

## Parameters
- **`data`**: The type of the payload data (`D <: Data`). It defines the type of data being mirrored to the outputs.
- **`n`**: An integer specifying the number of output destinations. This dictates the width of the `dst` bit vector and the number of output channels.

## Input/Output Interface

### Inputs
- **`dst`**: `Input(UInt(n.W))`  
  This input is a bit vector of width `n` that determines which output channels should receive the data. Each bit corresponds to an output destination, indicating whether the destination is active (1) or inactive (0).

- **`c`**: `Flipped(new DecoupledIO(data.cloneType))`  
  This is the input channel for the data payload. It follows the DecoupledIO interface with signals:
  - `valid`: Indicates when the data is valid.
  - `bits`: Carries the data payload of type `data`.
  - `ready`: Indicates when the component can accept new valid data.

### Outputs
- **`p`**: `Vec(n, new DecoupledIO(data.cloneType))`  
  An array of output channels corresponding to the potential destinations. Each channel follows the DecoupledIO interface:
  - `valid`: Indicates when the data being sent is valid.
  - `bits`: Carries the data payload of type `data`.
  - `ready`: A signal from each output that indicates its readiness to receive data.

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
  - Otherwise, `pValid` retains only the bits of outputs that aren't ready (`~pReady`), effectively clearing out any accepted data.

- **Output Assignment**:  
  For each output channel `i` in `p`, the `valid` signal is driven by the corresponding bit in `pValid`, and the data `bits` is taken from the `pData` register, ensuring all active outputs receive the same data payload when valid.
