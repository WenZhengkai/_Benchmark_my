import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Number of entries must be greater than 0")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen)) // Input for enqueue
    val deq = Decoupled(gen)          // Output for dequeue
    val count = Output(UInt(log2Ceil(entries + 1).W)) // Current count of elements
    val flush = if (hasFlush) Some(Input(Bool())) else None // Optional flush signal
  })

  // Task 1: Memory Storage
  val ram = Mem(entries, gen)

  // Task 2: Pointer Management
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W)) // Enqueue pointer
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W)) // Dequeue pointer
  val maybe_full = RegInit(false.B)               // Full/empty status

  val ptr_match = enq_ptr === deq_ptr // Pointer equality for full/empty detection

  // Task 3: Full/Empty Logic
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  io.enq.ready := !full
  io.deq.valid := !empty

  // Task 4: Enqueue Logic
  val do_enq = io.enq.valid && io.enq.ready
  when (do_enq) {
    ram(enq_ptr) := io.enq.bits         // Write data to memory
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U) // Increment pointer
  }

  // Task 5: Dequeue Logic
  val do_deq = io.deq.ready && io.deq.valid
  when (do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U) // Increment pointer
  }

  // Update maybe_full based on enqueue and dequeue
  when (do_enq =/= do_deq) {
    maybe_full := do_enq
  }

  // Task 6: Flush Mechanism
  if (hasFlush) {
    when (io.flush.getOrElse(false.B)) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Task 7: Count Calculation
  val count = Wire(UInt(log2Ceil(entries + 1).W))
  when (ptr_match) {
    count := Mux(maybe_full, entries.U, 0.U)
  }.elsewhen(enq_ptr > deq_ptr) {
    count := enq_ptr - deq_ptr
  }.otherwise {
    count := entries.U - deq_ptr + enq_ptr
  }
  io.count := count

  // Dequeue output logic
  io.deq.bits := ram(deq_ptr)
}
