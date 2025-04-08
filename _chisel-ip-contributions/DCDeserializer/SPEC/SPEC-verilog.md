# Specification

## Module Name
DCDeserializer

## Overview
The `DCDeserializer` module is designed to accept a serial data stream and convert it back into a multi-bit parallel word. It is particularly useful in reconstructing data that has been serialized using a corresponding serialization process. This module does not buffer the incoming transaction and only acknowledges once the entire serialized stream has been successfully processed.


## Input/Output Interface
  input        clock,
  input        reset,
  output       io_dataIn_ready,
  input        io_dataIn_valid,
  input  [4:0] io_dataIn_bits,
  input        io_dataOut_ready,
  output       io_dataOut_valid,
  output [7:0] io_dataOut_bits
## Internal Logic
1. **Cycle Calculation:**
   - The number of required cycles (`cycles`) to fully deserialize the incoming data is calculated based on the total width of the data and the width of the serialized channel. If there's any remainder when dividing the data’s total width by the serialized channel width, an additional cycle is required.

2. **Register Initialization:**
   - `cycleCount`: A register initialized to zero to keep track of the current cycle of the deserialization process. The width of this register is determined by the number of cycles using the `log2Ceil` function.
   - `dataSelect`: A vector register stores each segment of the serialized data as it arrives over multiple cycles.
   - `dataValid`: A Boolean register initialized to zero, indicating whether the deserialized data is ready to be output.

3. **Deserialization Process:**
   - The incoming `dataIn.fire` condition (ready and valid) triggers the storage of the serialized data segment into the appropriate position in `dataSelect` based on the current `cycleCount`.
   - When the final segment is received (`cycleCount` reaches `cycles - 1`), the `dataValid` flag is set to true and `cycleCount` resets to zero to prepare for the next set of data.
   - If the deserialized data (`dataOut`) is successfully transmitted (`dataOut.fire`), `dataValid` is reset to indicate readiness for the next data deserialization operation.

4. **Output Logic:**
   - The output `io.dataOut.bits` are constructed from the collected segments in `dataSelect`, io.dataOut.bits := dataSelect.asTypeOf(data)
   - The module manages flow control with the `dataOut` valid and `dataIn` ready signals to ensure proper sequencing and handling of serial data into parallel format. `dataIn` ready signals controled by `dataValid`, `io.dataOut.ready`