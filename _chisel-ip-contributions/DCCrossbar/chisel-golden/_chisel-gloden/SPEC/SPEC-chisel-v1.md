# Specification 4

## Module Name
DCCrossbar

## Overview
The DCCrossbar is a parameterizable hardware module implemented in Chisel, designed to interconnect M input ports with N output ports. It facilitates concurrent communication between inputs and outputs as long as no two inputs request the same output simultaneously. The module is implemented utilizing the DCDemux and DCArbiter components to manage and route data efficiently, ensuring a non-blocking operation.

## Library
- `chisel.lib.dclib._` `chisel3._` `chisel3.util._`
- `chisel.lib.dclib._`: DCDemux and DCArbiter
``` scala
/**
  * Demultiplex a stream of tokens with an identifier "sel",
  * as inverse of RRArbiter.
  *
  * @param data Data type of incoming/outgoing data
  * @param n    Number of mux outputs
  */
class DCDemux[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val sel = Input(UInt(log2Ceil(n).W))
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


## Parameters
- `[D <: Data] data (D)`: Generic data type for the module's input/output data interfaces.
- `inputs (Int)`: The number of input ports available in the crossbar.
- `outputs (Int)`: The number of output ports available in the crossbar.

## Input/Output Interface
### Inputs
- `sel (Vec(inputs, UInt(log2Ceil(outputs).W)))`: A vector of selection signals, one for each input, guiding which output each input wishes to communicate with. Each selection signal is represented by a `UInt` with a bit width equal to the logarithm (base 2, ceiling) of the number of outputs.
- `c (Vec(inputs, Flipped(DecoupledIO(data.cloneType))))`: A vector of input interfaces, each of type `DecoupledIO` carrying the generic data type `D`. The inputs are in a flipped Decoupled I/O format to receive data transactions.

### Outputs
- `p (Vec(outputs, DecoupledIO(data.cloneType)))`: A vector of output interfaces, each of type `DecoupledIO` carrying the generic data type `D`. The outputs are provided in a Decoupled I/O format to send data transactions.

## Internal Logic
The core functionality of the DCCrossbar module is implemented using instances of DCDemux and DCArbiter components to manage data flow between input and output ports. The internal logic is outlined as follows:

1. **Single Input/Output Optimization**: If both the number of inputs and outputs is one, the input and output ports are directly connected using a bulk connection operation (`<>`), as no routing complexity is needed. Else, implement below hardware.

2. **Demultiplexer (DCDemux) Instances**:
   - A sequence of `DCDemux` instances is created, one for each input. Each demultiplexer routes data from a single input to any of the available outputs based on the corresponding selection signal (`sel`).

3. **Arbiter (DCArbiter) Instances**:
   - A sequence of `DCArbiter` instances is instantiated(`locking` == false), one for each output. Each arbiter collects possible input data from all demultiplexers targeting the output and decides which transaction to proceed with, enabling proper synchronization and avoiding data conflicts.

4. **Interconnection**:
   - Each demultiplexer's output interfaces (`p`) are connected to the corresponding arbiters' input interfaces (`c`).
   - Each arbiter's output interface (`p`) is connected to the respective output port of the crossbar.