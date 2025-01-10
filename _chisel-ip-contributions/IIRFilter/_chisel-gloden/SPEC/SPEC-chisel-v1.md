# Specification 1

---

#### Module Name:
`IIRFilter`

---

#### Overview:
The `IIRFilter` Chisel module implements an Infinite Impulse Response (IIR) filter used to process a stream of input samples and produce filtered output samples. The module accepts coefficients for both numerators (`b`) and denominators (`a`) to compute the filtered output. The coefficients and all computations are performed using fixed-point arithmetic.

The data flow follows a ready/valid handshake protocol for both input and output. The user must provide proper coefficients before supplying input samples. The arithmetic precision requirements, including input width, coefficient width, and output width, need to be carefully chosen to prevent overflow and maintain accuracy. The design ensures compatibility with configurable parameters for flexible usage.

---

#### Parameters:
The module supports the following generic parameters:

| Parameter         | Description                                                                                              |
|-------------------|----------------------------------------------------------------------------------------------------------|
| `inputWidth`      | Bit-width of the input samples.                                                                          |
| `coefWidth`       | Bit-width of the numerator (`b`) and denominator (`a`) coefficients.                                      |
| `coefDecimalWidth`| Number of decimal-point bits in the coefficients.                                                        |
| `outputWidth`     | Bit-width of the output samples.                                                                         |
| `numeratorNum`    | Number of numerator coefficients (`b`).                                                                  |
| `denominatorNum`  | Number of denominator coefficients (`a`). Coefficient `a[0]` is assumed to be 1 and not provided as input.|

Constraints:
- `outputWidth` must be at least `inputWidth + coefWidth + log2Ceil(numeratorNum + denominatorNum) + 1` to prevent overflow.
- `coefWidth` must be greater than or equal to `coefDecimalWidth`.

---

#### Input/Output Interface:
The module exposes the following input/output interface:

##### Inputs:
| Signal Name      | Width                     | Direction | Description                                                                 |
|-------------------|---------------------------|-----------|-----------------------------------------------------------------------------|
| `input`          | Flipped Decoupled SInt(inputWidth.W) | Input     | Fixed-point input samples to be filtered.                                   |
| `num`            | Vec(numeratorNum, SInt(coefWidth.W)) | Input     | Array of numerator coefficients (`b0, b1, ...`).                            |
| `den`            | Vec(denominatorNum, SInt(coefWidth.W)) | Input     | Array of denominator coefficients (`a1, a2, ...`). Coefficient `a[0]=1` is implicit and not provided. |

##### Outputs:
| Signal Name      | Width                     | Direction | Description                                                                 |
|-------------------|---------------------------|-----------|-----------------------------------------------------------------------------|
| `output`         | Decoupled SInt(outputWidth.W) | Output    | Fixed-point filtered output samples.                                        |

Key Notes:
- The output samples are formatted as fixed-point numbers with `(outputWidth-coefDecimalWidth).coefDecimalWidth`.

---
#### **Internal Logic**

The internal logic of the module coordinates the state transitions, fixed-point arithmetic, input and output buffering, and filtering operations.

1. **Finite State Machine (FSM)**:
    - **States**:
        - `Idle`: Wait for a valid input sample.
        - `ComputeNum`: Compute contributions from the numerator coefficients.
        - `ComputeDen`: Compute contributions from the denominator coefficients.
        - `StoreLast`: Store the last input sample for historical records.
        - `Valid`: Output the computed filtered sample when the downstream module is ready.
    - **Transitions**:
        - `Idle → ComputeNum`: When a valid input sample is received.
        - `ComputeNum → ComputeDen`: After all numerator coefficients are processed.
        - `ComputeDen → StoreLast`: After all denominator coefficients are processed.
        - `StoreLast → Valid`: Store the last sample and prepare the output.
        - `Valid → Idle`: After the output is consumed by the downstream module.

2. **Control Logic**:
    - A register named `coefNum` tracks the current coefficient being processed, iterating through numerator and denominator coefficients during their respective states.
    - Input buffering: Historical input samples are stored in a memory (`inputMem`) with an address counter (`inputMemAddr`).
    - Output buffering: Historical output samples are stored in a memory (`outputMem`) with an address counter (`outputMemAddr`).
    - Various registers (e.g., `inputSum` and `outputSum`) accumulate numerator and denominator contributions respectively.
    - Fixed-point multiplications are performed on-the-fly using a shared multiplier (`multOut = multIn * multCoef`).

3. **Arithmetic**:
    - Computing Numerator Contributions: In `ComputeNum` state, the module iteratively multiplies the current input sample (or past input samples from the memory) with the numerator's coefficients and accumulates the result in `inputSum`.
    - Computing Denominator Contributions: In `ComputeDen` state, the module iteratively multiplies previous outputs (retrieved from memory) with the denominator coefficients and accumulates the result in `outputSum`.
    - Final Output Computation: Subtract the accumulated denominator contributions from the numerator contributions and adjust the output by right-shifting it by `coefDecimalWidth`.

4. **Ready/Valid Protocol for Input/Output**:
    - The input (`io.input.ready`) is asserted in the `Idle` state to accept a new sample.
    - The output (`io.output.valid`) is asserted in the `Valid` state, signaling that the filtered sample is ready to be consumed by downstream logic.

5. **Memory Access**:
    - `inputMem`: A memory buffer to store previous input samples (used for numerator contributions).
    - `outputMem`: A memory buffer to store previous output samples (used for denominator contributions).
    - Both memories use read-write logic based on the current state and coefficient being processed.

6. **Assertions**:
    - Ensure that the `coefWidth` is adequate to handle the fractional precision (`coefWidth >= coefDecimalWidth`).
    - Ensure that the `outputWidth` meets the minimum width requirement to prevent overflow:
      ```
      outputWidth >= inputWidth + coefWidth + log2Ceil(numeratorNum + denominatorNum) + 1
      ```

7. **Registers/Wires**:
    - Registers like `inputReg`, `outputSum`, and `inputSum` store intermediate values for computation.
    - Wires like `multIn`, `multCoef`, and `multOut` implement the multiplier datapath.
