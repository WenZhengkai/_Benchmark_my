# Specification Document

## Module Name
**DCFull**

## Overview
The DCFull module provides timing closure on valid, ready, and bits interfaces with registered inputs and outputs. It effectively functions as a 2-entry FIFO queue to manage data flow control in hardware designs. The module guarantees that data transfers happen when both the sender and receiver are ready by implementing a state machine to manage the data buffering and forwarding process.

## Parameters
- **[D <: Data](data: D)**: Represents the type of data being handled by the FIFO. The module is generic and can handle any data type that extends the Chisel `Data` type.

## Input/Output Interface
### Inputs
- **enq (DecoupledIO[D])**: The enqueue interface allows data to be input into the FIFO.


### Outputs
- **deq (DecoupledIO[D])**: The dequeue interface allows data to be output from the FIFO.


## Internal Logic
The DCFull module utilizes a finite state machine (FSM) to manage the storage and transition of data through two registered slots. The states are defined as follows:

- **s_0_0**: Both register slots are empty.
- **s_1_0**: The first register slot is filled with data ready to be sent.
- **s_0_1**: The second register slot holds data for output.
- **s_2_1**: Both slots are occupied, with the first slot being the tail and the second slot holding the head data ready to be sent.

### Control Signals
- **shift (Bool)**: Controls whether data should be shifted from the second register to the first.
- **load (Bool)**: Controls whether new data should be loaded into the second register slot.
- **sendSel (Bool)**: Determines which slot's data should be sent out. It chooses between `hold_0` (first slot) and `hold_1` (second slot).
- **push_vld**: (both enq `valid` and `ready`)
- **pop_vld**: (both deq `valid` and `ready`).

### State Transitions
- States transition based on the conditions of `push_vld` and `pop_vld`.

### Data Holding
- **hold_0 (Reg[D])**: A register to hold data temporarily when transitioning through states.
- **hold_1 (Reg[D])**: The primary register to hold the next data item ready for output.
- Data is shifted between these registers and to the output depending on the state and control signals like `shift` and `load`.
- **Output Data Muxing**: Data output selection is managed through a multiplexer controlled by `sendSel`, which chooses between `hold_0` and `hold_1` as the output for `deq.bits`.

