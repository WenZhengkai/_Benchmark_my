
## Base Method
Please act as a professional Chisel designer. Give me the complete Chisel code.

```

```
Give me the complete Chisel code.


## NoT Method s1-Spec Slicer
Please act as a professional Chisel designer. Slice the `Internal logic` into several coding tasks for Chisel.

```
# Specification

## Module Name
GshareBPU

## Overview
The module should implement a gshare branch predictor with 7-bit pc and 7-bit global history, hashed (using xor) into a 7-bit index. This index accesses a 128-entry table of two-bit saturating counters. The branch predictor should contain a 7-bit global branch history register. The branch predictor has two sets of interfaces: One for doing predictions and one for doing training. The prediction interface is used in the processor's Fetch stage to ask the branch predictor for branch direction predictions for the instructions being fetched. Once these branches proceed down the pipeline and are executed, the true outcomes of the branches become known. The branch predictor is then trained using the actual branch direction outcomes.

## I/O Ports

 - input  predict_valid,
 - input  predict_pc (7 bits)
 - output predict_taken
 - output predict_history (7 bits)

 - input  train_valid
 - input  train_taken
 - input  train_mispredicted
 - input  train_history (7 bits)
 - input  train_pc (7 bits)

## Internal Logic
- The module should implement a gshare branch predictor with 7-bit pc and 7-bit global history, hashed (using xor) into a 7-bit index. This index accesses a 128-entry table of two-bit saturating counters.
- The branch predictor should contain a 7-bit global branch history register.
- The branch predictor has two sets of interfaces: One for doing predictions and one for doing training. The prediction interface is used in the processor's Fetch stage to ask the branch predictor for branch direction predictions for the instructions being fetched.
- Once these branches proceed down the pipeline and are executed, the true outcomes of the branches become known. The branch predictor is then trained using the actual branch direction outcomes.

- When a branch prediction is requested (predict_valid = 1) for a given pc, the branch predictor produces the predicted branch direction and state of the branch history register used to make the prediction. The branch history register is then updated (at the next positive clock edge) for the predicted branch.

- When training for a branch is requested (train_valid = 1), the branch predictor is told the pc and branch history register value for the branch that is being trained, as well as the actual branch outcome and whether the branch was a misprediction (needing a pipeline flush). Update the pattern history table (PHT) to train the branch predictor to predict this branch more accurately next time. In addition, if the branch being trained is mispredicted, also recover the branch history register to the state immediately after the mispredicting branch completes execution.

- If training for a misprediction and a prediction (for a different, younger instruction) occurs in the same cycle, both operations will want to modify the branch history register. When this happens, training takes precedence, because the branch being predicted will be discarded anyway.
- If training and prediction of the same PHT entry happen at the same time, the prediction sees the PHT state before training because training only modifies the PHT at the next positive clock edge. The following timing diagram shows the timing when training and predicting PHT entry 0 at the same time. The training request at cycle 4 changes the PHT entry state in cycle 5, but the prediction request in cycle 4 outputs the PHT state at cycle 4, without considering the effect of the training request in cycle 4. 
- reset is asynchronous active-high.

```
Slice the `Internal logic` into several coding tasks for Chisel.
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
# Specification

## Module Name
GshareBPU

## Overview
The module should implement a gshare branch predictor with 7-bit pc and 7-bit global history, hashed (using xor) into a 7-bit index. This index accesses a 128-entry table of two-bit saturating counters. The branch predictor should contain a 7-bit global branch history register. The branch predictor has two sets of interfaces: One for doing predictions and one for doing training. The prediction interface is used in the processor's Fetch stage to ask the branch predictor for branch direction predictions for the instructions being fetched. Once these branches proceed down the pipeline and are executed, the true outcomes of the branches become known. The branch predictor is then trained using the actual branch direction outcomes.

## I/O Ports

 - input  predict_valid,
 - input  predict_pc (7 bits)
 - output predict_taken
 - output predict_history (7 bits)

 - input  train_valid
 - input  train_taken
 - input  train_mispredicted
 - input  train_history (7 bits)
 - input  train_pc (7 bits)

## Design Task
### Task 1: Define I/O Ports and Core Registers  
**Objective:** Implement module declaration, I/O ports, PHT (128-entry 2-bit counter array), and GHR (7-bit register).  
**Steps:**  
1. Create Chisel `Bundle` for I/O ports as per spec.  
2. Define `pht_table` as `RegInit` of 128 entries initialized to 2-bit "weak not taken" (e.g., 2’b01).  
3. Define `ghr` as 7-bit `RegInit` initialized to 0.  

---  

### Task 2: Prediction Interface Logic  
**Objective:** Compute prediction index, generate `predict_taken`, and schedule GHR update.  
**Steps:**  
1. XOR `predict_pc` with `ghr` to compute the 7-bit index.  
2. Use the index to read the PHT counter.  
3. Set `predict_taken` to MSB of the counter and `predict_history` to current `ghr`.  
4. Generate `next_ghr_prediction` as `(ghr << 1) | predict_taken` (stored in a wire).  

---  

### Task 3: Training Interface Logic  
**Objective:** Update PHT on training and handle misprediction recovery.  
**Steps:**  
1. XOR `train_pc` with `train_history` to compute the training index.  
2. Update the PHT counter:  
   - If `train_taken`, increment counter (saturate at 3).  
   - Else, decrement counter (saturate at 0).  
3. Compute `corrected_ghr` as `(train_history << 1) | train_taken` if `train_mispredicted`.  
4. Generate `next_ghr_training` (use `corrected_ghr` when mispredicted).  

---  

### Task 4: GHR Update Conflict Resolution  
**Objective:** Resolve conflicts when training and prediction update GHR in the same cycle.  
**Steps:**  
1. Use a priority Mux:  
   - If `train_valid && train_mispredicted`, set `ghr` to `corrected_ghr`.  
   - Else if `train_valid`, defer to training (optional, depends on spec).  
   - Else if `predict_valid`, set `ghr` to `next_ghr_prediction`.  
2. Ensure training takes precedence over prediction updates.  

---  

### Task 5: Synchronous PHT and GHR Updates  
**Objective:** Ensure PHT and GHR updates occur at the next clock edge.  
**Steps:**  
1. Use `RegNext` for PHT updates to reflect changes in the next cycle.  
2. Connect `ghr` to the resolved `next_ghr` value (from Task 4) using `RegNext`.  

---  

### Task 6: Asynchronous Reset Handling  
**Objective:** Reset PHT and GHR to initial states.  
**Steps:**  
1. Attach `reset` to `RegInit` for `ghr` and `pht_table`.  
2. Initialize `ghr` to 0 and PHT entries to 2’b01 on reset.  

---  

### Task 7: Concurrent Training/Prediction Edge Cases  
**Objective:** Validate PHT timing (prediction uses old state even if trained in the same cycle).  
**Steps:**  
1. Ensure PHT reads in prediction logic directly use `pht_table` (not `RegNext`).  
2. Write PHT updates via `pht_table := updated_pht` (visible in the next cycle).  

---  

```


Give me the complete Chisel code.


## Think Process
Thinking...
> 
> Okay, I need to break down the internal logic of the GshareBPU module into different coding tasks for Chisel. Let me start by understanding the requirements thoroughly.
> 
> First, the module uses a gshare predictor with a 7-bit PC and 7-bit global history, XORed to create a 7-bit index into a 128-entry PHT. Each entry is a 2-bit saturating counter. There's a global history register (GHR) that's updated when predictions are made, and during training, especially if there's a misprediction.
> 
> The interfaces are prediction and training. Prediction happens in the Fetch stage, and training occurs when the branch outcome is known. The key points are handling the prediction and training updates correctly, especially when they happen in the same cycle.
> 
> Let me list the components needed:
> 
> 1. **PHT (Pattern History Table)**: A 128-entry table of 2-bit counters. This requires a register or memory to hold these counters.
> 
> 2. **Global History Register (GHR)**: A 7-bit register that's updated after a prediction. Also, during training, if there's a misprediction, the GHR needs to be restored to the state after the mispredicted branch.
> 
> 3. **Index Calculation (XOR of PC and GHR)**: For both prediction and training, the index is (PC xor GHR) for prediction, but during training, the index is (train_pc xor train_history) since the training uses the historical GHR at the time of prediction.
> 
> 4. **Prediction Logic**: When predict_valid is high, compute the index, check the PHT entry, output predict_taken based on the counter's MSB, and output the current GHR. Then update the GHR with the predicted outcome (shift left, add the predicted taken bit).
> 
> 5. **Training Logic**: When train_valid is high, compute the training index (train_pc xor train_history), update the corresponding PHT entry based on the actual outcome (train_taken). Also, if train_mispredicted is true, recover the GHR to train_history shifted left by 1 and OR'd with train_taken. Additionally, handle cases where training and prediction happen in the same cycle, giving priority to training updates for the GHR.
> 
> 6. **Conflict Handling**: When both training and prediction occur in the same cycle, the training (especially misprediction recovery) takes precedence over the prediction's GHR update. Also, the PHT updates from training are applied on the next clock cycle, so predictions in the same cycle see the old PHT state.
> 
> 7. **Reset Handling**: Asynchronous reset for initializing the GHR and PHT.
> 
> Now, breaking these into tasks:
> 
> **Task 1: Define the PHT and GHR registers.**
> - Create a 128-entry vector of 2-bit saturating counters initialized to a default state (maybe weakly taken). The GHR is a 7-bit register initialized to 0.
> 
> **Task 2: Implement prediction interface logic.**
> - Compute the index by XORing predict_pc and current GHR.
> - Look up the PHT to get the counter value.
> - Determine predict_taken as the MSB of the counter.
> - Output predict_history (current GHR).
> - Schedule the GHR update: (current GHR << 1) | predict_taken. But this update might be overridden by a training in the same cycle.
> 
> **Task 3: Implement training interface logic.**
> - Compute the training index using train_pc and train_history.
> - Update the corresponding PHT entry based on train_taken (increment if taken, decrement if not, saturating).
> - If train_mispredicted, compute the corrected GHR (train_history << 1 | train_taken) and update the GHR with this value in the next cycle.
> - Also, handle when training and prediction happen in the same cycle: training's GHR update takes priority.
> 
> **Task 4: Handle concurrent training and prediction updates to GHR.**
> - Use a priority system where training (especially misprediction recovery) takes precedence over the prediction's GHR update. So, if both occur, the training's GHR update is applied.
> 
> **Task 5: Manage PHT update timing.**
> - Ensure that PHT updates from training are written on the next clock edge, so predictions in the same cycle see the old value. This is inherent to register-based updates in Chisel, as the write happens at the next cycle.
> 
> **Task 6: Implement asynchronous reset.**
> - On reset, set GHR to 0 and PHT entries to their initial state (maybe 2'b10, weakly taken).
> 
> **Task 7: Test and verify corner cases.**
> - For example, when both train and predict happen in the same cycle, check that training updates take precedence, and PHT updates don't affect the current prediction.
> 
> Wait, but the user wants the internal logic sliced into coding tasks. So each task should be a specific part of the code.
> 
> Reorganizing into coding steps:
> 
> 1. **Define module I/O ports and registers.**
>    - Declare input/output ports as per the spec.
>    - Instantiate the PHT as a Vec of 128 2-bit counters.
>    - Instantiate the GHR as a 7-bit register.
> 
> 2. **Implement index calculation for prediction.**
>    - XOR predict_pc with GHR to get the index.
>    - Access PHT[index] to get the prediction.
> 
> 3. **Generate prediction outputs and schedule GHR update.**
>    - predict_taken is PHT entry's MSB.
>    - predict_history is current GHR.
>    - Calculate next GHR as (GHR << 1) | predict_taken, but hold this in a wire for potential update, unless overridden by training.
> 
> 4. **Handle training logic.**
>    - Calculate training index as train_pc XOR train_history.
>    - Update the PHT entry using the saturating counter logic based on train_taken.
>    - If train_mispredicted, compute the corrected GHR and prepare to update GHR.
> 
> 5. **Resolve GHR update conflicts between prediction and training.**
>    - If training occurs (especially with misprediction), override the next GHR value from prediction with the training's corrected GHR.
>    - Use a Mux or priority logic to determine which update to apply.
> 
> 6. **Implement synchronous updates for GHR and PHT.**
>    - Use RegNext for PHT updates so they take effect on the next cycle.
>    - Similarly, update GHR based on the resolved next value (from prediction or training).
> 
> 7. **Handle asynchronous reset.**
>    - On reset, initialize GHR to 0 and PHT entries to initial state.
> 
> So the tasks can be structured around these steps. Each task would involve writing specific parts of the Chisel code.
> 
> For example:
> 
> Task 1: Define the module's I/O ports and internal registers (PHT and GHR).
> 
> Task 2: Implement the prediction index calculation and output logic.
> 
> Task 3: Implement the training index calculation, PHT update logic, and misprediction handling.
> 
> Task 4: Handle GHR update conflicts between prediction and training.
> 
> Task 5: Implement reset functionality.
> 
> Hmm, perhaps splitting into these tasks.
> 
> Each task would have an objective and steps. Let me outline them properly.
> 
