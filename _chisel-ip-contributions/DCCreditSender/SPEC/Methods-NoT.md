
## Base Method
Please act as a professional Chisel designer. Give me the complete Chisel code.

```
# Specification
## Module Name

DCCreditSender

## Overview

The `DCCreditSender` module is a Chisel implementation of a credit-based flow control sender. This module is intended to manage the flow control in digital communication systems, environment-insensitive to variable latency delays. It accepts input data through an enqueue interface and sends output data through a dequeue interface with the use of credit-based flow control. The credit mechanism helps ensure that the data exchange between different modules remains synchronized and prevents data overflow or underflow conditions.

## Parameters

- `[D <: Data]data: D`: Represents the type of data that will be enqueued and dequeued from the module. It must be a chisel data type or extend from it.
- `maxCredit: Int`: An integer parameter that defines the maximum number of credits the sender can hold. It must be greater than or equal to 1.

## Input/Output Interface

### Inputs

- `enq` (Flipped Decoupled[Data]): This interface accepts data to be sent through the `DCCreditSender`.
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

- **Credit Counter (curCredit):** A register initialized to the `maxCredit` value that keeps track of the currently available credits. Its value is incremented when a credit is received (icredit high, enq.fire is low), and decremented when the enqueued data is sent (icredit low, enq.fire is high).

- **Ready Signal (`io.enq.ready`):** A readiness indication flag for the enqueue interface, toggling high when `curCredit` is greater than zero, signifying it's ready to accept new data.

- **Data Register (dataOut) & Valid Register (validOut):** Temporary registers for holding data payloads meant for dequeue and maintaining a valid status flag respectively utilizing RegEnable and RegNext primitives.

```

Give me the complete Chisel code.


## NoT Method s1-Spec Slicer
Please act as a professional Chisel designer. Slice the `Internal logic` into several coding tasks
```
# Specification
## Module Name

DCCreditSender

## Overview

The `DCCreditSender` module is a Chisel implementation of a credit-based flow control sender. This module is intended to manage the flow control in digital communication systems, environment-insensitive to variable latency delays. It accepts input data through an enqueue interface and sends output data through a dequeue interface with the use of credit-based flow control. The credit mechanism helps ensure that the data exchange between different modules remains synchronized and prevents data overflow or underflow conditions.

## Parameters

- `[D <: Data]data: D`: Represents the type of data that will be enqueued and dequeued from the module. It must be a chisel data type or extend from it.
- `maxCredit: Int`: An integer parameter that defines the maximum number of credits the sender can hold. It must be greater than or equal to 1.

## Input/Output Interface

### Inputs

- `enq` (Flipped Decoupled[Data]): This interface accepts data to be sent through the `DCCreditSender`.
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

- **Credit Counter (curCredit):** A register initialized to the `maxCredit` value that keeps track of the currently available credits. Its value is incremented when a credit is received (icredit high, enq.fire is low), and decremented when the enqueued data is sent (icredit low, enq.fire is high).

- **Ready Signal (`io.enq.ready`):** A readiness indication flag for the enqueue interface, toggling high when `curCredit` is greater than zero, signifying it's ready to accept new data.

- **Data Register (dataOut) & Valid Register (validOut):** Temporary registers for holding data payloads meant for dequeue and maintaining a valid status flag respectively utilizing RegEnable and RegNext primitives.

```


Slice the `Internal logic` into several coding tasks.
### Task n: 
**Objective:**
**Step:**


## NOT Method s2-Modern HDL Gen

Please act as a professional Chisel designer. Give me the complete Chisel code.


```

```

Give me the complete Chisel code.


## NOT Method s2-Modern HDL Gen

Please act as a professional Chisel designer. Give me the complete Chisel code.
Notice the relation of tasks.

``` 
# Specification
## Module Name

DCCreditSender

## Overview

The `DCCreditSender` module is a Chisel implementation of a credit-based flow control sender. This module is intended to manage the flow control in digital communication systems, environment-insensitive to variable latency delays. It accepts input data through an enqueue interface and sends output data through a dequeue interface with the use of credit-based flow control. The credit mechanism helps ensure that the data exchange between different modules remains synchronized and prevents data overflow or underflow conditions.

## Parameters

- `[D <: Data]data: D`: Represents the type of data that will be enqueued and dequeued from the module. It must be a chisel data type or extend from it.
- `maxCredit: Int`: An integer parameter that defines the maximum number of credits the sender can hold. It must be greater than or equal to 1.

## Input/Output Interface

### Inputs

- `enq` (Flipped Decoupled[Data]): This interface accepts data to be sent through the `DCCreditSender`.
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
## Design Task
### Task 1: Implement Credit Register (`icredit`)
**Objective:** Create a register to maintain the latched status of the dequeue credit signal.
**Step:**
- Declare a register `icredit` that captures the credit input signal from the `deq` interface.
- Update `icredit` based on the input credit signal each cycle.

### Task 2: Implement Credit Counter (`curCredit`)
**Objective:** Develop a register to track the number of available credits.
**Step:**
- Initialize `curCredit` with the value of `maxCredit`.
- Increment `curCredit` when credit is available (`icredit` is high) and no new data is enqueued (`enq.fire` is low).
- Decrement `curCredit` when data is enqueued (`enq.fire` is high) and no credit is available (`icredit` is low).
- Ensure `curCredit` cannot exceed `maxCredit` or fall below zero.

### Task 3: Define Ready Signal (`io.enq.ready`)
**Objective:** Create a signal to indicate readiness to accept new data on the enqueue interface.
**Step:**
- Implement the logic for `io.enq.ready` to be true when `curCredit` is greater than zero.
- Connect `io.enq.ready` to the input side ensuring that new data can only be enqueued when ready.

### Task 4: Develop Data Register (`dataOut`) and Valid Register (`validOut`)
**Objective:** Implement temporary registers for handling outgoing data and valid status.
**Step:**
- Use `RegEnable` to latch incoming data (`enq.bits`) into `dataOut` when data is enqueued (`enq.fire`).
- Use `RegNext` to set `validOut` high following a cycle when data has been successfully captured into `dataOut`.
- Connect `dataOut` and `validOut` to the `deq` interface (`bits` and `valid` respectively).

### Task 5: Connect Output Interface (`deq`) to Internal Logic
**Objective:** Connect internal registers and control signals to the `deq` output interface.
**Step:**
- Attach `validOut` to `io.deq.valid` to indicate availability of valid data.
- Attach `dataOut` to `io.deq.bits` to carry the data payload.
- Handle `io.deq.credit` as an input to the `icredit` logic.
```

Give me the complete Chisel code.


