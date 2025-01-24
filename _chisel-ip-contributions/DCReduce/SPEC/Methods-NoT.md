
## Base Method
Please act as a professional Chisel designer. Give me the complete Chisel code.

```

```
Give me the complete Chisel code.


## NoT Method s1-Spec Slicer
Please act as a professional Chisel designer. Slice the `Internal logic` into several coding tasks

``` Markdown
# Specification

## Module Name
DCReduce

## Overview
The `DCReduce` module is a Chisel-based hardware module that implements a multi-input decoupled operator. It makes use of `DCInput` and `DCOutput` to create a module with registered-output timing. The module takes multiple data inputs, performs a reduction operation on the inputs using a specified binary operator, and outputs the result.

## Library
- `chisel3._` `chisel3.util._` `chisel.lib.dclib._`
- `chisel.lib.dclib._`: `DCInput` and `DCOutput`, they both have their Helper function for functional inference:

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


## Parameters
- `[D <: Data]data: D`: The data type of the inputs and outputs, which defines the type of data the operator will work on.
- `n :Int`: The number of inputs for the operator. The module requires at least two inputs (`n >= 2`).
- `op :(D, D) => D`: A binary function representing the operator used to reduce the inputs.

## Input/Output Interface
- **Input:**
  - `a (Vec(n, Flipped(Decoupled(data.cloneType)))`: A vector of decoupled inputs. Each element in the vector is a `Decoupled` type and is expected to carry data of the specified type.

- **Output:**
  - `z (Decoupled(data))`: A decoupled output that carries the result of the reduction operation applied to the inputs.

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
# Specification

## Module Name
DCReduce

## Overview
The `DCReduce` module is a Chisel-based hardware module that implements a multi-input decoupled operator. It makes use of `DCInput` and `DCOutput` to create a module with registered-output timing. The module takes multiple data inputs, performs a reduction operation on the inputs using a specified binary operator, and outputs the result.

## Library
- `chisel3._` `chisel3.util._` `chisel.lib.dclib._`
- `chisel.lib.dclib._`: `DCInput` and `DCOutput`, they both have their Helper function for functional inference:

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


## Parameters
- `[D <: Data]data: D`: The data type of the inputs and outputs, which defines the type of data the operator will work on.
- `n :Int`: The number of inputs for the operator. The module requires at least two inputs (`n >= 2`).
- `op :(D, D) => D`: A binary function representing the operator used to reduce the inputs.

## Input/Output Interface
- **Input:**
  - `a (Vec(n, Flipped(Decoupled(data.cloneType)))`: A vector of decoupled inputs. Each element in the vector is a `Decoupled` type and is expected to carry data of the specified type.

- **Output:**
  - `z (Decoupled(data))`: A decoupled output that carries the result of the reduction operation applied to the inputs.

## Design Task
### Task 1: Implement Initialization of Internal Inputs
**Objective:** Create internal decoupled inputs using `DCInput` for interfacing with external inputs.
**Step:**
- Create a vector `aInt` of decoupled inputs using the `DCInput` helper function for each element in the input vector `io.a`.

### Task 2: Establish Intermediate Output Wire
**Objective:** Set up an internal wire to manage the computation results of the reduction operation.
**Step:**
- Declare an internal wire `zInt` of type `Decoupled(data)` to hold intermediate results before passing to the output.

### Task 3: Compute Validity Signal
**Objective:** Develop the logic to determine when all inputs are valid and ready for computation.
**Step:**
- Implement the computation of `all_valid` signal, which verifies that all elements in `aInt` have their `.valid` signal asserted.

### Task 4: Implement Reduction Operation
**Objective:** Use the specified binary operator to perform a reduction across the valid inputs.
**Step:**
- Iterate over the valid inputs in `aInt` and apply the reduction operation using the `op` function to compute and store the result in `zInt.bits`.

### Task 5: Manage Output Control and Validity
**Objective:** Control when the reduction result is valid and ready for output, and manage input readiness signals.
**Step:**
- Set `zInt.valid` to `true` if all inputs are valid and `zInt` is ready, otherwise set it to `false`.
- Set all elements in `aInt` to `.ready = true` if `zInt.valid` is `true`, else to `false`.

### Task 6: Connect and Interface Output
**Objective:** Connect the intermediate output with the module's defined output interface.
**Step:**
- Use `DCOutput` to link `zInt` to `zDcout`.
- Interface `io.z` with `zDcout` ensuring the final output conforms to the module's output interface expectations.

```


Give me the complete Chisel code.


