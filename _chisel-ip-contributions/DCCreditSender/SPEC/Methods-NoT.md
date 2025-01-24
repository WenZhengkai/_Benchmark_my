
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

- **Credit Counter (curCredit):** A register initialized to the `maxCredit` value that keeps track of the currently available credits. Its value is incremented when a credit is received (input credit high, output data not enqueued), and decremented when the enqueued data is sent (output data enqueued, no credit received).

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

- **Credit Counter (curCredit):** A register initialized to the `maxCredit` value that keeps track of the currently available credits. Its value is incremented when a credit is received (input credit high, output data not enqueued), and decremented when the enqueued data is sent (output data enqueued, no credit received).

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
Task 1: Define Internal Registers & Parameters
Objective: Initialize and define the internal registers and parameters needed for the credit and data management.
Step:

Declare the icredit register to latch the status of the dequeue credit signal.
Initialize the curCredit register to handle available credit counts starting from maxCredit.
Define the dataOut and validOut registers to store the data and its valid status for output.
Task 2: Implement Credit Register (icredit)
Objective: Maintain the latched status of the dequeue credit signal to aid decision-making processes.
Step:

Use a register to store the last state of the credit signal (credit) from the dequeue interface.
Update this register value at every clock cycle based on the incoming credit signal.
Task 3: Create Credit Counter Logic
Objective: Manage the credit count through incrementing and decrementing logic.
Step:

Design logic to increment curCredit when a credit is received (credit high) and no data is being enqueued.
Design logic to decrement curCredit when data is being enqueued (enq.ready high) and no credit is received.
Task 4: Implement the Ready Signal
Objective: Determine and output the readiness status of the enqueue interface based on the current credit status.
Step:

Set io.enq.ready to high when curCredit is greater than zero, indicating readiness to accept new data.
Otherwise, set it to low when credits are exhausted.
Task 5: Develop Data & Valid Registers
Objective: Manage the temporary registry and upkeep of data payloads and valid status using Chisel primitives.
Step:

Use RegEnable to conditionally update the dataOut register with the incoming data from the enqueue interface when io.enq.fire().
Use RegNext or suitable logic to update validOut based on data movement conditions to maintain valid status for the output.
Task 6: Connect Outputs
Objective: Configure the output interface signals (deq.valid, deq.bits) for delivering the queued data and status.
Step:

Connect deq.valid to be driven by validOut indicating when data is valid for reading.
Connect deq.bits to output the data stored in dataOut.
Task 7: Set Current Credit Output
Objective: Output the current credit count for monitoring purposes.
```

Give me the complete Chisel code.


