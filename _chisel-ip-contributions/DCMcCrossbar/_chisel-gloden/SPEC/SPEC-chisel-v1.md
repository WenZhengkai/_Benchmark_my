# Specification 4

---

## Module Name:
**DcMcCrossbar**

---

## Overview:
The `DcMcCrossbar` is a Chisel module that implements a multi-destination crossbar for communication between multiple data sources (inputs) and multiple data destinations (outputs). It allows any source to send data to one or more destinations by selecting them through a routing `sel` signal. The crossbar supports partial completions, which means different sources can send data to overlapping destination groups without causing deadlock. However, it does not guarantee in-order completion of data from one source to a destination when other sources are active. Internally, this is implemented using `DCMirror` for demultiplexing input data and `DCArbiter` for arbitrating multiple sources for the same destination.

---
## Library
- `chisel.lib.dclib._` `chisel3._` `chisel3.util._`
- `chisel.lib.dclib._`:`DCMirror` `DCArbiter`
``` scala
/**
  * Sends tokens to multiple output destinations, as selected by bit
  * vector "dst".  dst must have at least one bit set for correct
  * operation.
  *
  * @param data Payload data type
  * @param n    Number of output destinations
  */
class DCMirror[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(new DecoupledIO(data.cloneType))
    val p = Vec(n, new DecoupledIO(data.cloneType))
  })

  /**
  * Round-robin arbiter
  *
  * Accepts number of inputs and arbitrates between them on a per-cycle basis.
  *
  * @param data    Data type of item to be arbitrated
  * @param inputs  Number of inputs to arbiter
  * @param locking Creates a locking arbiter with a rearb input
  */
class DCArbiter[D <: Data](data: D, inputs: Int, locking: Boolean) extends Module {
  val io = IO(new Bundle {
    val c = Vec(inputs, Flipped(Decoupled(data.cloneType)))
    val p = Decoupled(data.cloneType)
    val grant = Output(UInt(inputs.W))
    val rearb = if (locking) Some(Input(UInt(inputs.W))) else None
  })
```

---

## Parameters:
| **Name**  | **Type** | **Description**                                                                                          |
|-----------|----------|----------------------------------------------------------------------------------------------------------|
| `data`    | `[D <: Data]` | The data type of the input/output interface (e.g., UInt, CustomData). All data channels use this type. |
| `inputs`  | `Int`    | The number of input data ports in the crossbar.                                                         |
| `outputs` | `Int`    | The number of output data ports in the crossbar.                                                        |

---

## Input/Output Interface:

1. **Inputs:**
   - `sel`: A `Vec` of size `inputs`, where each entry is a `UInt` of width `outputs`. Each element specifies the destinations (as a bitmask) for the corresponding input.
   - `c`(Vec(inputs, Flipped(new DecoupledIO(data.cloneType)))): A `Vec` of size `inputs`, where each element is a `DecoupledIO` of type `data`. These are the input data interfaces.

2. **Outputs:**
   - `p`(Vec(outputs, new DecoupledIO(data.cloneType))): A `Vec` of size `outputs`, where each element is a `DecoupledIO` of type `data`. These are the output data interfaces.

---

## Internal Logic:

### Single Input and Output Optimization:
If the module is instantiated with only one input and one output (`inputs = 1` and `outputs = 1`), the crossbar simplifies to a direct passthrough. The source data is directly connected to the destination without additional logic.

### General Case:
For configurations with more than one input or output:
1. **Demultiplexing (`DCMirror`):**
   - Each input is connected to a `DCMirror` module that demultiplexes the input data based on the destination bitmask specified by the corresponding `sel` signal.
   - The `DCMirror` module sends the input data to one or more selected output ports.

2. **Arbitration (`DCArbiter`):**
   - Each output port is connected to a `DCArbiter` module(locking=false) that arbitrates between multiple sources trying to write to the same destination. 
   - The arbiter resolves contention fairly and selects one data source at a time while maintaining backpressure.

3. **Connection Logic:**
   - The outputs of the `DCMirror` modules are connected to the inputs of the appropriate `DCArbiter` modules.
   - The outputs of the `DCArbiter` modules are connected to the output `p` ports of the `DcMcCrossbar` module.


---
