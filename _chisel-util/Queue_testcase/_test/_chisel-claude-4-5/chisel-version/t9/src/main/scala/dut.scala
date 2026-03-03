import chisel3._
import chisel3.util._

class QueueIO[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Bundle {
  val enq = Flipped(Decoupled(gen))
  val deq = Decoupled(gen)
  val count = Output(UInt(log2Ceil(entries + 1).W))
  val flush = if (hasFlush) Some(Input(Bool())) else None
  
  override def cloneType: this.type = 
    new QueueIO(gen, entries, hasFlush).asInstanceOf[this.type]
}

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  val io = IO(new QueueIO(gen, entries, hasFlush))
  
  // Memory for storage
  val ram = Mem(entries, gen)
  
  // Pointer management
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)
  
  // Pointer match condition
  val ptr_match = enq_ptr === deq_ptr
  
  // Full and empty logic
  val empty = ptr_match && !maybe_full
  val full = ptr_match && maybe_full
  
  // Control signals
  val do_enq = WireDefault(io.enq.fire)
  val do_deq = WireDefault(io.deq.fire)
  
  // Handle flush if enabled
  val do_flush = if (hasFlush) io.flush.get else false.B
  
  // Enqueue ready signal
  io.enq.ready := !full
  
  // Dequeue valid signal and data output
  io.deq.valid := !empty
  io.deq.bits := ram(deq_ptr)
  
  // Enqueue operation
  when(do_enq) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := enq_ptr + 1.U
  }
  
  // Dequeue operation
  when(do_deq) {
    deq_ptr := deq_ptr + 1.U
  }
  
  // Update maybe_full register
  when(do_enq =/= do_deq) {
    maybe_full := do_enq
  }
  
  // Flush mechanism
  when(do_flush) {
    enq_ptr := 0.U
    deq_ptr := 0.U
    maybe_full := false.B
  }
  
  // Count calculation
  val count = WireDefault(0.U(log2Ceil(entries + 1).W))
  
  when(ptr_match) {
    count := Mux(maybe_full, entries.U, 0.U)
  }.elsewhen(enq_ptr > deq_ptr) {
    count := enq_ptr - deq_ptr
  }.otherwise {
    count := entries.U - (deq_ptr - enq_ptr)
  }
  
  io.count := count
}

// Example usage and test instantiation
/*
object dutGenerator extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(
    new dut(UInt(8.W), 16, hasFlush = true),
    Array("--target-dir", "generated")
  )
}
*/
