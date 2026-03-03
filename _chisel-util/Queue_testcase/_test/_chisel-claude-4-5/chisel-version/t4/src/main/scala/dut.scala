import chisel3._
import chisel3.util._

class QueueIO[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Bundle {
  val enq = Flipped(Decoupled(gen))
  val deq = Decoupled(gen)
  val count = Output(UInt(log2Ceil(entries + 1).W))
  val flush = if (hasFlush) Some(Input(Bool())) else None
  
  override def cloneType: this.type = new QueueIO(gen, entries, hasFlush).asInstanceOf[this.type]
}

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  val io = IO(new QueueIO(gen, entries, hasFlush))
  
  // Memory for storage
  val ram = Mem(entries, gen)
  
  // Pointer management
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)
  
  // Pointer match logic
  val ptr_match = enq_ptr === deq_ptr
  
  // Full/Empty logic
  val empty = ptr_match && !maybe_full
  val full = ptr_match && maybe_full
  
  // Enqueue and dequeue conditions
  val do_enq = Wire(Bool())
  val do_deq = Wire(Bool())
  
  do_enq := io.enq.fire
  do_deq := io.deq.fire
  
  // Ready/Valid signals
  io.enq.ready := !full
  io.deq.valid := !empty
  
  // Data output
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
  
  // Update maybe_full flag
  when(do_enq =/= do_deq) {
    maybe_full := do_enq
  }
  
  // Flush mechanism
  if (hasFlush) {
    when(io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }
  
  // Count calculation
  val ptr_diff = enq_ptr - deq_ptr
  
  if (isPow2(entries)) {
    // For power of 2 entries, use simple difference or add entries
    io.count := Mux(ptr_match,
      Mux(maybe_full, entries.U, 0.U),
      Mux(enq_ptr > deq_ptr, ptr_diff, entries.U + ptr_diff)
    )
  } else {
    // For non-power of 2 entries
    io.count := Mux(ptr_match,
      Mux(maybe_full, entries.U, 0.U),
      Mux(enq_ptr > deq_ptr, ptr_diff, entries.U + ptr_diff)
    )
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(
    new dut(UInt(8.W), entries = 4, hasFlush = true),
    Array("--target-dir", "generated")
  )
}
*/
