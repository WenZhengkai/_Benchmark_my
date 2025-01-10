# Specification Document
## Module Name
DCHold

## Overview
The `DCHold` module creates a ready/valid holding register designed to hold a data word until it is successfully unloaded via the `deq` interface. This module ensures no combinational paths exist through it, and it allows data acceptance at most every other cycle due to its internal state management. It provides a synchronous holding mechanism between the input (enq) and output (deq) interfaces using ready and valid signaling.

## Parameters
- **[D <: Data](data: D)**: The data type for the payload. This parameter is generic and allows the module to handle any data type that extends `Data`.

## Input/Output Interface
### Input Interface
- **enq**: A flipped `DecoupledIO` bundle, with type of data


### Output Interface
- **deq**: A `DecoupledIO` bundle with type of data


## Internal Logic
1. **Registers**:
   - `pValid`: A register used to indicate whether there is currently valid data being held in the module.
   - `pData`: A register used to hold the data of type `D` being stored

2. **Data Storage and Flow Control**:
   - The module transitions state based on the handshake between `enq.valid`, `enq.ready`, `deq.valid`, and `deq.ready`.
   - When `enq.valid` is asserted and `pValid` is not, the data is captured in `pData`, and `pValid` is set to indicate the presence of valid data.
   - The module waits until the `deq.ready` signal is asserted simultaneously with `pValid` to unload and clear the stored data, resetting `pValid`.

3. **Output Assignments**:
   - `io.deq.valid` is set to the current state of `pValid`, indicating to the consumer whether the data is available.
   - `io.deq.bits` is driven by `pData`, providing the held data for consumption.
   - `io.enq.ready` is driven by the negation of `pValid`, indicating readiness to accept new data only when no data is currently being held.