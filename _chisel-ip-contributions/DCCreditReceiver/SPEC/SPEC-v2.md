# Specification 1

---

## **Module Name**
`DCCreditReceiver`

---

## **Overview**
The `DCCreditReceiver` is a hardware module that uses credit-based flow control to manage the transmission of data between producer and consumer modules. This design ensures reliable communication in systems where latency may vary. The module incorporates a FIFO buffer to handle backpressure and manages credits between the sender and receiver to ensure no data loss and proper flow control.

This module:
- Receives data via an enqueue (`enq`) credit-based interface.
- Provides data through a decoupled dequeue (`deq`) interface.
- Tracks the count of entries in the internal FIFO buffer.
- Implements bypass logic to minimize latency when the FIFO is empty.

---
## **Parameters**
- `[D <: Data] data: D`: The type of data being sent and received. This is a generic parameter allowing flexibility in the type of data (e.g., UInt, Bundle, etc.).
- `maxCredit: Int`: The maximum depth of the FIFO buffer. This parameter determines the number of credits and the size of the internal queue.

---

## **Input/Output Interface**
### Inputs:
1. **`io.enq`** (Flipped `CreditIO`):
   - A credit-based interface for incoming data and control signals.

`` scala
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}
``

---

### Outputs:
1. **`io.deq`** (`DecoupledIO`):  
   - A decoupled interface for transmitting data to the consumer module. Data of type `D`

2. **`io.fifoCount`** (`UInt`):  
   - Tracks the number of entries currently present in the FIFO buffer.  
   - The width of the signal is determined by `log2Ceil(maxCredit + 1)`.


---
## **Internal Logic**

- **FIFO Queue**:  
   A `Queue` module is instantiated internally with a depth of `maxCredit`. Incoming data from `io.enq.bits` is enqueued to the FIFO, and valid data is dequeued when the downstream consumer signals readiness.

- **Bypass Logic**:  
   To minimize latency, the module bypasses the FIFO when the FIFO is empty, and the `io.deq.ready` consumer is ready to accept data. In this case, the valid and data signals are directly passed from the `io.enq` interface to the `io.deq` output.

- **Credit Mechanism**:  
   The credit-based flow control ensures that the sender knows when data has been consumed. Credits are issued back to the sender (`io.enq.credit`) under the following conditions:
   - If the FIFO is bypassed, credits correspond to the receiver’s readiness state.
   - If the FIFO is used, credits are issued whenever valid data is dequeued from the FIFO.

- **Registers**:  
   - `ivalid` and `idata`: Registers to store the delayed incoming `valid` and `bits` signals for synchronization.
   - `ocredit`: A register to generate the delayed credit signal (`io.enq.credit`).

- **Wire Logic**:
   - `nextCredit`: A wire that determines whether a credit should be issued based on whether the FIFO is bypassed and data is successfully consumed (`io.deq.fire`).


- **Functional Flow Description**:
  1. Incoming valid data (`io.enq.valid`) and data bits (`io.enq.bits`) are latched into registers.
  2. When the FIFO is empty, the module operates in a **bypass mode**, directly passing data to the consumer (`io.deq`).
  3. When the FIFO is non-empty, the module enqueues incoming data, and dequeues it to the consumer based on readiness.
  4. Credits are sent back to the sender under the following scenarios:
      - In bypass mode, when data is successfully accepted by the consumer.
      - From the FIFO, when data is dequeued.

- **FIFO Count**:
  The `io.fifoCount` output exposes the current number of elements stored in the FIFO queue, providing visibility of the module's internal state.

---