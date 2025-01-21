# Specification 2

---

#### Module Name:
`DCSerializer`

---

#### Overview:
The `DCSerializer` module is designed to serialize an arbitrary Chisel data structure (`D <: Data`) into a sequence of output words of fixed width (`W` bits). The module operates in a streaming fashion - the input data is serialized and transmitted across the output channel one word at a time. The input transaction is deemed complete and acknowledged once the entire serialized stream has been sent.

This module is particularly useful in scenarios where wide data structures or buses need to be transmitted over narrower data channels.

---

#### Parameters:
1. **`data`** (`[D <: Data] D`): 
   - Defines the data structure that will be serialized. The Chisel datatype determines how the input data is structured and parsed during serialization.

2. **`width`** (`Int`): 
   - Specifies the width (in bits) of the serialized output channel. This determines the granularity of each serialized data word. 
   - Must be less than the bit-width of the input `data`.

---

#### Input/Output Interface:

1. **Inputs:**
   - **`io.dataIn`** (`Flipped(Decoupled(data))`): 
     - Handshaking interface for accepting the input data to be serialized.
     - The module pulls from this interface only when it is ready for a new transaction.
   
2. **Outputs:**
   - **`io.dataOut`** (`Decoupled(UInt(width.W))`): 
     - Handshaking interface to provide serialized data words (`UInt(width.W)`).
     - Serialized data is transmitted across this channel, one word per cycle.

---

#### Internal Logic:

1. **Cycle Calculation:**
   - The number of cycles required to serialize the input data is calculated as `cycles = dataWidth / width`. 
   - If the `dataWidth % width` is not zero, one additional cycle is required to accommodate the remainder (`cycles = dataWidth / width + 1`).


2. **Cycle Counter:**
   - A register (`cycleCount`) is maintained to track the current cycle of serialization. 
   - The `cycleCount` is incremented on each valid transmission (`io.dataOut.fire`).
   - It is reset to `0` when a new data transaction is acknowledged.

3. **Data Select Logic:**
   - The input data is split into multiple words of size `width` and stored in a `Vec` called `dataSelect`.
   - The correct word is selected for output based on the current cycle (`cycleCount`).

4. **Handshaking Behavior:**
   - **Input Ready (`io.dataIn.ready`):**
     - The input is ready to accept the next transaction when the `cycleCount` reaches the end of the serialization process (i.e., `(cycles - 1).U`), and the output channel is ready (`io.dataOut.ready`).
   - **Output Valid (`io.dataOut.valid`):**
     - Output is valid when the input data is valid (`io.dataIn.valid`).

5. **Transaction Flow:**
   - A new transaction begins when `io.dataIn.fire` (both `valid` and `ready` for `io.dataIn`).
   - Serialized data is transmitted over `cycles` cycles, where during each cycle a part of the input data is sent out via `io.dataOut`.

6. **Design Constraints:**
   - The parameter `cycles` is required to be greater than `1` to ensure meaningful serialization (i.e., the `width` of the output channel must be narrower than the width of the input data).

---
