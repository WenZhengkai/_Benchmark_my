# Specification
## Overview
Implement a module of a 64-bit ripple carry adder, which includes several registers to enable the pipeline stages. The output result is available on the result port, and the o_en = 1 indicates the availability of the result.

## Module name 
    AdderPipe64bit               
## Input ports
    i_en: Enable signal for addition operation
    adda: 64-bit input operand A
    addb: 64-bit input operand B
   
## Output ports
    result: 65-bit output representing the sum of adda and addb.
    o_en: Output enable signal.   

## Internal logic:
The module includes several registers to enable the pipeline stages and synchronize the input enable signal (i_en). These registers are controlled by the clock and reset signals.
This is a ripple carry adder that divides a 64 bit addition into 4 parts, each with 16 bits. By sequentially performing calculations on four parts through a four stage pipeline, the partial sum and carry signals of each stage are obtained.
The sum values for each pipeline stage are calculated by adding the corresponding input operands and carry signals.
The output enable signal (o_en) is updated based on the pipeline stages and synchronized with the clock and reset signals.




# Specification
## Overview
Implement a module of a 64-bit ripple carry adder, which includes several registers to enable the pipeline stages. The output result is available on the result port, and the o_en = 1 indicates the availability of the result.

## Module name 
    AdderPipe64bit               
## Input ports
    i_en: Enable signal for addition operation
    adda: 64-bit input operand A
    addb: 64-bit input operand B
   
## Output ports
    result: 65-bit output representing the sum of adda and addb.
    o_en: Output enable signal.   

## Design Task


### Task 1: **Input Registering and Enable Pipeline**
**Objective:** Capture input operands and synchronize enable signals with pipeline stages  
**Step:**  
1. Create 64-bit registers for `adda` and `addb` using `RegEnable` triggered by `i_en`  
2. Create a 4-stage enable shift register (`en_pipeline`) to track pipeline validity  
3. Connect `en_pipeline(0)` to `i_en` and shift values every clock cycle  

---

### Task 2: **16-bit Ripple Carry Adder (RCA) Implementation**
**Objective:** Create reusable 16-bit RCA logic for pipeline stages  
**Step:**  
1. Design `RCA16` module with:  
   - Inputs: `a` (16-bit), `b` (16-bit), `cin` (1-bit)  
   - Outputs: `sum` (16-bit), `cout` (1-bit)  
2. Implement ripple carry logic using full-adder chaining  

---

### Task 3: **Pipeline Stage Implementation**
**Objective:** Process 16-bit slices sequentially with registered propagation  
**Step:**  
1. For each pipeline stage (1-4):  
   - Slice inputs: `adda_reg[stage*16-1 : (stage-1)*16]`  
   - Instantiate `RCA16` with previous stage's carry  
   - Add registers for:  
     - Partial sum segment (16-bit)  
     - Propagated carry (1-bit)  
     - Enable signal (from `en_pipeline`)  

---

### Task 4: **Result Aggregation Logic**
**Objective:** Combine partial sums and final carry into 65-bit result  
**Step:**  
1. Create concatenation register for final output:  
   ```scala  
   result_reg := Cat(final_carry, stage4_sum, stage3_sum, stage2_sum, stage1_sum)
   ```  
2. Connect `result_reg` to output port `result`  

---

### Task 5: **Output Enable Generation**
**Objective:** Synchronize output validity signal with pipeline latency  
**Step:**  
1. Connect `o_en` to the last stage of enable pipeline:  
   ```scala  
   o_en := en_pipeline(3)
   ```  
2. Ensure reset synchronization for enable pipeline  

---



