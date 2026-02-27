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

