
## Base Method-verilog
Please act as a professional verilog designer. Give me the complete verilog code.

Give me the complete verilog code.

## Base Method
Please act as a professional Chisel designer. Give me the complete Chisel code.

````

# Specification (SPEC) for `frontend` Chisel module

## Overview

The `frontend` module is a component of a CPU pipeline, responsible for handling the initial stages, including instruction fetching (`IFU`), decoding (`IDU`), and issuing decoded instructions(`ISU`). It integrates submodules (`IFU_LLM2`, `IDU_LLM2`, and `ISU_LLM2`) and handles interconnections between these stages. Additionally, it provides logic to process register sources (`rfSrc1`, `rfSrc2`) and interact with external components, such as write-back units and redirect signals.

## IO Port

### Inputs
- **redirect** (`Bool`): Signal indicating whether the pipeline should be redirected (e.g., due to a branch or exception).
- **inst** (`UInt(32.W)`): Input instruction fetched from memory or instruction cache.
- **ifuredirect** (`Input(new Redirect)`): Redirect control for the `IFU` submodule.
- **wb** (`Input(new WbuToRegIO)`): Write-back interface providing data for register updates.
- **rfSrc1** (`UInt(XLen.W)`): First register source value, provided externally.
- **rfSrc2** (`UInt(XLen.W)`): Second register source value, provided externally.

### Outputs
- **pc** (`UInt(XLen.W)`): Current program counter from the `IFU` stage.
- **to_exu** (`Decoupled(new DecodeIO)`): Output decoded instruction packet from `ISU` sent to the execute unit.
- **rs1** (`UInt(5.W)`): Decoded register identifier for the first source operand.
- **rs2** (`UInt(5.W)`): Decoded register identifier for the second source operand.

## Internal Logic

1. **Instantiation of Submodules:**  
   - `ifu`: Instance of the `IFU_LLM2` module, responsible for fetching instructions from memory.
   - `idu`: Instance of the `IDU_LLM2` module, responsible for decoding fetched instructions.
   - `isu`: Instance of the `ISU_LLM2` module, responsible for issuing decoded instructions and handling register files.

2. **Interconnections:**
   - Call the method defined in isu, `isu.rs1_rs2`, using `(io.rfSrc1, io.rfSrc2)` as its arguments, return result to `val (rs1, rs2)`, `rs1` and `rs2` will be used next.
   - The `ifu` receives the fetched `inst` and outputs the `pc` value. It also processes redirect signals received via the `ifuredirect` input. And `isu` connect its signals to io port. Here is the signal table.

| Left Signals       | Right Signals       | Operator |
|--------------------|---------------------|----------|
| ifu.io.inst        | io.inst             | :=       |
| io.pc              | ifu.io.pc           | :=       |
| ifu.io.redirect    | io.ifuredirect      | :=       |
| io.to_exu          | isu.io.to_exu       | <>       |
| isu.io.wb          | io.wb               | :=       |
| io.rs1             | rs1                 | :=       |
| io.rs2             | rs2                 | :=       |

   - Method `StageConnect` establishes connections between pipeline stages (`ifu` → `idu`, `idu` → `isu`). It manages handshakes and flush mechanics. The method is call here:
    StageConnect(ifu.io.to_idu, idu.io.from_ifu, idu.io.to_isu.fire, io.redirect)
    StageConnect(idu.io.to_isu, isu.io.from_idu, isu.io.to_exu.fire, io.redirect)


````

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



Give me the complete Chisel code.


## NOT-TAG Method s2-Modern HDL Gen

Please act as a professional Chisel designer. Give me the complete Chisel code.
Notice the relation of tasks.



Give me the complete Chisel code.



## Think Process

