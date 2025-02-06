# Specification

## Module Name
DCReduce

## Overview
The `DCReduce` module is a Chisel-based hardware module that implements a multi-input decoupled operator. It makes use of `DCInput` and `DCOutput` to create a module with registered-output timing. The module takes multiple data inputs, performs a reduction operation on the inputs using a specified binary operator, and outputs the result.

## Library
- `chisel3._` `chisel3.util._` `chisel.lib.dclib._`
- `chisel.lib.dclib._`: `DCInput` and `DCOutput`, they both have their Helper function for functional inference:
``` scala
object DCInput {
  def apply[D <: Data](x: DecoupledIO[D]): DecoupledIO[D] = {
    val tout = Module(new DCInput(x.bits.cloneType))
    tout.io.enq <> x
    tout.io.deq
  }
}

object DCOutput {
  def apply[D <: Data](x: DecoupledIO[D]): DecoupledIO[D] = {
    val tout = Module(new DCOutput(x.bits.cloneType))
    tout.io.enq <> x
    tout.io.deq
  }
}
// using example
val zDcout = DCOutput(zInt)
```

## Parameters
- `[D <: Data]data: D`: The data type of the inputs and outputs, which defines the type of data the operator will work on.
- `n :Int`: The number of inputs for the operator. The module requires at least two inputs (`n >= 2`).
- `op :(D, D) => D`: A binary function representing the operator used to reduce the inputs.

## Input/Output Interface
  - **`a`**:`Vec(n, Flipped(Decoupled(data.cloneType))`
  A vector of flipped decoupled type. Each element in the vector is a `Decoupled` type and is expected to carry data of the specified type.

  - **`z`**:`Decoupled(data)`
  A decoupled type that carries the result of the reduction operation applied to the inputs.

## Internal Logic
1. **Initialization:** 
   - The module generates a vector of internal decoupled inputs `aInt` using `DCInput` for each input in `io.a`.
   - An internal wire `zInt` of type `Decoupled` acts as an intermediary for the output computation.

2. **Logic Computation:**
   - Compute an `all_valid` signal that checks if all of the inputs in `aInt` are valid.
   - Perform the reduction operation using the provided `op` function on the `bits` of all valid inputs in `aInt` to produce the result stored in `zInt.bits`.

3. **Output Control:**
   - If all the inputs are valid and `zInt` is ready to accept new data, set `zInt.valid` to `true` and set all `aInt(n).ready` signals to `true`.
   - Otherwise, set `zInt.valid` to `false` and all `aInt(n).ready` signals to `false`.
   - Connect `zInt` to `zDcout` using `DCOutput` and interface `io.z` with `zDcout`.
