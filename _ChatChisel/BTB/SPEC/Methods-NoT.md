
## Base Method
Please act as a professional Chisel designer. Give me the complete Chisel code.

```

```
Give me the complete Chisel code.


## NoT Method s1-Spec Slicer
Please act as a professional Chisel designer. Slice the `Internal logic` into several coding tasks

```
Module name: BTB
I/O ports:
val io = IO(new Bundle {
    val pc = Input(UInt(32.W))//index to update
    val mem_pc = Input(UInt(32.W))//index to predict
    val pcsrc = Input(UInt(1.W))//whether the privious instruction is taken
    val branch = Input(UInt(1.W))//whether the privious instruction is a branch instruction
    val btb_taken = Output(UInt(1.W))//predict result
})
Internal Logic: 
In a RISC-V processor, the  BTB (Branch Target Buffer) is a table to stores the history of previously executed branches,and use 2 bits saturating counter(reset to 0.U) to predict the target of future branch instructions indexed by the lower 4 bits of the pc(pc(5,2), lowest 2 bits are invalid). When previous pc(mem_pc) point to a branch instructions (branch = 1), update the information in btb according to it's taken(pcsrc=1) or not.


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


```
Module name: BTB
I/O ports:
val io = IO(new Bundle {
    val pc = Input(UInt(32.W))//index to update
    val mem_pc = Input(UInt(32.W))//index to predict
    val pcsrc = Input(UInt(1.W))//whether the privious instruction is taken
    val branch = Input(UInt(1.W))//whether the privious instruction is a branch instruction
    val btb_taken = Output(UInt(1.W))//predict result
})
Internal Logic: 
In a RISC-V processor, the  BTB (Branch Target Buffer) is a table to stores the history of previously executed branches,and use 2 bits saturating counter(reset to 0.U) to predict the target of future branch instructions indexed by the lower 4 bits of the pc(pc(5,2), lowest 2 bits are invalid). When previous pc(mem_pc) point to a branch instructions (branch = 1), update the information in btb according to it's taken(pcsrc=1) or not.

 Task 1: Define BTB Storage Structure  
**Objective:** Implement the BTB storage using a vector of 2-bit saturating counters.  
**Step:**  
- Create a register vector `btb_table` with 16 entries (indexed by 4 bits)  
- Initialize all entries to `0.U(2.W)` (weakly not-taken state)  
- Use `RegInit(VecInit(Seq.fill(16)(0.U(2.W))))`  

 Task 2: Implement Prediction Logic  
**Objective:** Generate branch prediction for current PC.  
**Step:**  
- Extract index from `io.pc` using bits `[5:2]`  
- Access corresponding 2-bit counter in `btb_table`  
- Output `io.btb_taken` as `true.B` when counter value ≥ 2 (strongly/weakly taken)  

 Task 3: Implement Update Logic  
**Objective:** Update BTB entries based on resolved branches.  
**Step:**  
- Extract index from `io.mem_pc` using bits `[5:2]`  
- When `io.branch` is asserted:  
  - Read current counter value from `btb_table`  
  - If `io.pcsrc` is taken (1):  
    - Increment counter (saturate at 3)  
  - Else (not taken):  
    - Decrement counter (saturate at 0)  
  - Write updated counter back to `btb_table`  

 Task 4: Implement Saturating Counter Logic  
**Objective:** Create reusable saturating counter update function.  
**Step:**  
- Define function `updateCounter(old: UInt, inc: Bool): UInt`  
- Returns `Mux(inc, 
  Mux(old === 3.U, 3.U, old + 1.U), 
  Mux(old === 0.U, 0.U, old - 1.U))`  
- Use this in Task 3's update logic  

 Task 5: Connect Clock and Reset  
**Objective:**
Ensure proper synchronous operation.  
**Step:**  
- Wrap storage register with `withClockAndReset(clock, reset)`  
- Verify all state updates occur on rising clock edge  

 Task 6: Index Handling Verification  
**Objective:** Ensure correct bit slicing for indices.  
**Step:**  
- Confirm index calculation uses:  
  - Prediction: `io.pc(5,2)`  
  - Update: `io.mem_pc(5,2)`  
- Add assertions to check index bounds (0-15)  

 Task 7: Pipeline Conflict Handling  
**Objective:**
Resolve read/write hazards.  
**Step:**  
- Implement write-first policy:  
  - Prediction uses pre-update values  
  - Update writes take effect next cycle  
- Add bypass logic if same-cycle update needed  

 Task 8: Reset State Verification  
**Objective:** Validate initial BTB state.  
**Step:**  
- Confirm all counters initialize to 0 (predict not-taken)  



```


Give me the complete Chisel code.


## Think Process
Thinking...
> 
> We are designing a BTB (Branch Target Buffer) module in Chisel.
>  The BTB is indexed by the lower 4 bits of the PC (pc(5,2)), ignoring the lowest 2 bits (which are always 0 for word-aligned instructions).
>  It uses a 2-bit saturating counter for each entry to predict branches.
> 
>  I/O ports:
>    - pc: Input(UInt(32.W)) -> the PC for the current instruction (used for updating the BTB)
>    - mem_pc: Input(UInt(32.W)) -> the PC for the instruction in the memory stage (used for prediction and update)
>    - pcsrc: Input(UInt(1.W)) -> indicates if the branch at mem_pc was taken (1) or not (0)
>    - branch: Input(UInt(1.W)) -> indicates if the instruction at mem_pc is a branch (1) or not (0)
>    - btb_taken: Output(UInt(1.W)) -> the prediction for the current pc (io.pc)
> 
>  Internal Logic:
>  How the BTB works:
>    - The BTB is a table with 16 entries (indexed by 4 bits: pc(5,2)).
>    - Each entry contains a 2-bit saturating counter (which we'll represent as a register of vectors of UInt(2.W)) and also we need to store the target address? 
>      But note: the problem only specifies the prediction (taken/not taken) and the counter. However, the BTB typically also stores the target address so that we can predict the target. 
>      But the output in the I/O is only `btb_taken` (1 bit). So the specification might be simplified.
> 
>  However, looking at the problem statement: 
>    "use 2 bits saturating counter ... to predict the target of future branch instructions"
> 
>  But note: the output is `btb_taken` (1 bit) which is the prediction. So we are only required to predict taken/not taken, not the target.
> 
>  Therefore, our BTB will have:
>    - 16 entries, each containing a 2-bit saturating counter (for prediction state).
> 
>  Operation:
>    - Prediction: For the current instruction (io.pc), we index the BTB with pc(5,2) to get the state of the counter and then predict taken if the counter is 2 or 3 (i.e., high value).
> 
>    - Update: When the instruction at the memory stage is a branch (io.branch === 1.U), we update the BTB entry for the index mem_pc(5,2):
>         - If the branch was taken (io.pcsrc === 1.U), then we increment the counter (saturating at 3).
>         - If the branch was not taken (io.pcsrc === 0.U), then we decrement the counter (saturating at 0).
> 
>  Steps to slice the internal logic:
> 
>  Task 1: Define the BTB storage (register file for the saturating counters)
>    - We need a register of 16 entries, each being a 2-bit unsigned integer (UInt(2.W)), initialized to 0 (which is the reset state).
> 
>  Task 2: Implement the prediction logic for the current PC (io.pc)
>    - We index the BTB using the index from io.pc(5,2) (i.e., bits 5 to 2 of io.pc).
>    - The prediction (btb_taken) is 1 if the counter when indexed is 2 or 3, otherwise 0.
> 
>  Task 3: Implement the update logic for the BTB (on the memory stage PC: mem_pc)
>    - The update happens when the instruction at mem_pc is a branch (io.branch === 1.U).
>    - We index the BTB using mem_pc(5,2).
>    - We update the counter at that index based on pcsrc (whether the branch was taken or not):
>         - If pcsrc is 1 (taken), then we increment the counter (with saturation at 3).
>         - If pcsrc is 0 (not taken), then we decrement the counter (with saturation at 0).
> 
>  Note: The update is synchronous (on the clock edge). We are not told about any clock or reset, but in Chisel we assume a clock and reset are provided.
> 
>  Let's break down into tasks:
> 
> ### Task 1: 
> **Objective:** Define the BTB storage (register for the saturating counters).
> **Step:**
>    - Declare a register `val btb = RegInit(VecInit(Seq.fill(16)(0.U(2.W))))`
> 
> ### Task 2:
> **Objective:** Implement the prediction logic for the current PC (io.pc).
> **Step:**
>    - Compute the index: `val index = io.pc(5,2)`
>    - Read the counter value from `btb(index)`
>    - Set `io.btb_taken := (btb(index) >= 2.U)`  // because 2 and 3 are taken
> 
> ### Task 3:
> **Objective:** Implement the update logic for the BTB (on the memory stage PC: mem_pc).
> **Step:**
>    - Compute the update index: `val update_index = io.mem_pc(5,2)`
>    - When `io.branch === 1.U` (branch instruction at mem_pc), then:
>         - When `io.pcsrc === 1.U` (taken), then:
>              - If the current counter value is less than 3, then set it to current value + 1, else remain 3.
>         - Else (not taken):
>              - If the current counter value is greater than 0, then set it to current value - 1, else remain 0.
>    - We can write:
>         ```
>         when (io.branch === 1.U) {
>             val current_counter = btb(update_index)
>             when (io.pcsrc === 1.U) {
>                 btb(update_index) := Mux(current_counter === 3.U, 3.U, current_counter + 1.U)
>             } .otherwise {
>                 btb(update_index) := Mux(current_counter === 0.U, 0.U, current_counter - 1.U)
>             }
>         }
>         ```
> 
>  However, note that the update is for the memory stage PC, and the prediction is for the fetch stage (current pc). There might be a conflict if the same entry is being updated and predicted in the same cycle? 
>  But the problem does not specify any such hazard. We assume that the update and prediction happen in the same cycle and that the update is for an instruction that is in the memory stage, while the prediction is for an instruction in the fetch stage. 
>  Since the indices (from different PCs) might be the same, we have a read-write hazard. We must decide the behavior.
> 
>  The problem does not specify, but typically in a pipeline, the update happens at the end of the pipeline and the prediction at the beginning. So in the same cycle, the prediction uses the old value and then the update writes the new value? 
>  That would be a write-after-read and is safe. So we can do:
> 
>    - The prediction uses the current state of the BTB (before update).
>    - Then we update the BTB for the memory stage branch.
> 
>  Therefore, the above update logic is correct: the prediction uses the value before the update.
> 
>  Alternatively, we can write the update in a way that the BTB register is updated at the next clock edge, so the prediction in the same cycle is unaffected.
> 
>  So the above steps are safe.
> 
>  Let's write the tasks accordingly.
> 
>  But note: the problem says "When previous pc(mem_pc) point to a branch instructions (branch = 1), update the information in btb according to it's taken(pcsrc=1) or not."
> 
>  We are updating in the same cycle? Actually, in synchronous design, the update happens at the clock edge. So the value we read for prediction in the current cycle is the value from the previous cycle, and the update we are writing will be the value for the next cycle.
> 
>  However, in our code above, the prediction (using `btb(index)`) is happening in the same cycle as we are updating `btb`? How?
> 
>  Actually, in Chisel, when we write:
> 
>    `btb(update_index) := ...`
> 
>  that update will be visible at the next clock cycle. So the prediction in the current cycle is using the value that was updated in the previous cycle. Therefore, the update we are doing now (for the branch in memory stage) will update the BTB for the next cycle.
> 
>  This is the desired behavior: the update is based on the outcome of the branch that is being resolved in the memory stage, and it will affect future predictions.
> 
>  Therefore, the steps are:
> 
>    - The BTB register holds the state at the beginning of the cycle.
>    - We use that state to predict for the current PC (io.pc) and output `btb_taken`.
>    - Then we update the BTB state (for the next cycle) based on the memory stage information (if there was a branch).
> 
>  So the code for update is conditional on `io.branch` and uses `io.mem_pc` and `io.pcsrc`.
> 
>  Therefore, the three tasks above are correct.
> 
>  But note: what if the same index is being updated and predicted in the same cycle? 
>    - The prediction uses the old value (the value at the beginning of the cycle).
>    - The update writes a new value that will be available next cycle.
> 
>  This is the standard behavior and avoids the hazard.
> 
>  Now, let's write the tasks accordingly.
> 
>  However, note that the BTB is updated only when the instruction is a branch (as per the problem). But what about non-branch instructions? They don't update.
> 
>  Also, we are not initializing the BTB to any particular state? The problem says reset to 0.U.
> 
>  So we are using RegInit to initialize to 0.
> 
>  Summary of tasks:
> 
> ### Task 1: 
> **Objective:** Define the BTB storage (16 entries of 2-bit counters, initialized to 0).
> **Step:** 
>    - Create a register of vector type: `val btb = RegInit(VecInit(Seq.fill(16)(0.U(2.W))))`
> 
> ### Task 2: 
> **Objective:** Implement the prediction for the current PC (io.pc).
> **Step:**
>    - Extract index: `val idx = io.pc(5,2)`
>    - Set output: `io.btb_taken := btb(idx) >= 2.U`
> 
> ### Task 3: 
> **Objective:** Implement the update logic for the memory stage branch (if any).
> **Step:**
>    - Extract update index: `val update_idx = io.mem_pc(5,2)`
>    - When `io.branch` is asserted:
>         - Read the current counter value: `val current_val = btb(update_idx)`
>         - When `io.pcsrc` is 1 (taken), update the counter to `Mux(current_val === 3.U, 3.U, current_val + 1.U)`
>         - Otherwise (not taken), update the counter to `Mux(current_val === 0.U, 0.U, current_val - 1.U)`
> 
>  We write the update in a `when` block that is conditioned on `io.branch`.
> 
>  Now, note: what if the update index is the same as the prediction index? 
>    - As discussed, the update is for the next cycle, so the prediction in the current cycle uses the old value. That's correct.
> 
>  Therefore, we have three tasks.
> 
>  Let's write the code accordingly.
> 
>  However, note: the problem does not mention any enable for the update? It says when the previous instruction is a branch, update. So we are using `io.branch` to condition the update.
> 
>  But note: the problem says "When previous pc(mem_pc) point to a branch instructions (branch = 1), update the information in btb". So we are doing exactly that.
> 
>  Final note: the BTB is only updated for branches. Non-branches do not update the BTB.
> 
>  Code structure:
> 
>    module BTB:
>       I/O as given
>       Task 1: define btb register
>       Task 2: prediction logic (combinational from btb and io.pc)
>       Task 3: update logic (synchronous, in a when block)
> 
>  We assume that the update happens on the rising edge of the clock (implicit in Chisel).
> 
>  Let's code accordingly.
> 

> **Implementation Note:** Update logic (Task 3) must be conditional on `io.branch` to prevent non-branch instructions from affecting BTB state. Prediction (Task 2) occurs unconditionally for every PC.