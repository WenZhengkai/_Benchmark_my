import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "entries must be > 0")

  val io = IO(new QueueIO(gen, entries, hasFlush))

  // Storage
  val ram = Mem(entries, gen)

  // Pointer width (at least 1 bit)
  private val ptrWidth = math.max(1, log2Ceil(entries))
  val enq_ptr    = RegInit(0.U(ptrWidth.W))
  val deq_ptr    = RegInit(0.U(ptrWidth.W))
  val maybe_full = RegInit(false.B)

  val ptr_match = enq_ptr === deq_ptr
  val full      = ptr_match && maybe_full
  val empty     = ptr_match && !maybe_full

  io.enq.ready := !full
  io.deq.valid := !empty

  // Read data at dequeue pointer (combinational read from Mem)
  io.deq.bits := ram(deq_ptr)

  val do_enq = io.enq.fire
  val do_deq = io.deq.fire

  // Pointer increment with wrap
  def inc(ptr: UInt): UInt = Mux(ptr === (entries - 1).U, 0.U, ptr + 1.U)

  when(do_enq) {
    ram.write(enq_ptr, io.enq.bits)
    enq_ptr := inc(enq_ptr)
  }
  when(do_deq) {
    deq_ptr := inc(deq_ptr)
  }
  when(do_enq =/= do_deq) {
    maybe_full := do_enq
  }

  // Optional flush
  if (hasFlush) {
    when(io.flush) {
      enq_ptr    := 0.U
      deq_ptr    := 0.U
      maybe_full := false.B
    }
  }

  // Count calculation
  // Computes occupancy in [0..entries], accounting for circular pointers.
  val countWidth = log2Ceil(entries + 1)
  val diff =
    Mux(enq_ptr >= deq_ptr, enq_ptr - deq_ptr, (enq_ptr + entries.U) - deq_ptr)

  val count = Wire(UInt(countWidth.W))
  when(full) {
    count := entries.U
  }.elsewhen(empty) {
    count := 0.U
  }.otherwise {
    count := diff
  }

  io.count := count
}
