import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue must have a positive number of entries")
  
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen)) // Input: enqueue interface
    val deq = Decoupled(gen)          // Output: dequeue interface
    val count = Output(UInt(log2Ceil(entries + 1).W)) // Current count of elements
    val flush = if (hasFlush) Some(Input(Bool())) else None // Optional flush input
  })

  // Task 1: Implement Memory Storage
  val ram = Mem(entries, gen)

  // Task 2: Pointer Management
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)
  val ptr_match = (enq_ptr === deq_ptr)

  // Task 3: Full/Empty Logic
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full
  io.enq.ready := !full
  io.deq.valid := !empty

  // Task 4: Enqueue Logic
  val do_enq = io.enq.valid && io.enq.ready
  when(do_enq) {
    ram.write(enq_ptr, io.enq.bits) // Write data to memory
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U) // Wrap-around
  }

  // Update maybe_full for enqueue when dequeue is not simultaneous
  when(do_enq && !io.deq.fire()) {
    maybe_full := true.B
  }

  // Task 5: Dequeue Logic
  val do_deq = io.deq.ready && io.deq.valid
  when(do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U) // Wrap-around
  }

  // Update maybe_full for dequeue when enqueue is not simultaneous
  when(do_deq && !do_enq) {
    maybe_full := false.B
  }

  // Task 6: Flush Mechanism (Conditional)
  if (hasFlush) {
    when(io.flush.getOrElse(false.B)) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Task 7: Count Calculation
  val count = Wire(UInt(log2Ceil(entries + 1).W))
  if (isPow2(entries)) {
    count := Mux(maybe_full, entries.U, enq_ptr - deq_ptr)
  } else {
    count := Mux(ptr_match, Mux(maybe_full, entries.U, 0.U),
      Mux(enq_ptr < deq_ptr, entries.U - deq_ptr + enq_ptr, enq_ptr - deq_ptr))
  }
  io.count := count

  // Output data for dequeue interface
  io.deq.bits := ram.read(deq_ptr)
}

