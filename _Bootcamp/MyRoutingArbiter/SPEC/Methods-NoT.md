
## Base Method
Please act as a professional Chisel designer. Give me the complete Chisel code.

```

```
Give me the complete Chisel code.


## NoT Method s1-Spec Slicer
Please act as a professional Chisel designer. Slice the `Internal logic` into several coding tasks

```
# Specification 2

## Module Name
MyRoutingArbiter
## Overview
The `MyRoutingArbiter` is a hardware design module implemented using Chisel, which performs arbitration amongst multiple input channels to control access to a single output channel. When multiple input channels request access simultaneously, the arbiter selects the one with the highest priority (i.e., the lowest-indexed valid channel) and directs its data to the output.

## Parameters
- `numChannels`: Integer parameter that specifies the number of input channels the arbiter can handle. This parameter is set when instantiating the module.

## Input/Output Interface

### Inputs
- `in`: A `Vec` of `numChannels` elements, where each element is a `Flipped(Decoupled(UInt(8.W)))`. This represents multiple input channels that may send 8-bit wide data into the arbiter. 
  
### Outputs
- `out`: A `Decoupled(UInt(8.W))` representing the output channel that will receive data from one of the input channels.
## Internal Logic
The internal logic of the `MyRoutingArbiter` module involves the following components:

- **Output Validity:**  
  The `out.valid` signal is set to true if at least one of the input channels is valid. This is accomplished using a reduce operation with a logical OR (`||`) on the `valid` signals of all input channels.

- **Priority Selection (PriorityMux):**  
  A `PriorityMux` is used to select the channel number of the first valid input channel based on a priority order. It creates a mapping of valid signals to their respective indexes and selects the index of the first channel that is valid.

- **Data Routing:**  
  The `out.bits` signal is set to the `bits` of the input channel denoted by the selected channel index, effectively routing the data from the chosen input channel to the output.

- **Input Readiness:**  
  Each input channel's `ready` signal is determined by checking if the output is ready (`io.out.ready`) and whether the current channel is the one selected by the `PriorityMux`. This ensures that only the selected input channel, if its data is being forwarded, is marked as ready to accept new data.
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
# Specification 2

## Module Name
MyRoutingArbiter
## Overview
The `MyRoutingArbiter` is a hardware design module implemented using Chisel, which performs arbitration amongst multiple input channels to control access to a single output channel. When multiple input channels request access simultaneously, the arbiter selects the one with the highest priority (i.e., the lowest-indexed valid channel) and directs its data to the output.

## Parameters
- `numChannels`: Integer parameter that specifies the number of input channels the arbiter can handle. This parameter is set when instantiating the module.

## Input/Output Interface

### Inputs
- `in`: A `Vec` of `numChannels` elements, where each element is a `Flipped(Decoupled(UInt(8.W)))`. This represents multiple input channels that may send 8-bit wide data into the arbiter. 
  
### Outputs
- `out`: A `Decoupled(UInt(8.W))` representing the output channel that will receive data from one of the input channels.
## Design Task
### Task 1: Implement Output Validity Logic
**Objective:** Set the `out.valid` signal to true if at least one of the input channels is valid.
**Step:**
- Use a reduce operation with a logical OR (`||`) on the `valid` signals of all input channels to determine if any channel is valid.
  
### Task 2: Implement Priority Selection using PriorityMux
**Objective:** Select the channel index of the first valid input channel using a PriorityMux.
**Step:**
- Create a list of channel indices paired with their corresponding `valid` signals.
- Implement a `PriorityMux` that selects the index of the first valid channel according to the priority (lowest index first).

### Task 3: Implement Data Routing
**Objective:** Route the data from the selected input channel to the output.
**Step:**
- Use the channel index from the `PriorityMux` to select the appropriate `bits` signal from the input channels.
- Assign this selected `bits` signal to `out.bits`.

### Task 4: Implement Input Readiness Logic
**Objective:** Set each input channel's `ready` signal based on the selected channel index and output readiness.
**Step:**
- For each input channel, set its `ready` signal to true if `io.out.ready` is true and the channel’s index matches the index selected by the `PriorityMux`.

```


Give me the complete Chisel code.


