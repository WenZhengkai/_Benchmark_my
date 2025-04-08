import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue entries must be greater than 0")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen)) // Input with valid/ready handshake
    val deq = Decoupled(gen)          // Output with valid/ready handshake
    val count = Output(UInt(log2Ceil(entries + 1).W)) // Queue element count
    val flush = if (hasFlush) Some(Input(Bool())) else None // Optional flush signal
  })

  // ----- Task 1: Memory Storage -----
  val ram = Mem(entries, gen)

  // ----- Task 2: Pointer Management -----
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W)) // Pointer for enqueue
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W)) // Pointer for dequeue
  val maybe_full = RegInit(false.B)               // Tracks if queue might be full
  val ptr_match = enq_ptr === deq_ptr             // Pointer equality

  // ----- Task 3: Full/Empty Logic -----
  val full = ptr_match && maybe_full              // Queue is full
  val empty = ptr_match && !maybe_full            // Queue is empty

  io.enq.ready := !full                           // Ready to accept new data if not full
  io.deq.valid := !empty                          // Valid data to dequeue if not empty

  // ----- Task 4: Enqueue Logic -----
  val do_enq = io.enq.valid && io.enq.ready       // Enqueue condition

  when(do_enq) {
    ram.write(enq_ptr, io.enq.bits) // Write data to memory at enq_ptr
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U) // Increment enq_ptr with wrap-around
  }

  // Update maybe_full when enqueueing without dequeueing
  when(do_enq && !(io.deq.ready && io.deq.valid)) {
    maybe_full := true.B
  }

  // ----- Task 5: Dequeue Logic -----
  val do_deq = io.deq.ready && io.deq.valid       // Dequeue condition

  when(do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U) // Increment deq_ptr with wrap-around
  }

  // Update maybe_full when dequeueing without enqueueing
  when(do_deq && !(io.enq.valid && io.enq.ready)) {
    maybe_full := false.B
  }

  // ----- Task 6: Flush Mechanism -----
  if (hasFlush) {
    when(io.flush.getOrElse(false.B)) { // When flush is asserted
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B // Reset queue state
    }
  }

  // ----- Task 7: Count Calculation -----
  val diff = Mux(enq_ptr >= deq_ptr, enq_ptr - deq_ptr, (entries.U + enq_ptr) - deq_ptr)
  io.count := Mux(full, entries.U, diff) // Count is diff, or entries if queue is full

  // ----- Output Connections -----
  io.deq.bits := ram.read(deq_ptr) // Output the data at deq_ptr
}

