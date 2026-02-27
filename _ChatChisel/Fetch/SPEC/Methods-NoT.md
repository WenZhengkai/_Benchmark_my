
## Base Method
Please act as a professional Chisel designer. Give me the complete Chisel code.

```

```
Give me the complete Chisel code.


## NoT Method s1-Spec Slicer
Please act as a professional Chisel designer. Slice the `Internal logic` into several coding tasks

````

Module name: DUT
I/O ports:
val io = IO(new Bundle {
	//from csr		
    val trap_vector = Input(UInt(32.W))
    val mert_vector = Input(UInt(32.W))
     //from excute
    val target_pc = Input(UInt(32.W))
    //from memory
    val mem_pc = Input(UInt(32.W))
    val pcsrc = Input(Bool())
    val branch = Input(Bool())
    //from writeback
    val trap = Input(Bool())
    val mert = Input(Bool())
    //from hazard
    val pc_stall = Input(Bool())
    val if_id_stall = Input(Bool())
    val if_id_flush = Input(Bool())
    //to decode
    val id_pc = Output(UInt(32.W))
    val inst = Output(UInt(32.W))
    //from top
    val fetch_data = Input(UInt(32.W))
    //to top
    val fetch_address = Output(UInt(32.W))
})

Internal Logic: 
 In a RISC-V processor, fetch stage use the current PC to fetch instruction from Icache and generate the next PC from multiple sources. The logic of pc update is shown below:
 if (reset):
	pc = RESET_VECTOR
elif(trap):
	pc = trap_vector
elif(mert):
	pc = mret_vector	
elif(pcsrc):
	pc = target_pc
elif(pc_stall):
	pc = pc 
elif(match&valid&btb_taken):
	pc = bht_pred_pc
else:
	pc = pc+4
Fetch module use BHT and BTB to predict  pc.And pc is a resister to store current program counter
Notice that the output interact with decode stage should be regsisters.
Submodules:
  You need to reference some submodule in the fetch module and connect each interface properly.They have been defined elsewhere.The I/O ports of these submodule are shown below:
BHT:
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W))
    val mem_pc = Input(UInt(32.W))
    val pcsrc = Input(UInt(1.W))
    val target_pc = Input(UInt(32.W))
    val matched = Output(UInt(1.W))
    val valid = Output(UInt(1.W))
    val bht_pred_pc = Output(UInt(32.W))
  })
  BTB:
val io = IO(new Bundle {
    val pc = Input(UInt(32.W))      // Index to predict
    val mem_pc = Input(UInt(32.W))  // Index to update
    val pcsrc = Input(UInt(1.W))    // Whether the previous instruction is taken
    val branch = Input(UInt(1.W))   // Whether the previous instruction is a branch instruction
    val btb_taken = Output(UInt(1.W)) // Prediction result
  })



````
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

````
Module name: DUT
I/O ports:
val io = IO(new Bundle {
	//from csr		
    val trap_vector = Input(UInt(32.W))
    val mert_vector = Input(UInt(32.W))
     //from excute
    val target_pc = Input(UInt(32.W))
    //from memory
    val mem_pc = Input(UInt(32.W))
    val pcsrc = Input(Bool())
    val branch = Input(Bool())
    //from writeback
    val trap = Input(Bool())
    val mert = Input(Bool())
    //from hazard
    val pc_stall = Input(Bool())
    val if_id_stall = Input(Bool())
    val if_id_flush = Input(Bool())
    //to decode
    val id_pc = Output(UInt(32.W))
    val inst = Output(UInt(32.W))
    //from top
    val fetch_data = Input(UInt(32.W))
    //to top
    val fetch_address = Output(UInt(32.W))
})

Internal Logic: 
 In a RISC-V processor, fetch stage use the current PC to fetch instruction from Icache and generate the next PC from multiple sources. The logic of pc update is shown below:
 if (reset):
	pc = RESET_VECTOR
elif(trap):
	pc = trap_vector
elif(mert):
	pc = mret_vector	
elif(pcsrc):
	pc = target_pc
elif(pc_stall):
	pc = pc 
elif(match&valid&btb_taken):
	pc = bht_pred_pc
else:
	pc = pc+4
Fetch module use BHT and BTB to predict  pc.And pc is a resister to store current program counter
Notice that the output interact with decode stage should be regsisters.
Submodules:
  You need to reference some submodule in the fetch module and connect each interface properly.They have been defined elsewhere.The I/O ports of these submodule are shown below:
BHT:
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W))
    val mem_pc = Input(UInt(32.W))
    val pcsrc = Input(UInt(1.W))
    val target_pc = Input(UInt(32.W))
    val matched = Output(UInt(1.W))
    val valid = Output(UInt(1.W))
    val bht_pred_pc = Output(UInt(32.W))
  })
  BTB:
val io = IO(new Bundle {
    val pc = Input(UInt(32.W))      // Index to predict
    val mem_pc = Input(UInt(32.W))  // Index to update
    val pcsrc = Input(UInt(1.W))    // Whether the previous instruction is taken
    val branch = Input(UInt(1.W))   // Whether the previous instruction is a branch instruction
    val btb_taken = Output(UInt(1.W)) // Prediction result
  })

 Task 1: Define Core Registers and Constants
**Objective:** Initialize essential registers and constants  
**Steps:**  
1. Declare `RESET_VECTOR` as `0x80000000` (standard RISC-V reset address)  
2. Create PC register `pc_reg` initialized to `RESET_VECTOR`  
3. Create pipeline registers `id_pc_reg` and `inst_reg` for decode stage outputs  

---

 Task 2: Implement PC Update Logic
**Objective:** Compute next PC value based on priority conditions  
**Steps:**  
1. Create wire `next_pc` for combinational next-PC calculation  
2. Implement priority logic:  
   ```scala
   next_pc := MuxCase(pc_reg + 4.U, Seq(
     reset -> RESET_VECTOR.U,
     io.trap -> io.trap_vector,
     io.mert -> io.mert_vector,
     io.pcsrc -> io.target_pc,
     (io_bht.matched && io_bht.valid && io_btb.btb_taken) -> io_bht.bht_pred_pc
   ))
   ```  
3. Update `pc_reg` synchronously:  
   ```scala
   when(reset) { pc_reg := RESET_VECTOR.U }
   .elsewhen(!io.pc_stall) { pc_reg := next_pc }
   ```

---

 Task 3: Instantiate and Connect BHT Submodule
**Objective:** Integrate Branch History Table  
**Steps:**  
1. Instantiate `BHT` module  
2. Connect ports:  
   ```scala
   io_bht.pc := pc_reg
   io_bht.mem_pc := io.mem_pc
   io_bht.pcsrc := io.pcsrc.asUInt
   io_bht.target_pc := io.target_pc
   ```

---

 Task 4: Instantiate and Connect BTB Submodule
**Objective:** Integrate Branch Target Buffer  
**Steps:**  
1. Instantiate `BTB` module  
2. Connect ports:  
   ```scala
   io_btb.pc := pc_reg
   io_btb.mem_pc := io.mem_pc
   io_btb.pcsrc := io.pcsrc.asUInt
   io_btb.branch := io.branch.asUInt
   ```

---

 Task 5: Implement Pipeline Register Logic
**Objective:** Manage IF/ID pipeline registers with stall/flush  
**Steps:**  
1. Implement register update logic:  
   ```scala
   when(reset) {
     id_pc_reg := 0.U
     inst_reg := 0.U
   }.elsewhen(io.if_id_flush) {
     inst_reg := 0.U  // Insert bubble (nop)
     id_pc_reg := pc_reg  // Maintain for debugging
   }.elsewhen(!io.if_id_stall) {
     id_pc_reg := pc_reg
     inst_reg := io.fetch_data
   }
   ```  
2. Connect outputs:  
   ```scala
   io.id_pc := id_pc_reg
   io.inst := inst_reg
   ```

---

 Task 6: Connect I/O Ports
**Objective:** Finalize module interface connections  
**Steps:**  
1. Drive fetch address: `io.fetch_address := pc_reg`  
2. Verify all input ports are connected to internal logic  
3. Verify output ports (id_pc, inst, fetch_address) are properly driven  

---

 Task 7: Reset Synchronization
**Objective:** Ensure clean startup behavior  
**Steps:**  
1. Verify all registers have explicit reset values  
2. Confirm reset overrides all other conditions in PC logic  
3. Ensure pipeline registers clear to valid NOP state (opcode = 0x00000013)  

---


````


Give me the complete Chisel code.


## Think Process
Thinking...
> 
> We are designing the Fetch module (DUT) for a RISC-V processor.
>  The module has several inputs and outputs as described.
>  The internal logic for updating the PC is given, and we have two submodules: BHT and BTB.
> 
>  Steps:
>  1. We need to define the internal registers and wires.
>  2. We need to instantiate the submodules (BHT and BTB) and connect them.
>  3. We need to implement the PC update logic as described.
>  4. We need to handle the output to the decode stage (id_pc and inst) which should be registers and also account for stall and flush signals.
> 
>  Let's break down the tasks:
> 
>  Task 1: Define the internal signals and registers.
>    - We need a register for the PC, which is the program counter.
>    - We also need registers for the outputs to decode: id_pc and inst.
>    - Additionally, we might need wires for the next PC value and for the outputs from the submodules.
> 
>  Task 2: Instantiate and connect the BHT and BTB submodules.
>    - We have the IO ports of these modules, so we can create them and connect the inputs from the DUT's IO and internal signals.
> 
>  Task 3: Implement the PC update logic (next PC computation) and the PC register update.
>    - The next PC is determined by a priority order: reset, trap, mert, pcsrc, pc_stall, then the prediction, and finally the default (PC+4).
>    - We have to account for the BHT and BTB predictions only in the case of no stall and no higher priority condition.
> 
>  Task 4: Implement the output registers for the decode stage (id_pc and inst) with stall and flush handling.
>    - The outputs to decode (id_pc and inst) should be registers that are updated unless stalled. Also, we have a flush signal.
> 
>  Task 5: Connect the fetch_address (output to top) to the current PC.
> 
>  Let's write the tasks accordingly.
> 
>  Note: The BHT and BTB modules are provided. We assume they are named `BHT` and `BTB` and available.
> 
>  Important: The internal logic for PC update:
> 
>    if reset: pc := RESET_VECTOR
>    else if trap: pc := trap_vector
>    else if mert: pc := mret_vector
>    else if pcsrc: pc := target_pc
>    else if pc_stall: pc remains the same
>    else if (BHT's matched and valid and BTB's taken): pc := bht_pred_pc
>    else: pc := pc + 4
> 
>  However, note that the condition for using the prediction is when the BHT and BTB indicate a valid prediction? The condition in the logic is: `match&valid&btb_taken`. We have:
>    - matched (from BHT) -> io_bht.matched
>    - valid (from BHT) -> io_bht.valid
>    - btb_taken (from BTB) -> io_btb.btb_taken
> 
>  Also note: The BHT and BTB modules have inputs that we must connect appropriately.
> 
>  Connections for BHT:
>    - pc: current PC (the value in the PC register)
>    - mem_pc: from DUT's io.mem_pc (which is from memory stage)
>    - pcsrc: DUT's io.pcsrc (but note: in the BHT IO it is UInt(1.W), and DUT's pcsrc is Bool. We can convert with io.pcsrc.asUInt)
>    - target_pc: DUT's io.target_pc
> 
>  Connections for BTB:
>    - pc: current PC
>    - mem_pc: DUT's io.mem_pc
>    - pcsrc: DUT's io.pcsrc (again, convert to UInt)
>    - branch: DUT's io.branch (convert to UInt)
> 
>  We have to note that the DUT's inputs `pcsrc` and `branch` are from memory stage and are Bool. We can convert to UInt by using `.asUInt` or by using `io.pcsrc` and then in the module we do the conversion.
> 
>  Let's break into tasks:
> 
> ### Task 1: Define internal registers and wires
>    - Reg for PC: `val pc_reg = RegInit(RESET_VECTOR.U(32.W))`
>    - Reg for id_pc: `val id_pc_reg = RegInit(0.U(32.W))`
>    - Reg for inst: `val inst_reg = RegInit(0.U(32.W))`
>    - Wire for next PC: `val next_pc = Wire(UInt(32.W))`
>    - We also need to define the RESET_VECTOR. Let's assume it is 0x80000000, but it could be passed as a parameter? The problem doesn't specify, so we can define it as a constant.
> 
>    Note: The problem says "Notice that the output interact with decode stage should be registers", so we will use registers for id_pc and inst.
> 
> ### Task 2: Instantiate BHT and BTB and connect their IOs
>    - We create instances of BHT and BTB, then connect their ports to the appropriate signals.
> 
> ### Task 3: Implement the PC update logic
>    - We compute next_pc based on the priority.
>    - Then update pc_reg on clock edge, unless reset? Actually, reset is already handled by RegInit, but we have a reset condition in the logic? The logic says "if reset", but in Chisel we use synchronous reset by default? We have to check.
> 
>    However, the given logic includes reset as the highest priority. We can do:
> 
>    ```
>    when (reset) {
>         pc_reg := RESET_VECTOR.U
>    }.elsewhen (io.trap) {
>         pc_reg := io.trap_vector
>    }.elsewhen (io.mert) {
>         pc_reg := io.mert_vector
>    }.elsewhen (io.pcsrc) {
>         pc_reg := io.target_pc
>    }.elsewhen (io.pc_stall) {
>         // keep the same: do nothing
>    }.elsewhen (io_bht.matched === 1.U && io_bht.valid === 1.U && io_btb.btb_taken === 1.U) {
>         pc_reg := io_bht.bht_pred_pc
>    }.otherwise {
>         pc_reg := pc_reg + 4.U
>    }
>    ```
> 
>    But note: the condition `io.pc_stall` is handled by not updating the PC? Actually, if `pc_stall` is true, we want to keep the current PC. So we don't update the pc_reg? That is, we don't assign a new value? But in the above, we are using a when condition that covers every clock cycle. We are updating pc_reg in every clock cycle unless we have a stall? Actually, in the elsewhen for stall, we do nothing, meaning the pc_reg remains the same. That is correct.
> 
>    However, note that the condition for prediction (BHT and BTB) is only when none of the higher conditions (trap, mert, pcsrc, stall) are true.
> 
>    Alternatively, we can compute `next_pc` and then update the register only when not stalled? But the problem states that in the case of stall, we keep the current PC. So:
> 
>    We can do:
> 
>    ```
>    next_pc := MuxCase(pc_reg + 4.U, Array(
>         reset -> RESET_VECTOR.U,
>         io.trap -> io.trap_vector,
>         io.mert -> io.mert_vector,
>         io.pcsrc -> io.target_pc,
>         (io_bht.matched === 1.U && io_bht.valid === 1.U && io_btb.btb_taken === 1.U) -> io_bht.bht_pred_pc
>    ))
> 
>    when (!io.pc_stall) {
>         pc_reg := next_pc
>    }
>    ```
> 
>    But note: the reset condition is usually handled by the register's reset. So we might do:
> 
>    Actually, we have to consider that reset is an asynchronous reset? In Chisel, we use RegInit for synchronous reset? But the problem says "if (reset): ...". We should check the reset condition separately.
> 
>    How about:
> 
>    We use a synchronous design and let the reset be handled by the RegInit? Then we don't need to include reset in the when chain? The problem says the reset condition is the highest priority, but in hardware we typically use the reset signal to set the initial value. The reset in the logic might be the same as the global reset? We can do:
> 
>    ```
>    val pc_reg = RegInit(RESET_VECTOR.U(32.W))
>    val next_pc = Wire(UInt(32.W))
> 
>    next_pc := MuxCase(pc_reg + 4.U, Array(
>         io.trap -> io.trap_vector,
>         io.mert -> io.mert_vector,
>         io.pcsrc -> io.target_pc,
>         (io_bht.matched === 1.U && io_bht.valid === 1.U && io_btb.btb_taken === 1.U) -> io_bht.bht_pred_pc
>    ))
> 
>    when (io.pc_stall) {
>         // next_pc is not used, we keep the current pc_reg
>    } otherwise {
>         pc_reg := next_pc
>    }
>    ```
> 
>    But note: the above does not account for the case when we have multiple conditions (like trap and pcsrc both true) because MuxCase uses the first condition that is true. And trap is the highest, so it will be the first in the array? That matches.
> 
>    However, we have to note that the condition for the prediction is only when none of trap, mert, pcsrc are true. So the order is correct.
> 
>    But what about when pc_stall is true? Then we don't update the register. So the above is okay.
> 
>    However, we are missing the reset condition. But we already have the register initialized to RESET_VECTOR. And when reset (the global reset) is asserted, the register will be set to RESET_VECTOR. So we don't need to handle reset in the when block? That is correct.
> 
>    So we can do without including reset in the MuxCase? Because when reset is asserted, the register will be set to RESET_VECTOR regardless of the next_pc.
> 
>    But note: the problem says "if (reset): ...", so we must set the PC to RESET_VECTOR on reset. This is already handled by the RegInit.
> 
>    However, what about the other conditions during reset? We don't want the PC to change during reset. The global reset will override.
> 
>    So we can do:
> 
>    ```
>    when (reset) {
>         pc_reg := RESET_VECTOR.U
>    }.elsewhen (!io.pc_stall) {
>         pc_reg := next_pc
>    }
>    ```
> 
>    But wait, the above will update the PC only when not stalled and not reset. And next_pc is computed without reset. So the MuxCase does not include reset. That is acceptable because during reset (which is synchronous) we are setting the register to RESET_VECTOR. And when reset is deasserted, then we start updating.
> 
>    Alternatively, we can include reset in the MuxCase? Actually, it's cleaner to use the RegInit for reset.
> 
>    So we'll do:
> 
>    ```
>    val pc_reg = RegInit(RESET_VECTOR.U(32.W))
>    val next_pc = Wire(UInt(32.W))
> 
>    next_pc := MuxCase(pc_reg + 4.U, Array(
>         io.trap -> io.trap_vector,
>         io.mert -> io.mert_vector,
>         io.pcsrc -> io.target_pc,
>         (io_bht.matched === 1.U && io_bht.valid === 1.U && io_btb.btb_taken === 1.U) -> io_bht.bht_pred_pc
>    ))
> 
>    when (reset) {
>         pc_reg := RESET_VECTOR.U
>    } .elsewhen (!io.pc_stall) {
>         pc_reg := next_pc
>    }
>    ```
> 
>    But note: the condition `reset` is the global reset. We assume it is passed to the module? Actually, in Chisel, the reset is implicit. We can use `reset` which is the implicit reset of the module.
> 
>    Alternatively, we can use the synchronous reset by having a reset signal? The problem does not specify a reset port. We must check the IO ports: there is no reset. So we assume that the module has an implicit reset.
> 
>    So we'll do:
> 
>    ```
>    val pc_reg = RegInit(RESET_VECTOR.U(32.W))
>    when (reset) {
>         pc_reg := RESET_VECTOR.U
>    } elsewhen (!io.pc_stall) {
>         pc_reg := next_pc
>    }
>    ```
> 
>    But note: the next_pc computation does not include the reset condition? That's okay because during reset, the register is set to RESET_VECTOR and next_pc is not used.
> 
>    However, the problem says the reset condition is the highest. So we are setting the PC to RESET_VECTOR when reset is asserted, and that happens in the same cycle? Yes.
> 
> ### Task 4: Output registers for decode stage (id_pc and inst)
>    - We have two registers: id_pc_reg and inst_reg.
>    - They should be updated every cycle unless stalled by `if_id_stall`. Also, if we have a flush (`if_id_flush`), then we should set the instruction to a bubble (like 0x00000013, which is nop, or 0.U?).
> 
>    The problem says: "Notice that the output interact with decode stage should be registers". So we output the registers.
> 
>    We also have:
>         io.id_pc := id_pc_reg
>         io.inst := inst_reg
> 
>    How to update id_pc_reg and inst_reg?
> 
>    Typically, in a pipeline:
>         - When not stalled: we update the pipeline register with the new values.
>         - When stalled: we keep the old values.
>         - When flushed: we set the instruction to a bubble (nop) and the PC can be anything? But usually, we set the PC as well? Or just the instruction? The problem doesn't specify. We'll set the instruction to a bubble (0.U) and the PC we can keep or set to 0? But the decode stage might not care about the PC if the instruction is a bubble. However, for debugging, we might want to keep the PC? But the specification does not say.
> 
>    Since the problem does not specify, we do:
> 
>         When if_id_flush: set inst_reg to 0.U (which is an illegal instruction or nop? In RISC-V, 0 is a valid instruction (nop: addi x0, x0, 0). But to avoid any side effect, we set to 0.U? Or we set to a known nop? Actually, 0x00000013 is the nop. But note, the instruction input from top is io.fetch_data. When we flush, we don't want to pass a valid instruction. So we set it to a nop? And the PC? We can set to 0? But it's better to keep the PC? Actually, the problem doesn't specify.
> 
>    Let me think: the flush signal comes from hazard unit when there is a misprediction or exception? Then we want to discard the current instruction and insert a bubble. The bubble is a nop. So we set the instruction to nop. The PC doesn't matter for the nop? But the decode stage might use the PC for exception handling? We can keep the PC as the one that was fetched? Or we can set the PC to 0? It's safer to keep the PC? Actually, the PC of the nop is not used because the nop does nothing. But we can just set the instruction to nop and leave the PC as the current PC? However, the problem says "flush", meaning we want to invalidate the current instruction. So we can set the instruction to nop and the PC can be arbitrary? But to avoid confusing the decode stage, we set the instruction to nop and the PC to 0? Or we don't change the PC? Actually, we don't need to change the PC for the decode stage because the instruction is nop. We can keep the PC as the one that was in the fetch stage? But when we flush, we are going to refetch, so the current instruction in the pipeline is invalid. We are going to refetch from the corrected address. So the PC we are sending to decode is the one for the instruction that is being flushed. It might be better to set the instruction to nop and the PC to the PC of the flushed instruction? But the problem doesn't specify.
> 
>    However, the problem says "if_id_flush", so we flush the IF/ID register. We can set the instruction to 0 (which is nop) and the PC we can let pass? But note, the PC for the next stage might be the PC of the instruction that we are flushing? That is okay because the nop will be executed in place of the flushed instruction, and the PC is for the flushed instruction? But the PC of the nop should be the same as the flushed instruction? Because the nop is inserted at that address. So we should keep the PC? But the problem says "flush", meaning we are removing the instruction. However, the PC is part of the state for the instruction. So we can do:
> 
>         When if_id_flush: set the instruction to nop (0.U) and leave the PC as the PC of the instruction we are flushing? But we are already storing the PC in id_pc_reg. We don't want to change the PC? Then we only change the instruction to nop.
> 
>    Alternatively, we can set the entire register to 0? But the PC might be non-zero? We are going to update the id_pc_reg with the current PC (from the fetch stage) and the inst_reg with the fetched data. But when we flush, we only want to change the inst_reg to nop? We don't change the id_pc_reg? That is acceptable.
> 
>    So:
> 
>         When if_id_flush: set inst_reg to 0.U (which is nop) and leave id_pc_reg unchanged? But note: the flush might happen at the same time as a stall? We have to consider the priority.
> 
>    The update of the pipeline registers (id_pc_reg and inst_reg) should be:
> 
>         if (reset) {
>             id_pc_reg := 0.U
>             inst_reg := 0.U
>         } else if (io.if_id_flush) {
>             inst_reg := 0.U   // nop
>             // id_pc_reg remains? Actually, we don't want to change the PC? Or we can also set it to 0? The problem doesn't specify. Let's keep it unchanged? But if we are flushing, we are going to refetch, so the PC of the nop is irrelevant. So we can set the inst_reg to nop and leave the id_pc_reg as the current value? But the current value is the PC of the instruction that was fetched? That might be the next instruction? We are in the same cycle as the flush: we are going to update the pipeline register at the end of the cycle. So:
> 
>         We are going to set:
>             id_pc_reg := ... the current PC that we are fetching? or the PC of the instruction we just fetched? Actually, the PC we are using to fetch is stored in pc_reg. But the instruction we are fetching in the current cycle is for the current pc_reg? So when we are updating the pipeline register, we are storing the current pc_reg and the fetched data (io.fetch_data) into id_pc_reg and inst_reg.
> 
>         But when we flush, we want to replace the instruction that is about to be written into the pipeline register with a nop? So we are going to set the inst_reg to 0.U and the id_pc_reg we set to the current pc_reg? Or we don't update the id_pc_reg? Actually, we are going to update both? But then the PC would be the PC of the instruction we are flushing? That is acceptable.
> 
>         Alternatively, we can update the pipeline registers normally and then override the inst_reg if flush is asserted? But the flush is an input, so we can do:
> 
>         ```
>         // Normal update: if not stalled, we update with the current fetch data and PC.
>         // But if stalled, we keep the old value.
> 
>         when (reset) {
>             id_pc_reg := 0.U
>             inst_reg := 0.U
>         } .elsewhen (io.if_id_flush) {
>             inst_reg := 0.U   // set to nop
>             // id_pc_reg we can set to the current PC? Or leave as the old value? 
>             // But note: we might have already updated it? We want to flush the current instruction that is being captured? So we set the inst to nop and the PC we set to the current pc_reg? But that pc_reg is the one for the instruction we are flushing? 
>             // Actually, we are at the end of the cycle: the instruction we are flushing is the one we just fetched? So we want the PC to be the address of that instruction? Then we should set id_pc_reg to the current pc_reg? But we are updating the pipeline register at the end of the cycle. So:
> 
>             id_pc_reg := pc_reg   // the PC of the instruction that we are flushing? 
>             // But note: the pc_reg is the PC that was used to fetch the current instruction (which we are flushing). So that is correct.
> 
>         } .elsewhen (!io.if_id_stall) {
>             // Normal update: capture the current PC and the fetched instruction.
>             id_pc_reg := pc_reg
>             inst_reg := io.fetch_data
>         }
>         // Otherwise (stall and not flush and not reset): do nothing, so the registers keep their values.
> 
>         ```
> 
>         But note: the flush condition should override the normal update? That is, if we are flushing, we don't care about the fetched instruction? We set it to nop. And we set the PC to the current PC? But the current PC is the one that we used to fetch the instruction that is being flushed? That is correct.
> 
>         However, we are updating the id_pc_reg to pc_reg in the flush case? That is the same as we would do in the normal update? Then we can do:
> 
>         ```
>         when (reset) {
>             id_pc_reg := 0.U
>             inst_reg := 0.U
>         } .elsewhen (!io.if_id_stall) {
>             // Even in flush, we are going to update the pipeline register? But we want to set the instruction to nop? So we can do:
> 
>             id_pc_reg := pc_reg
>             inst_reg := Mux(io.if_id_flush, 0.U, io.fetch_data)
>         }
>         ```
> 
>         This way, we update the id_pc_reg to the current pc_reg and the inst_reg to either 0.U (if flush) or the fetched data.
> 
>         But note: the stall condition: if we are stalled, we don't update at all. And if we are not stalled, we update the id_pc_reg and inst_reg. And if we are flushing, we set the instruction to nop.
> 
>         That seems efficient.
> 
>         So:
> 
>         ```
>         when (reset) {
>             id_pc_reg := 0.U
>             inst_reg := 0.U
>         } .elsewhen (!io.if_id_stall) {
>             id_pc_reg := pc_reg
>             // If flush, we set the instruction to nop, otherwise the fetched data.
>             inst_reg := Mux(io.if_id_flush, 0.U, io.fetch_data)
>         }
>         ```
> 
>         But note: the problem does not specify what to do when flush and stall happen at the same time? We assume that the flush and stall signals are managed by the hazard unit appropriately? Typically, flush has higher priority than stall? But the problem doesn't say. However, the condition above: if the stall is false, then we update and if flush is true we set to nop. If stall is true, we don't update. So if both are true, we don't update? That might be acceptable? But flush might require immediate action? We have to check the typical pipeline:
> 
>         - Flush: we want to remove the current instruction in the IF/ID register and replace with a bubble. We do that by setting the instruction to nop. But if we are stalled, we don't update the register? Then the bubble would not be inserted until the stall is released? That might be too late.
> 
>         So we need to handle flush even when stalled? How? We can do:
> 
>         ```
>         when (reset) {
>             id_pc_reg := 0.U
>             inst_reg := 0.U
>         } .elsewhen (io.if_id_flush) {
>             // When flush, we set the instruction to nop and update the PC? Even if we are stalled? But the stall is for the pipeline, meaning we don't want to advance? But we want to flush the current instruction? So we can update the register to bubble regardless of stall? That is, flush overrides stall.
> 
>             inst_reg := 0.U
>             // We also update the PC? The PC of the bubble? We set id_pc_reg to the current pc_reg? But note: the current pc_reg might change during the stall? Actually, during stall, the pc_reg does not change. So the current pc_reg is the PC of the instruction we are flushing? So we set:
> 
>             id_pc_reg := pc_reg   // This is the PC of the flushed instruction? But we are not updating the PC during stall? So it's the same as before? Actually, we are in the same cycle, so we can set id_pc_reg to pc_reg? But we are in the same cycle as the flush, and the pc_reg is the one that was used to fetch the instruction that we are flushing? So that is correct.
> 
>         } .elsewhen (!io.if_id_stall) {
>             id_pc_reg := pc_reg
>             inst_reg := io.fetch_data
>         }
>         ```
> 
>         But note: the flush might happen at the same time as the stall? We are handling flush regardless of stall? That is, if flush is asserted, we update the pipeline register to the bubble? Even if stall is asserted? That is acceptable because we are effectively inserting a bubble and we don't care about the stall? The stall is for preventing new instructions from being captured? But flush has the effect of discarding the current instruction? So we can update the register to bubble even during stall? That is, we break the stall for the purpose of inserting the bubble? But then the next instruction might be lost? We have to be cautious.
> 
>         Actually, the flush signal is usually generated when there is a misprediction or exception, and we want to clear the pipeline. So we want to clear the current IF/ID register immediately, even if we are stalled? Because the stall might be due to a data hazard, but the flush is due to a control hazard. The flush has higher priority.
> 
>         So we can do:
> 
>         ```
>         when (reset) {
>             id_pc_reg := 0.U
>             inst_reg := 0.U
>         } .elsewhen (io.if_id_flush) {
>             inst_reg := 0.U
>             id_pc_reg := pc_reg   // set to the current PC? Or we can set to 0? The problem doesn't specify. But we set to the PC that was used to fetch the instruction we are flushing.
>         } .elsewhen (!io.if_id_stall) {
>             id_pc_reg := pc_reg
>             inst_reg := io.fetch_data
>         }
>         ```
> 
>         This way, if flush is asserted, we set the instruction to nop and the PC to the current PC (the one that was used to fetch, which is the one we are flushing). And we do this even if we are stalled? But note: if we are stalled, the pc_reg is not updating? So the pc_reg is the same as the previous cycle? Then we are setting the id_pc_reg to the same value as it might have been? But we are updating the inst_reg to nop? That is the important part.
> 
>         Alternatively, we might not want to update the id_pc_reg during flush when stalled? Because it's the same as the previous cycle? But we are updating it to the same value? It doesn't matter. But we are updating the inst_reg to nop, which is what we want.
> 
>         However, what if the flush is asserted and we are not stalled? Then we set the pipeline register to (nop, current PC). And then the next cycle, if we are not stalled, we update with the new fetch? That is correct.
> 
>         But note: the current PC (pc_reg) at the time of flush is the PC of the instruction that is being flushed? And we are setting id_pc_reg to that PC? That is acceptable.
> 
>         So we do:
> 
>         ```
>         when (reset) {
>             id_pc_reg := 0.U
>             inst_reg := 0.U
>         } .elsewhen (io.if_id_flush) {
>             inst_reg := 0.U
>             id_pc_reg := pc_reg
>         } .elsewhen (!io.if_id_stall) {
>             id_pc_reg := pc_reg
>             inst_reg := io.fetch_data
>         }
>         ```
> 
>         But note: the flush and not stall: we set the pipeline register to (pc_reg, 0.U). Then the next cycle, if we are not stalled, we update again? That might be okay? But the flush is for the current instruction in the pipeline? So we are replacing the current fetched instruction (which we are about to write into the pipeline register) with a nop. So we do:
> 
>         - In the same cycle that we fetch an instruction that we later decide to flush (because of a misprediction in the same cycle?), we set the instruction to nop? But the problem doesn't specify the timing. We assume the flush signal is generated in the same cycle as the fetch? And we are updating the pipeline register at the end of the cycle? So we can use the flush to override.
> 
>         This design is typical.
> 
> ### Task 5: Connect the fetch_address (output to top) to the current PC.
>    - We do: `io.fetch_address := pc_reg`
> 
>    But note: the Icache might need the address one cycle earlier? The problem says "from top" we have `io.fetch_data`, meaning the instruction that was fetched for the current PC? So we are using the PC to fetch, and in the same cycle we get the fetch_data? That is, the Icache is combinatorial? Or it is synchronous? The problem does not specify. We assume that the Icache is synchronous and that we get the data in the next cycle? Then the fetch_address should be the address we want to fetch in the next cycle? But the problem says "to top: fetch_address", and "from top: fetch_data". So the module DUT (fetch) outputs the address and in the same cycle gets the data? That is combinatorial? But then the data would be available in the same cycle? That is not typical for a synchronous memory.
> 
>    Alternatively, we might be providing the address in one cycle and getting the data in the next? Then the fetch_address we output in cycle n is used to get the data in cycle n+1? But then we would have a pipeline register for the fetched instruction? We don't have that. The problem says the fetch_data is an input, and we are using it to update the inst_reg? And we output the PC as fetch_address? So we are doing:
> 
>         Cycle n: output pc_reg as fetch_address
>         Cycle n+1: we get the fetch_data (the instruction for the address we output in cycle n) and we update the pipeline register (if_id) with that instruction and the PC (which was the pc_reg in cycle n) but only if not stalled and not flushed? 
> 
>    But note: the current PC (pc_reg) in cycle n is the address of the instruction we are fetching? But in cycle n+1, we are using the fetch_data to update the pipeline register? So the PC we are storing in the pipeline register is the old PC (from cycle n). That is correct.
> 
>    However, the problem does not specify the timing. We are going to output the current pc_reg as the fetch_address. And we assume that the top level will provide the fetch_data in the same cycle? Then we can update the pipeline register in the same cycle? But that would require combinatorial memory? 
> 
>    Alternatively, we might be using a synchronous memory? Then the fetch_data comes one cycle later? Then we would need to adjust the design? The problem does not specify, so we assume combinatorial memory? Or we assume that the fetch_data is the instruction for the address we output in the previous cycle? Then we would need to have an additional register for the PC that we output? But the problem says "to top: fetch_address", and that is the current PC? And the fetch_data is the instruction for that current PC? So we are doing:
> 
>         In cycle n:
>             fetch_address = pc_reg (current PC)
>             fetch_data comes in the same cycle? (combinatorial memory) -> then we can use it to update the pipeline register in the same cycle? 
> 
>         But then the PC update logic must be done at the end of the cycle? And the fetch_data is available during the cycle? 
> 
>    This is acceptable if the memory is combinatorial.
> 
>    But note: the problem says "fetch stage use the current PC to fetch instruction". So we output the current PC and get the instruction in the same cycle. So we are using combinatorial memory? Then we can do as above.
> 
>    If the memory is synchronous, we would need to adjust and have a register for the address we sent? But the problem does not specify, so we assume combinatorial.
> 
>    So we do: `io.fetch_address := pc_reg`
> 
>    And we use `io.fetch_data` directly to update the inst_reg? As above.
> 
>    But note: the inst_reg update is only when not stalled? And we are using the fetch_data that corresponds to the address we sent in the same cycle? So if we stall, we don't update the PC? Then we are going to refetch the same instruction? But the memory might have changed? We assume that the memory is fixed? Or we are using a cache? The problem says "Icache", so we assume it holds the instruction and we can refetch? Or we are using a buffer? The problem doesn't specify. We assume that the Icache holds the instruction for the same address until we change the address? So if we stall, we keep the same address? Then we get the same instruction? That is acceptable.
> 
>    However, note that the fetch_address is output as pc_reg. If we are stalled, we keep the same pc_reg? Then we output the same address? So the Icache will return the same instruction? And we don't update the pipeline register? So the decode stage sees the same instruction? That is correct.
> 
>    So the design is:
> 
>         io.fetch_address := pc_reg
> 
>    And the fetch_data we get is for the current pc_reg.
> 
>    Then we update the pipeline register as described.
> 
>    Now, let's write the tasks:
> 
> ### Task 1: Define internal registers and wires
> ### Task 2: Instantiate BHT and BTB and connect
> ### Task 3: Implement the PC update logic
> ### Task 4: Implement the output registers for decode stage (with flush and stall)
> ### Task 5: Connect the fetch_address
> 
>  We'll code accordingly.
> 
>  Note: We haven't defined RESET_VECTOR. We'll define it as a constant:
> 
>         val RESET_VECTOR = 0x80000000
> 
>  But we can make it a parameter? The problem does not specify. We'll define it as a constant for now.
> 
>  Let's code step by step.
> 

Based on the provided module specifications, here's a professional task breakdown for implementing the Fetch module in Chisel:

---

