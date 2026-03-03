import chisel3._ 
import chisel3.util._

object CalBruRes extends HasNPCParameter{
    def apply(inBits:DecodeIO, alu0: ALU, csr0: CSR) : chisel3.Data= {
        //>>> branch pc calculate
        val bruRes = Wire(new BruRes)
        val jalrBruRes = Wire(new BruRes)
        jalrBruRes.valid := inBits.cf.isBranch && (inBits.cf.inst(6,0) === "b1100111".U)
        jalrBruRes.targetPc := (inBits.data.rfSrc1 + inBits.data.imm) & (~1.U(XLen.W))

        val typebBruRes = Wire(new BruRes)
        typebBruRes.valid := inBits.cf.isBranch && (inBits.cf.inst(6,0) === "b1100011".U)   // TYPE_B
        val pcIfBranch = inBits.cf.pc + inBits.data.imm
        typebBruRes.targetPc := Mux(alu0.io.taken, pcIfBranch, inBits.cf.pc + 4.U)    //TODO

        val csrBruRes = Wire(new BruRes)
        csrBruRes.valid := csr0.io.jmp
        csrBruRes.targetPc := csr0.io.out.bits

        val defaultBruRes = Wire(new BruRes)
        defaultBruRes.valid := false.B 
        defaultBruRes.targetPc := 0.U

        bruRes := MuxCase(defaultBruRes, Array(
            jalrBruRes.valid    -> jalrBruRes,
            typebBruRes.valid   -> typebBruRes,
            csrBruRes.valid     -> csrBruRes
        ))

        bruRes
    }
}