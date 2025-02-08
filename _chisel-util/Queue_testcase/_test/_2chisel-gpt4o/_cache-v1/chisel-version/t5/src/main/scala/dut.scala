import chisel3._
import chisel3.util._

class QueueIO[T <: Data](gen: T, entries: Int, hasFlush: Boolean) extends Bundle {
  val enq   = Flipped(Decoupled(gen))
  val deq   = Decoupled(gen)
  val count = Output(UInt(log2Ceil(entries + 1).W))
  val full  = Output(Bool())
  val empty = Output(Bool())
  val flush = if (hasFlush) Some(Input(Bool())) else None
}

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue must have a positive number of entries")

  val io = IO(new QueueIO(gen, entries, hasFlush))

  val ram = Mem(entries, gen)
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)

  val ptr_match = enq_ptr === deq_ptr
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  io.full := full
  io.empty := empty

  val do_enq = io.enq.valid && !full
  val do_deq = io.deq.ready && !empty

  when (do_enq) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := WrapAroundCounter(enq_ptr + 1.U, entries)
    when (do_deq && full) {
      maybe_full := false.B
    }.otherwise {
      maybe_full := true.B
    }
  }

  when (do_deq) {
    deq_ptr := WrapAroundCounter(deq_ptr + 1.U, entries)
    when (do_deq && empty) {
      maybe_full := false.B
    }.otherwise {
      maybe_full := false.B
    }
  }

  io.enq.ready := !full
  io.deq.valid := !empty
  io.deq.bits  := ram(deq_ptr)

  if(hasFlush) {
    when (io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Count calculation
  val ptr_diff = enq_ptr - deq_ptr
  io.count := Mux(full, entries.U, Mux(empty, 0.U, Mux(ptr_diff < 0.U, entries.U + ptr_diff, ptr_diff)))
}

// Utility function for wrap-around counter logic
private def WrapAroundCounter(value: UInt, max: Int) = {
  val result = Wire(value.cloneType)
  result := Mux(value >= max.U, 0.U, value)
  result
}
