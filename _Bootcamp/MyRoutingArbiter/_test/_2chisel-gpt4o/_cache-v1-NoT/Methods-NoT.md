
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
### Task 1:  
**Objective:** Implement the output validity logic for `out.valid`.  
**Step:**  
- Initialize the `out.valid` signal.  
- Use a logical OR reduction operation (`||`) on the `valid` signals of all input channels (`in`) to compute `out.valid`.  
- Ensure that `out.valid` is set to `true` only if at least one input channel's `valid` signal is `true`.

---

### Task 2:  
**Objective:** Implement the priority selection logic using `PriorityMux` to determine the index of the first valid input channel.  
**Step:**  
- Initialize an index signal (e.g., `selectedIndex`) to hold the channel index selected by the priority logic.  
- Create a mapping of the `valid` signals of all input channels (`in`) to their respective indexes.  
- Use the `PriorityMux` to select the index of the first valid input channel based on priority (i.e., the lowest-indexed valid channel).  
- Assign this selected index to the `selectedIndex` signal for use in subsequent logic.

---

### Task 3:  
**Objective:** Route the data (`out.bits`) from the selected input channel to the output channel.  
**Step:**  
- Use the previously computed `selectedIndex` signal from the `PriorityMux` logic.  
- Connect the `out.bits` signal to the `bits` value of the input channel indexed by `selectedIndex`.  
- Ensure that if no channel is valid, `out.bits` is set to a default value or left undefined, as appropriate for your design.

---

### Task 4:  
**Objective:** Implement the input `ready` logic for each input channel.  
**Step:**  
- Iterate over all input channels.  
- For each input channel, set its `ready` signal based on the following conditions:  
  1. The output channel (`out.ready`) is `true`.  
  2. The channel index matches the `selectedIndex` computed earlier (i.e., the channel is selected for output).  
- Ensure that only the selected input channel is marked as `ready` to accept new data when processing its current data.

---

### Task 5:  
**Objective:** Implement connection logic between parameters and the I/O interface.  
**Step:**  
- Declare the `numChannels` parameter for the `MyRoutingArbiter` module.  
- Use the parameter to define the sizes of the `in` vector (`Vec(numChannels, Flipped(Decoupled(UInt(8.W))))`).  
- Verify that the `out` signal conforms to the `Decoupled(UInt(8.W))` interface.  
- Ensure correct connections between the module's inputs (`in`) and outputs (`out`).


```


Give me the complete Chisel code.


