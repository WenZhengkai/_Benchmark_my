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
  require(entries > 0, "Queue entries must be positive")
  
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
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full
  
  // Enqueue and dequeue control signals
  val do_enq = WireDefault(io.enq.fire)
  val do_deq = WireDefault(io.deq.fire)
  
  // Handle flush if enabled
  val do_flush = if (hasFlush) io.flush.get else false.B
  
  when(do_flush) {
    enq_ptr := 0.U
    deq_ptr := 0.U
    maybe_full := false.B
  }.otherwise {
    // Enqueue operation
    when(do_enq) {
      ram(enq_ptr) := io.enq.bits
      enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U)
    }
    
    // Dequeue operation
    when(do_deq) {
      deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U)
    }
    
    // Update maybe_full
    when(do_enq =/= do_deq) {
      maybe_full := do_enq
    }
  }
  
  // IO connections
  io.enq.ready := !full || do_flush
  io.deq.valid := !empty && !do_flush
  io.deq.bits := ram(deq_ptr)
  
  // Count calculation
  val ptr_diff = enq_ptr - deq_ptr
  val count_val = WireDefault(0.U(log2Ceil(entries + 1).W))
  
  when(maybe_full && ptr_match) {
    count_val := entries.U
  }.elsewhen(ptr_match) {
    count_val := 0.U
  }.otherwise {
    // Handle wrap-around for circular buffer
    count_val := Mux(
      enq_ptr > deq_ptr,
      enq_ptr - deq_ptr,
      (entries.U - deq_ptr) + enq_ptr
    )
  }
  
  io.count := Mux(do_flush, 0.U, count_val)
}

// Alternative optimized implementation for power-of-2 sizes
class dut_pow2[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0 && isPow2(entries), "Queue entries must be a positive power of 2")
  
  val io = IO(new QueueIO(gen, entries, hasFlush))
  
  // Memory for storage
  val ram = Mem(entries, gen)
  
  // Pointer management with extra bit for full/empty detection
  val ptrWidth = log2Ceil(entries) + 1
  val enq_ptr = RegInit(0.U(ptrWidth.W))
  val deq_ptr = RegInit(0.U(ptrWidth.W))
  
  // Extract actual indices
  val enq_idx = enq_ptr(log2Ceil(entries) - 1, 0)
  val deq_idx = deq_ptr(log2Ceil(entries) - 1, 0)
  
  // Full and empty logic using MSB
  val ptr_match = enq_idx === deq_idx
  val msb_match = enq_ptr(ptrWidth - 1) === deq_ptr(ptrWidth - 1)
  val full = ptr_match && !msb_match
  val empty = ptr_match && msb_match
  
  // Enqueue and dequeue control signals
  val do_enq = WireDefault(io.enq.fire)
  val do_deq = WireDefault(io.deq.fire)
  
  // Handle flush if enabled
  val do_flush = if (hasFlush) io.flush.get else false.B
  
  when(do_flush) {
    enq_ptr := 0.U
    deq_ptr := 0.U
  }.otherwise {
    // Enqueue operation
    when(do_enq) {
      ram(enq_idx) := io.enq.bits
      enq_ptr := enq_ptr + 1.U
    }
    
    // Dequeue operation
    when(do_deq) {
      deq_ptr := deq_ptr + 1.U
    }
  }
  
  // IO connections
  io.enq.ready := !full || do_flush
  io.deq.valid := !empty && !do_flush
  io.deq.bits := ram(deq_idx)
  
  // Count calculation
  io.count := Mux(do_flush, 0.U, (enq_ptr - deq_ptr)(log2Ceil(entries), 0))
}
