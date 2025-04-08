
import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue must have a positive number of entries")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen))       // Input for enqueue
    val deq = Decoupled(gen)               // Output for dequeue
    val count = Output(UInt(log2Ceil(entries + 1).W)) // Number of elements in the queue
    val flush = if (hasFlush) Some(Input(Bool())) else None  // Optional flush signal
  })

  // Task 1: Implement Memory Storage
  val ram = Mem(entries, gen)

  // Task 2: Pointer Management
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)

  val ptr_match = enq_ptr === deq_ptr

  // Task 3: Full/Empty Logic
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  io.enq.ready := !full
  io.deq.valid := !empty

  // Task 4: Enqueue Logic
  val do_enq = io.enq.valid && io.enq.ready
  when(do_enq) {
    ram.write(enq_ptr, io.enq.bits)                   // Write input data to RAM
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U) // Increment and wrap
    when(!io.deq.ready || !io.deq.valid) {
      maybe_full := true.B
    }
  }

  // Task 5: Dequeue Logic
  val do_deq = io.deq.ready && io.deq.valid
  io.deq.bits := ram.read(deq_ptr)                   // Read output data from RAM
  when(do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U) // Increment and wrap
    when(!io.enq.valid || !io.enq.ready) {
      maybe_full := false.B
    }
  }

  // Task 6: Flush Mechanism
  if (hasFlush) {
    when(io.flush.getOrElse(false.B)) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Task 7: Count Calculation
  if (isPow2(entries)) {
    io.count := Mux(maybe_full, entries.U, 0.U) + enq_ptr - deq_ptr
  } else {
    val diff = Mux(enq_ptr < deq_ptr, entries.U - deq_ptr + enq_ptr, enq_ptr - deq_ptr)
    io.count := Mux(ptr_match, Mux(maybe_full, entries.U, 0.U), diff)
  }
}

