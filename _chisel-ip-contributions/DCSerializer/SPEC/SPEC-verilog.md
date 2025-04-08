# Specification

---

## Module Name:
`DCSerializer`

---

## Overview:
The `DCSerializer` module is designed to serialize an arbitrary data structure (`D <: Data`) into a sequence of output words of fixed width (`width` bits). The module operates in a streaming fashion - the input data is serialized and transmitted across the output channel one word at a time. The input transaction is deemed complete and acknowledged once the entire serialized stream has been sent.
---


## Input/Output Interface:

  input        clock,
  input        reset,
  output       io_dataIn_ready,
  input        io_dataIn_valid,
  input  [7:0] io_dataIn_bits,
  input        io_dataOut_ready,
  output       io_dataOut_valid,
  output [4:0] io_dataOut_bits

## Internal Logic:

1. **Cycle Calculation:**
   - The number of cycles required to serialize the input data is calculated as `cycles`. 
   - if (data.getWidth % width != 0) data.getWidth / width + 1 else data.getWidth / width

2. **Cycle Counter:**
   - A register (`cycleCount`) is maintained to track the current cycle of serialization. Its init value is `0`
   - The `cycleCount` is incremented on each valid transmission (`io.dataOut.fire`).
   - It is set to `0` when a new data transaction is acknowledged.

3. **Data Select Logic:**
   - The input data is split into multiple words of size `width` and stored in a `Vec` called `dataSelect`.
   - The correct word is selected for output based on the current cycle (`cycleCount`).

4. **Handshaking Behavior:**
   - **Input Ready (`io.dataIn.ready`):**
     - The input is ready to accept the next transaction when the `cycleCount` reaches the end of the serialization process (i.e., `(cycles - 1).U`), and the output channel is ready (`io.dataOut.ready`).
   - **Output Valid (`io.dataOut.valid`):**
     - Output is valid when the input data is valid (`io.dataIn.valid`).

---
