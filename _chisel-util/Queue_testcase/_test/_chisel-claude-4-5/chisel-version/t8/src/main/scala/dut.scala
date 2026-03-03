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
  
  // Pointer match detection
  val ptr_match = enq_ptr === deq_ptr
  
  // Full/Empty logic
  val empty = ptr_match && !maybe_full
  val full = ptr_match && maybe_full
  
  // Enqueue and dequeue control signals
  val do_enq = WireDefault(io.enq.fire)
  val do_deq = WireDefault(io.deq.fire)
  
  // Flush logic
  val do_flush = if (hasFlush) io.flush.get else false.B
  
  when (do_flush) {
    enq_ptr := 0.U
    deq_ptr := 0.U
    maybe_full := false.B
  } .elsewhen (do_enq =/= do_deq) {
    maybe_full := do_enq
  }
  
  // Enqueue operation
  when (do_enq && !do_flush) {
    ram.write(enq_ptr, io.enq.bits)
    enq_ptr := enq_ptr + 1.U
  }
  
  // Dequeue operation
  when (do_deq && !do_flush) {
    deq_ptr := deq_ptr + 1.U
  }
  
  // IO connections
  io.enq.ready := !full
  io.deq.valid := !empty
  io.deq.bits := ram.read(deq_ptr)
  
  // Count calculation
  val ptr_diff = enq_ptr - deq_ptr
  val count = WireDefault(0.U(log2Ceil(entries + 1).W))
  
  when (ptr_match) {
    count := Mux(maybe_full, entries.U, 0.U)
  } .elsewhen (enq_ptr > deq_ptr) {
    count := ptr_diff
  } .otherwise {
    // Handle wrap-around case
    if (isPow2(entries)) {
      count := ptr_diff
    } else {
      count := (entries.U + ptr_diff)
    }
  }
  
  io.count := count
}
