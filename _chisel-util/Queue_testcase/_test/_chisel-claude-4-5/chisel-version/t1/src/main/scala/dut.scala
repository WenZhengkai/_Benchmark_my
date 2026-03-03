import chisel3._
import chisel3.util._

class QueueIO[T <: Data](
  private val gen: T,
  val entries: Int,
  val hasFlush: Boolean = false
) extends Bundle {
  val enq = Flipped(Decoupled(gen))
  val deq = Decoupled(gen)
  val count = Output(UInt(log2Ceil(entries + 1).W))
  val flush = if (hasFlush) Some(Input(Bool())) else None
}

class dut[T <: Data](
  gen: T,
  entries: Int,
  hasFlush: Boolean = false
) extends Module {
  require(entries > 0, "Queue must have at least one entry")
  
  val io = IO(new QueueIO(gen, entries, hasFlush))
  
  // Memory for storage
  val ram = Mem(entries, gen)
  
  // Pointers for enqueue and dequeue
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  
  // Flag to track if queue might be full
  val maybe_full = RegInit(false.B)
  
  // Pointer match condition
  val ptr_match = enq_ptr === deq_ptr
  
  // Full and empty conditions
  val empty = ptr_match && !maybe_full
  val full = ptr_match && maybe_full
  
  // Enqueue and dequeue control signals
  val do_enq = WireDefault(io.enq.fire)
  val do_deq = WireDefault(io.deq.fire)
  
  // Handle flush if enabled
  val do_flush = if (hasFlush) io.flush.get else false.B
  
  when (do_flush) {
    enq_ptr := 0.U
    deq_ptr := 0.U
    maybe_full := false.B
  } .otherwise {
    // Update enqueue pointer and write data
    when (do_enq) {
      ram(enq_ptr) := io.enq.bits
      enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U)
    }
    
    // Update dequeue pointer
    when (do_deq) {
      deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U)
    }
    
    // Update maybe_full flag
    when (do_enq =/= do_deq) {
      maybe_full := do_enq
    }
  }
  
  // Connect enqueue interface
  io.enq.ready := !full || do_flush
  
  // Connect dequeue interface
  io.deq.valid := !empty && !do_flush
  io.deq.bits := ram(deq_ptr)
  
  // Calculate count
  val ptr_diff = enq_ptr - deq_ptr
  
  io.count := Mux(
    ptr_match,
    Mux(maybe_full, entries.U, 0.U),
    Mux(
      enq_ptr > deq_ptr,
      ptr_diff,
      (entries.U +& ptr_diff)(log2Ceil(entries).W)
    )
  )
}

// Example usage with test wrapper
/*
object dutExample extends App {
  println("Generating Verilog for dut module...")
  (new chisel3.stage.ChiselStage).emitVerilog(
    new dut(UInt(8.W), 4, hasFlush = true),
    Array("--target-dir", "generated")
  )
}
*/
