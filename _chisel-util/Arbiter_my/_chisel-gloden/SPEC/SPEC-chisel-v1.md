# Specification 5

## Module Name
`Arbiter_my`

## Overview
The `Arbiter_my` module is a hardware construct that sequences multiple producer inputs into a single consumer output. The module assigns priority to producers based on their index, with a lower producer index having higher priority. It is a generic module designed to handle any data type and a configurable number of producers.

## Parameters
- `gen`: The data type parameter for the inputs and output of the module. It is parameterized with a Chisel `Data` type.
- `n`: The number of producer inputs to manage. This is an integer value indicating how many inputs the arbiter will handle.

## Input/Output Interface
- **Inputs**: 
  - `io.in` (Array of Flipped Decoupled): An array of `n` producer inputs for the module, each wrapped in a `DecoupledIO` to indicate valid data and readiness.
- **Outputs**: 
  - `io.out` (DecoupledIO): The consumer output interface wrapped in a `DecoupledIO`. It carries the data from the selected producer to the consumer.
  - `io.chosen` (UInt): A signal indicating which of the producer inputs is currently granted access to the output.

## Internal Logic
The `Arbiter_my` module uses a priority scheme to manage data flow from producers to the consumer. The internal logic is as follows:

1. **Priority Resolution**:
   - The arbiter continuously evaluates the `valid` signals from all producers.
   - The lowest-index producer with a `valid` signal is selected as the current producer (`io.chosen`).

2. **Grant Generation (Arbiter Control)**:
   - The private `ArbiterCtrl_my` object generates the `ready` signals for each producer, indicating whether they are allowed to send data based on priority and consumer readiness.
   - Grants are generated using a combination of boolean logic and priority scanning:
     - If there is only 1 producer, it is always granted.
     - For multiple producers, priority is given starting from the lowest index.
``` scala
private object ArbiterCtrl_my {
  def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
    case 0 => Seq()
    case 1 => Seq(true.B)
    case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_)
  }
}
```

3. **Output Bit Selection (`bits`)**:
   - The `bits` signal of the currently selected producer is connected to the `io.out.bits` output, providing data to the consumer.

4. **Output Readiness and Validity**:
  - Each input's `ready` signal is set high if and only if the corresponding grant signal is active and the output is ready to receive data.
  - The output's `valid` signal is derived from the inverted last grant signal, supplemented by the validity of the last input. This effectively handles situations where no inputs are valid but ensures that output validity reflects any available valid data.
