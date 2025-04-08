import chisel3._
import chisel3.util._

class dut[T <: Data](
  gen: T,
  entries: Int,
  hasFlush: Boolean = false
) extends Module {
  require(entries > 0, "Queue entries must be a positive integer")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen)) // Enqueue interface
    val deq = Decoupled(gen)         // Dequeue interface
    val count = Output(UInt(log2Ceil(entries + 1).W)) // Number of elements in the queue
    val flush = if (hasFlush) Some(Input(Bool())) else None // Optional flush input
  })

  // Task 1: Implement memory storage
  val ram = Mem(entries, gen)

  // Task 2: Pointer management
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)
  val ptr_match = enq_ptr === deq_ptr

  // Task 3: Full/Empty logic
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full
  io.enq.ready := !full
  io.deq.valid := !empty

  // Task 4: Enqueue logic
  val do_enq = io.enq.valid && io.enq.ready
  when(do_enq) {
    ram(enq_ptr) := io.enq.bits // Write data to ram
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U) // Wrap pointer
  }

  // Update maybe_full
  when(do_enq) {
    when(!io.deq.ready || !io.deq.valid) {
      maybe_full := true.B
    }
  }

  // Task 5: Dequeue logic
  val do_deq = io.deq.ready && io.deq.valid
  when(do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U) // Wrap pointer
  }

  // Reset maybe_full when dequeuing without simultaneous enqueue
  when(do_deq) {
    when(!io.enq.valid || !io.enq.ready) {
      maybe_full := false.B
    }
  }

  // Task 6: Flush mechanism (conditional)
  if (hasFlush) {
    when(io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Task 7: Count calculation
  if (isPow2(entries)) {
    io.count := Mux(maybe_full, enq_ptr - deq_ptr + entries.U, enq_ptr - deq_ptr)
  } else {
    io.count := Mux(
      ptr_match,
      Mux(maybe_full, entries.U, 0.U),
      Mux(enq_ptr < deq_ptr, entries.U + enq_ptr - deq_ptr, enq_ptr - deq_ptr)
    )
  }

  // Assign dequeue output
  io.deq.bits := ram(deq_ptr)
}

object QueueMy extends App {
  // Generate the Verilog for the QueueMy module with example parameters
  chisel3.Driver.execute(args, () => new QueueMy(UInt(8.W), entries = 4, hasFlush = true))
}
