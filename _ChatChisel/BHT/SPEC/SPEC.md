Module name: BHT
I/O ports:
val io = IO(new Bundle {
    val pc = Input(UInt(32.W))
    val mem_pc = Input(UInt(32.W))
    val pcsrc = Input(UInt(1.W))
    val target_pc = Input(UInt(32.W))
    val matched = Output(UInt(1.W))
    val valid = Output(UInt(1.W))
    val bht_pred_pc = Output(UInt(32.W))
})
Internal Logic: 
In a RISC-V processor, the BHT is a table that stores branch history information. Each entry of the bht consists of three parts: tag, valid, and target_pc, indexed by the bits of the pc(5:2). Bht should have two functions, predicting the PC for the next cycle and update bht content based on PC redirection results.
predict: If the higher bits of the current pc matched the tag in the indexed entry, the output matched  is set to 1, and the valid and target_pc of that entry are also outputted.  
update: The update signal is from memory stage of the processor. If mem_pc is a jump instruction and a jump occurs (i.e. pcsrc=1), the upper bits of mem_pc is written in the BHT as tag along with the target_pc, and the valid bit is set to 1.

