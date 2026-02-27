import chisel3._
import chisel3.util._

class QueueIO[T <: Data](val gen: T, val entries: Int, val hasFlush: Boolean = false) extends Bundle {
  val enq = Flipped(DecoupledIO(gen.cloneType))
  val deq = DecoupledIO(gen.cloneType)
  val count = Output(UInt(log2Ceil(entries + 1).W))
  val flush = if (hasFlush) Some(Input(Bool())) else None
}

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue must have positive number of entries")
  
  val io = IO(new QueueIO(gen, entries, hasFlush))
  
  // For the case when entries is 1, we need special handling
  if (entries == 1) {
    // Single entry queue implementation
    val valid = RegInit(false.B)
    val data = Reg(gen.cloneType)
    
    // Enqueue logic
    val do_enq = io.enq.ready && io.enq.valid
    io.enq.ready := !valid || io.deq.ready
    
    // Dequeue logic
    val do_deq = io.deq.ready && io.deq.valid
    io.deq.valid := valid
    io.deq.bits := data
    
    // State updates
    when (do_enq) {
      data := io.enq.bits
      valid := true.B
    }
    
    when (do_deq) {
      valid := false.B
    }
    
    // Count output
    io.count := valid.asUInt
    
    // Flush logic if applicable
    if (hasFlush) {
      when (io.flush.get) {
        valid := false.B
      }
    }
  } else {
    // Multi-entry queue implementation
    // Use memory to store elements
    val ram = Mem(entries, gen)
    
    // Pointers for enqueue and dequeue operations
    val enq_ptr = Counter(entries)
    val deq_ptr = Counter(entries)
    val maybe_full = RegInit(false.B)
    
    // Track whether pointers are at the same position
    val ptr_match = enq_ptr.value === deq_ptr.value
    
    // Full/empty state logic
    val empty = ptr_match && !maybe_full
    val full = ptr_match && maybe_full
    
    // Enqueue/dequeue condition flags
    val do_enq = io.enq.ready && io.enq.valid
    val do_deq = io.deq.ready && io.deq.valid
    
    // Ready/valid signals
    io.enq.ready := !full
    io.deq.valid := !empty
    
    // Handle enqueue operation
    when (do_enq) {
      ram(enq_ptr.value) := io.enq.bits
      enq_ptr.inc()
    }
    
    // Handle dequeue operation
    when (do_deq) {
      deq_ptr.inc()
    }
    
    // Update the maybe_full state
    when (do_enq =/= do_deq) {
      maybe_full := do_enq
    }
    
    // Output data from the queue
    io.deq.bits := ram(deq_ptr.value)
    
    // Count logic - calculate the number of elements in the queue
    if (isPow2(entries)) {
      // When entries is a power of 2, we can use bit arithmetic
      val ptr_diff = enq_ptr.value - deq_ptr.value
      io.count := Mux(full, entries.U, ptr_diff)
    } else {
      // For non-power-of-2 entries, use conditional logic
      val count = RegInit(0.U(log2Ceil(entries + 1).W))
      when (do_enq =/= do_deq) {
        val new_count = Mux(do_enq, count + 1.U, count - 1.U)
        count := new_count
      }
      io.count := count
    }
    
    // Flush logic if applicable
    if (hasFlush) {
      when (io.flush.get) {
        enq_ptr.reset()
        deq_ptr.reset()
        maybe_full := false.B
      }
    }
  }
}
