# Specification 1
## Module Name

DCCreditSender

## Overview

The `DCCreditSender` module is a Chisel implementation of a credit-based flow control sender. This module is intended to manage the flow control in digital communication systems, environment-insensitive to variable latency delays. It accepts input data through an enqueue interface and sends output data through a dequeue interface with the use of credit-based flow control. The credit mechanism helps ensure that the data exchange between different modules remains synchronized and prevents data overflow or underflow conditions.

## Parameters

- `[D <: Data]data: D`: Represents the type of data that will be enqueued and dequeued from the module. It must be a chisel data type or extend from it.
- `maxCredit: Int`: An integer parameter that defines the maximum number of credits the sender can hold. It must be greater than or equal to 1.

## Input/Output Interface

### Inputs

- `enq` (Flipped Decoupled[Data]): This interface accepts data to be sent through the `DCCreditSender`. It contains:
  - `bits: Data`: The actual data payload to be sent.
  - `valid: Bool`: A flag indicating that the data is valid and ready for processing.

- `credit` (Input Bool): A signal indicating that a credit has been received. When high, it implies receipt of a credit from the receiver side, allowing the sender one more opportunity to transmit data.

### Outputs

- `deq` (CreditIO[Data]): This is the dequeue/output interface provided by the `DCCreditSender`. It consists of:
  - `valid: Bool`: A flag indicating that the output data is valid and ready to be read by the receiving system.
  - `credit: Bool`
  - `bits: Data`: The data payload sent from the module.
  
- `curCredit` (UInt(log2Ceil(maxCredit).W)): Displays the current number of credits the sender has available. Its width is determined by the log base 2 of `maxCredit`.
`` scala
class CreditIO[D <: Data](data: D) extends Bundle {
  val valid = Output(Bool())
  val credit = Input(Bool())
  val bits = Output(data.cloneType)
}
``
## Internal Logic

- **Credit Register (icredit):** Internally maintains the latched status of the dequeue credit signal. This helps in decision-making when the module determines whether to credit or debit its credit count.

- **Credit Counter (curCredit):** A register initialized to the `maxCredit` value that keeps track of the currently available credits. Its value is incremented when a credit is received (input credit high, output data not enqueued), and decremented when the enqueued data is sent (output data enqueued, no credit received).

- **Ready Signal (`io.enq.ready`):** A readiness indication flag for the enqueue interface, toggling high when `curCredit` is greater than zero, signifying it's ready to accept new data.

- **Data Register (dataOut) & Valid Register (validOut):** Temporary registers for holding data payloads meant for dequeue and maintaining a valid status flag respectively utilizing RegEnable and RegNext primitives.
