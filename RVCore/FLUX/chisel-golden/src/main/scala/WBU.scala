import chisel3._
import chisel3.util._

class WbuToRegIO extends NPCBundle {

        val rd = UInt(5.W)
        val Res = UInt(XLen.W)
        val RegWrite = Bool()
}
class WBU extends NPCModule {
    val io = IO(new Bundle{
        val from_exu = Flipped(Decoupled(new ExuToWbuIO))
        val to_reg = Decoupled(new WbuToRegIO)

        val to_commit = Output(new CtrlFlow)


    })
    val AnyInvalidCondition = false.B // TODO: add condition to it
    // ready/valid setted here
    HandShakeDeal(io.from_exu, io.to_reg, AnyInvalidCondition)

    // io

    val inBits  = io.from_exu.bits
  
    val ResSrc = inBits.ctrl.ResSrc

    val ALURes = inBits.data.Alu0Res.bits
    val to_reg = io.to_reg.bits



    io.to_commit <> inBits.cf
    
    to_reg.rd   := inBits.ctrl.rd

    to_reg.RegWrite := inBits.ctrl.rfWen && io.to_reg.valid // Notice: This signal is important as valid signal
    to_reg.Res := MuxCase(0.U, Array(

        (ResSrc === 0.U) -> ALURes,
        (ResSrc === 1.U) -> inBits.data.data_from_mem,
        (ResSrc === 2.U) -> inBits.data.csrRdata
    ))
    // io
}

// WBU module - logic implementation for the Write Back Unit
class WBU_LLM extends NPCModule {
  val io = IO(new Bundle {
    val from_exu = Flipped(Decoupled(new ExuToWbuIO))
    val to_reg = Decoupled(new WbuToRegIO)
    val to_commit = Output(new CtrlFlow) // Output control flow info to commit stage
  })

  // Task 1: Handshake Protocol Implementation
  // Define AnyInvalidCondition (can be extended as needed)
  val AnyInvalidCondition = false.B


  HandShakeDeal(io.from_exu, io.to_reg, AnyInvalidCondition)

  // Task 2: Data Selection Logic for Write Back
  val writeBackData = Wire(UInt(io.to_reg.bits.Res.getWidth.W))

  // Multiplexer for selecting data source based on ResSrc signal
  writeBackData := Mux(io.from_exu.bits.ctrl.ResSrc === 0.U, io.from_exu.bits.data.Alu0Res.bits,
                   Mux(io.from_exu.bits.ctrl.ResSrc === 1.U, io.from_exu.bits.data.data_from_mem,
                   Mux(io.from_exu.bits.ctrl.ResSrc === 2.U, io.from_exu.bits.data.csrRdata,
                   0.U))) // Default case

  // Task 3: Generating Output Signals
  // Signal assignment for output interface
  io.to_reg.bits.rd := io.from_exu.bits.ctrl.rd
  io.to_reg.bits.Res := writeBackData
  io.to_reg.bits.RegWrite := io.from_exu.bits.ctrl.rfWen && io.to_reg.valid

  io.to_commit := io.from_exu.bits.cf

  // Keep the ready/valid handshake signals synchronized
  
}

