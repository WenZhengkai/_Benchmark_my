## Module Name
dut

## Overview
The `dut` module is a Chisel-based reference implementation for handling floating-point exceptions in a Floating-Point Unit (FPU). It processes double-precision floating-point operations (addition, subtraction, multiplication, division) and detects exceptional conditions such as NaN (Not a Number), infinity, underflow, overflow, inexact results, and invalid operations. Based on input operands, operation type, rounding mode, and intermediate results (like exponent and mantissa), it computes the output result and sets exception flags. The module uses synchronous logic with registers to store intermediate states and triggers, ensuring proper handling of IEEE 754 floating-point standards for exceptions. It operates on 64-bit floating-point numbers and supports four rounding modes.

## Parameters
The module does not have configurable parameters passed during instantiation. However, it defines internal constants for floating-point handling:
- `exp_2047`: 11-bit unsigned value representing the maximum exponent (2047 in decimal, or `"b11111111111".U(11.W)`).
- `exp_2046`: 11-bit unsigned value representing exponent 2046 (or `"b11111111110".U(11.W)`).
- `mantissa_max`: 52-bit unsigned value representing the maximum mantissa (or `"hFFFFFFFFFFFFF".U(52.W)`).

These constants are hardcoded and used for detecting infinity, NaN, and overflow conditions in IEEE 754 double-precision format.

## Input/Output Interface
The module uses a bundle `RefFpuExceptionsIO` for its interface. All signals are synchronous and registered where applicable.

### Inputs:
- `enable`: Bool - Enables the module's logic when true.
- `rmode`: UInt(2.W) - Rounding mode (00: nearest, 01: to zero, 10: to positive infinity, 11: to negative infinity).
- `opa`: UInt(64.W) - First operand (64-bit floating-point number).
- `opb`: UInt(64.W) - Second operand (64-bit floating-point number).
- `in_except`: UInt(64.W) - Input value for exception handling (e.g., intermediate result before exceptions).
- `exponent_in`: UInt(12.W) - Input exponent for overflow/underflow checks.
- `mantissa_in`: UInt(2.W) - Input mantissa bits for inexact detection.
- `fpu_op`: UInt(3.W) - FPU operation code (000: add, 001: subtract, 010: multiply, 011: divide).

### Outputs:
- `ref_out`: UInt(64.W) - Computed 64-bit floating-point result after exception handling.
- `ref_ex_enable`: Bool - Indicates if any exception is enabled/triggered.
- `ref_underflow`: Bool - Underflow exception flag.
- `ref_overflow`: Bool - Overflow exception flag.
- `ref_inexact`: Bool - Inexact result flag.
- `ref_exception`: Bool - General exception flag (any of invalid, overflow, underflow, or inexact).
- `ref_invalid`: Bool - Invalid operation flag.

## Internal Logic
The module's logic is divided into synchronous blocks, using registers to store states and intermediate computations. It resets all registers to default values (false for Booleans, 0 for UInts) on reset. When `io.enable` is true, the logic executes in two main phases:

### Detection and Trigger Computation
- **Zero Detection**: Checks if inputs (`in_except`, `opa`, `opb`) are zero by verifying if their lower 63 bits are all zero.
- **Operation Decoding**: Decodes `fpu_op` to set flags for add, subtract, multiply, or divide.
- **NaN Detection**: Identifies Quiet NaN (QNaN) and Signaling NaN (SNaN) in `opa` and `opb` based on exponent (all 1s) and mantissa bits.
- **Infinity Detection**: Detects positive/negative infinity in `opa` and `opb` (exponent all 1s, mantissa all 0s).
- **Special Condition Triggers**:
  - Division by zero, zero-by-zero, inf-by-inf, by-inf.
  - Multiplication of zero-by-inf, inf.
  - Addition/subtraction with inf, including invalid inf cases (e.g., +inf - +inf).
  - Output infinity trigger based on operations or exponent overflow (> 2046).
- **Rounding Mode Decoding**: Sets flags for nearest, to-zero, to-positive-inf, to-negative-inf.
- **Underflow Triggers**: For multiply/divide operations resulting in zero.
- **Exception Triggers**:
  - Invalid: SNaN, invalid inf ops, zero-by-inf mul, zero-by-zero div, inf-by-inf div.
  - Overflow: Output infinity without NaN input.
  - Inexact: Non-zero mantissa bits or underflow/overflow without NaN.
  - General exception and enable triggers.
- **Output Encoding**:
  - Computes NaN output by propagating or modifying input mantissas.
  - Handles infinity rounding down to max finite value for certain modes.
  - Chains output selection: underflow to zero, infinity handling, NaN propagation.

### Output Assignment
- When `io.enable` is true, assigns computed triggers to output exception flags and sets `ref_out` to the final result (`out_2`).

### IO Connections
- Directly wires the registered outputs to the IO ports.

