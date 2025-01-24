
## Base Method
Please act as a professional Chisel designer. Give me the complete Chisel code.

```

```
Give me the complete Chisel code.


## NoT Method s1-Spec Slicer
Please act as a professional Chisel designer. Slice the `Internal logic` into several coding tasks

```
# Specification Document

## Module Name
DCDemux

## Overview
The `DCDemux` module is a Chisel-based hardware design unit that demultiplexes a stream of tokens identified by a selector signal (`sel`). It acts as the inverse of a round-robin arbiter (`RRArbiter`), where a single input channel is distributed across multiple output channels based on the selector's value. The data flow is controlled using a valid-ready handshake mechanism implemented via the `DecoupledIO` interface for both the input and output channels.

## Parameters
- `data`: The data type of incoming and outgoing data.
- `n` (Int): The number of output multiplexed channels.

## Input/Output Interface
### Inputs
- `sel` (UInt): A selection signal of width `log2Ceil(n)` bits that determines which output channel will receive the input data.
- `c` (Flipped DecoupledIO(data)): A `DecoupledIO` input channel that carries the incoming data to be demultiplexed.

### Outputs
- `p` (Vec(n, DecoupledIO(data))): A vector of `DecoupledIO` output channels of size `n` that convey the demultiplexed data based on the selected channel. Each vector element, `p(i)`, corresponds to a potential target channel.

## Internal Logic
The internal logic of the `DCDemux` module revolves around the control of the ready-valid handshake signals to properly route the input data to one of the output channels `p(i)`. The logic proceeds as follows:

1. **Initialize Ready Signal**: Start by setting the `ready` signal of the input channel `c` to `0.U`, indicating that it is not ready by default.
2. **Iterate Over Outputs**: For each output channel `p(i)` (where `i` ranges from `0` to `n-1`), perform the following operations:
   - Assign the data bits from `c` to `p(i)`.
   - Use a conditional statement to check if the current index `i.U` matches the selector `sel` value:
     - If `i.U === sel`: Set the `valid` signal of `p(i)` to the `valid` state of `c`, and update the `ready` signal of `c` to the `ready` state of `p(i)`, indicating that the input can be received.
     - Otherwise, set the `valid` signal of `p(i)` to `0.U`, indicating that this output channel is inactive for the current input data.

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
# Specification Document

## Module Name
DCDemux

## Overview
The `DCDemux` module is a Chisel-based hardware design unit that demultiplexes a stream of tokens identified by a selector signal (`sel`). It acts as the inverse of a round-robin arbiter (`RRArbiter`), where a single input channel is distributed across multiple output channels based on the selector's value. The data flow is controlled using a valid-ready handshake mechanism implemented via the `DecoupledIO` interface for both the input and output channels.

## Parameters
- `data`: The data type of incoming and outgoing data.
- `n` (Int): The number of output multiplexed channels.

## Input/Output Interface
### Inputs
- `sel` (UInt): A selection signal of width `log2Ceil(n)` bits that determines which output channel will receive the input data.
- `c` (Flipped DecoupledIO(data)): A `DecoupledIO` input channel that carries the incoming data to be demultiplexed.

### Outputs
- `p` (Vec(n, DecoupledIO(data))): A vector of `DecoupledIO` output channels of size `n` that convey the demultiplexed data based on the selected channel. Each vector element, `p(i)`, corresponds to a potential target channel.

## Design Task
### Task 1: Define Input and Output Interfaces
**Objective:** Define the input and output interface for the `DCDemux` module.
**Step:**
- Create the `DCDemux` class definition in Chisel.
- Define parameters `data` and `n`.
- Declare `sel` and `c` as input fields using `IO(...)`.
- Declare `p` as an output field, which is a vector of `DecoupledIO(data)` with size `n`.

### Task 2: Initialize Ready Signal
**Objective:** Initialize the ready signal for the input channel `c`.
**Step:**
- Set `c.ready` to `false.B` (or `0.U`) by default to indicate that the input channel is not ready initially.

### Task 3: Iterate Over Output Channels
**Objective:** Loop through each output channel to assign data and control signals.
**Step:**
- Use a `for` loop to iterate over each index `i` from `0` to `n-1`.

### Task 4: Assign Data to Output Channels
**Objective:** Forward data from the input channel to each output channel.
**Step:**
- Assign `p(i).bits` to `c.bits`, thereby ensuring the data from input is forwarded to every potential output channel.

### Task 5: Implement Selection Logic
**Objective:** Implement logic to select the active output channel based on `sel`.
**Step:**
- Inside the loop, utilize a conditional statement using `when` to check if `i.U === sel`.
- If true, assign `p(i).valid` to `c.valid`.
- Assign `c.ready` to `p(i).ready`.

### Task 6: Inactivate Non-Selected Channels
**Objective:** Inactivate the channels that are not selected.
**Step:**
- For channels where `i.U =/= sel`, set `p(i).valid` to `false.B` (or `0.U`), indicating they are not participating in the current transaction.

```


Give me the complete Chisel code.


