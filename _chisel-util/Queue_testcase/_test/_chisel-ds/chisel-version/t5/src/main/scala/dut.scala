import chisel3._
import chisel3.util._

class QueueIO[T <: Data](gen: T, entries: Int, hasFlush: Boolean) extends Bundle {
  val enq = Flipped(Decoupled(gen))
  val deq = Decoupled(gen)
  val count = Output(UInt(log2Ceil(entries + 1).W))
  val flush = if (hasFlush) Some(Input(Bool())) else None
}

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  val io = IO(new QueueIO(gen, entries, hasFlush))

  // Memory for storage
  val ram = Mem(entries, gen)

  // Pointers for enqueue and dequeue
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)

  // Pointer match logic
  val ptr_match = enq_ptr === deq_ptr

  // Full and empty logic
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  // Enqueue logic
  val do_enq = io.enq.ready && io.enq.valid
  when (do_enq) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U)
    maybe_full := true.B
  }

  // Dequeue logic
  val do_deq = io.deq.ready && io.deq.valid
  when (do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U)
    maybe_full := false.B
  }

  // Flush logic
  if (hasFlush) {
    when (io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Count calculation
  val count = Mux(ptr_match,
    Mux(maybe_full, entries.U, 0.U),
    Mux(enq_ptr > deq_ptr, enq_ptr - deq_ptr, entries.U - deq_ptr + enq_ptr)
  )

  // Output assignments
  io.enq.ready := !full
  io.deq.valid := !empty
  io.deq.bits := ram(deq_ptr)
  io.count := count
}

// Example usage
/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut(UInt(8.W), 16, hasFlush = true))
}
*/
