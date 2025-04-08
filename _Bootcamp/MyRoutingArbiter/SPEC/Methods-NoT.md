## Base Method-verilog
Please act as a professional verilog designer. Give me the complete verilog code.

```
# Specification 2

## Module Name
MyRoutingArbiter
## Overview
The `MyRoutingArbiter` is a hardware design module which performs arbitration amongst multiple input channels to control access to a single output channel. When multiple input channels request access simultaneously, the arbiter selects the one with the highest priority (i.e., the lowest-indexed valid channel) and directs its data to the output.


## Input/Output Interface
  input        clock,
  input        reset,
  output       io_in_0_ready,
  input        io_in_0_valid,
  input  [7:0] io_in_0_bits,
  output       io_in_1_ready,
  input        io_in_1_valid,
  input  [7:0] io_in_1_bits,
  output       io_in_2_ready,
  input        io_in_2_valid,
  input  [7:0] io_in_2_bits,
  output       io_in_3_ready,
  input        io_in_3_valid,
  input  [7:0] io_in_3_bits,
  input        io_out_ready,
  output       io_out_valid,
  output [7:0] io_out_bits

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
Give me the complete verilog code.



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


## NOT-TAG Method s2-Modern HDL Gen


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


### Task 1: Output Validity Signal Generation  
**Objective:** Implement logic to assert output validity when any input channel is valid  
**Step:**  
- Use `.map(_.valid)` on `io.in` to extract validity signals  
- Combine with `.reduce(_ || _)` to create OR-aggregation  
- Connect result to `io.out.valid`

### Task 2: Priority Channel Selection Logic  
**Objective:** Implement priority-based channel selection using PriorityMux  
**Step:**  
- Create pairs of (valid, index) using `.zipWithIndex` on `io.in`  
- Map pairs to (Bool, UInt) tuples with `valid -> index.U`  
- Feed to `PriorityMux` to get selected channel index  
- Store result in `selectedChannel` register/wire

### Task 3: Output Data Routing Implementation  
**Objective:** Route selected channel's data to output bits  
**Step:**  
- Use `selectedChannel` as index for `io.in` Vec  
- Access `.bits` field of selected channel  
- Connect to `io.out.bits`

### Task 4: Input Ready Signal Generation  
**Objective:** Generate per-channel ready signals based on selection  
**Step:**  
- For each channel index `i`:  
  - Create condition: `(selectedChannel === i.U) && io.out.ready`  
  - Connect to `io.in(i).ready`  
- Use `.zipWithIndex` + `foreach` for iterative connection

### Task 5: Integration & Final Wiring  
**Objective:** Combine all components and verify signal timing  
**Step:**  
- Ensure combinational paths between:  
  - Input valids → PriorityMux → Selected channel  
  - Selected channel → Output bits & Ready signals  
- Verify no unintended latches created  
- Check parameterization works for different `numChannels` values
```


Give me the complete Chisel code.


## Think Process

Thinking...
> 
> Okay, let's tackle this problem. The user wants me to slice the Internal Logic of the MyRoutingArbiter module into several coding tasks. I need to break down each part of the internal logic into individual tasks that a Chisel designer would implement step by step.
> 
> First, I'll look at the Internal Logic description. There are four main components: Output Validity, Priority Selection using PriorityMux, Data Routing, and Input Readiness. Each of these can be a separate task.
> 
> Starting with Output Validity. The out.valid signal is true if any input is valid. So the first task would be to generate the valid signal for the output by OR-ing all the input valid signals. That's straightforward with a reduce on the valid signals.
> 
> Next is the Priority Selection. Using PriorityMux to select the index of the first valid channel. I need to map each input's valid signal to its index and select the highest priority (lowest index) valid one. So the second task is to create the selection logic with PriorityMux, which takes a sequence of conditions and corresponding values.
> 
> Then Data Routing. Once the selected index is determined, the output bits should come from that channel's bits. So connect out.bits to the selected input's bits. The third task is about routing the data based on the selected channel.
> 
> Input Readiness is the fourth part. Each input's ready signal is true only if the output is ready and that particular input is the selected one. So for each channel, the ready signal is (out.ready) && (selected channel is this one). That requires iterating over each channel and setting their ready accordingly. This would be the fourth task.
> 
> I should check if there are any dependencies between these tasks. For example, the selected channel index is needed for both Data Routing and Input Readiness. But each task can be written in order, with the PriorityMux task generating the selected index, then using that in the subsequent tasks.
> 
> Also, I need to make sure that each task is a clear, separate coding step. Let's outline each with an objective and a step, using proper Chisel syntax and constructs. For example, using vec.reduce for the OR operation, creating a Seq of (valid, index) pairs for PriorityMux, etc.
> 
> Wait, in PriorityMux, the conditions are the valid signals of each channel. But the PriorityMux in Chisel takes a list of conditions and values. So for each channel, if its valid is true, then select its index. But since PriorityMux selects the first true condition, that's exactly what's needed here. So the code would be something like PriorityMux(in.map(_.valid).zipWithIndex.map { case (valid, idx) => (valid, idx.U) }).
> 
> But then the selected index is used to select the bits from the corresponding in channel.
> 
> For the Input Readiness, each in(i).ready is set to out.ready and (selected channel === i.U). So that needs to loop through each channel and set the ready signal accordingly.
> 
> I need to structure each task with an objective and steps. Let me write each task one by one, making sure they are clear and actionable.
> 
