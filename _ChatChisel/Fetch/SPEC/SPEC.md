
Module name: fetch
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


