
## Base Method
Please act as a professional Chisel designer. Give me the complete Chisel code.
```
# Specification

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

- **Priority Handling**: The arbiter assigns output priority to the producer with the lowest index that has its `valid` signal asserted. It begins by defaulting to the highest index (n-1) of `bits` and `chosen`,Then iteratively(`for()`) generates the checking of each producer starting from `n-2` down to `0`. When a producer's `valid` signal is asserted, its index is assigned to `io.chosen` and its `bits` are routed to `io.out.bits`.

- **Arbiter Control (ArbiterCtrl_my)**: This internal object calculates a sequence of `grant` signals for the 'Output Readiness and Validity'. It constructs the grant sequence such that priority is given to lower-indexed producers. The method `apply` constructs a sequence of Booleans which control the readiness of each input based on the priority rules.
`` scala
private object ArbiterCtrl_my {
  def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
    case 0 => Seq()
    case 1 => Seq(true.B)
    case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_)
  }
}
``
- **Output Readiness and Validity**:
  - Each input's `ready` signal is set high if and only if the corresponding `grant` signal is active and the output is ready to receive data.
  - The output's `valid` signal is derived from the inverted last `grant` signal, or supplemented by the validity of the last input(`valid`). This effectively handles situations where no inputs are valid but ensures that output validity reflects any available valid data.


```

Give me the complete Chisel code.


## NoT Method s1-Spec Slicer
Please act as a professional Chisel designer. Slice the `Internal logic` into several coding tasks

```

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

```


Give me the complete Chisel code.


