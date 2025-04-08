import chisel3._
import chisel3.util._

class dut[T <: Data](
  gen: T, 
  entries: Int, 
  hasFlush: Boolean = false
) extends Module {
  require(entries > 0, "Number of entries must be positive.")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen)) // Input interface for enqueue
    val deq = Decoupled(gen)          // Output interface for dequeue
    val count = Output(UInt(log2Ceil(entries + 1).W)) // Current element count
    val flush = if (hasFlush) Some(Input(Bool())) else None // Optional flush input
  })

  // Task 1: Memory Storage (`ram`)
  val ram = Mem(entries, gen)

  // Task 2: Pointer Management
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))  // Enqueue pointer
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))  // Dequeue pointer
  val maybe_full = RegInit(false.B)                // Maybe full flag
  val ptr_match = enq_ptr === deq_ptr              // Pointer equality

  // Task 3: Full/Empty Logic
  val full = ptr_match && maybe_full               // Full condition
  val empty = ptr_match && !maybe_full             // Empty condition

  io.enq.ready := !full                            // Queue is ready for enqueue if not full
  io.deq.valid := !empty                           // Queue has valid data for dequeue if not empty

  // Task 4: Enqueue Logic
  val do_enq = io.enq.valid && io.enq.ready
  when(do_enq) {
    ram(enq_ptr) := io.enq.bits                    // Write data to the memory
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U) // Increment and wrap pointer
    when(!io.deq.ready || empty) {
      maybe_full := true.B                         // Update maybe_full if enqueue without simultaneous dequeue
    }
  }

  // Task 5: Dequeue Logic
  val do_deq = io.deq.ready && io.deq.valid
  io.deq.bits := ram(deq_ptr)                    // Read data from memory
  when(do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U) // Increment and wrap pointer
    when(!io.enq.valid || full) {
      maybe_full := false.B                      // Update maybe_full if dequeue without simultaneous enqueue
    }
  }

  // Task 6: Flush Mechanism (Conditional)
  if (hasFlush) {
    when(io.flush.getOrElse(false.B)) {
      enq_ptr := 0.U                             // Reset enqueue pointer
      deq_ptr := 0.U                             // Reset dequeue pointer
      maybe_full := false.B                      // Reset maybe_full
    }
  }

  // Task 7: Count Calculation
  if (isPow2(entries)) {
    io.count := Mux(maybe_full, entries.U, enq_ptr - deq_ptr)
  } else {
    io.count := Mux(
      ptr_match,
      Mux(maybe_full, entries.U, 0.U),
      Mux(deq_ptr > enq_ptr, entries.U - deq_ptr + enq_ptr, enq_ptr - deq_ptr)
    )
  }
}

// Testbench or wrapper can be written separately to use the dut module.
