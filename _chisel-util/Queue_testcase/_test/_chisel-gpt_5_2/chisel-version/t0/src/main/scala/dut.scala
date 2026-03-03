import chisel3._
import chisel3.util._

/** FIFO dut */
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

  // Helpers
  val ptr_match = enq_ptr === deq_ptr
  val full      = ptr_match && maybe_full
  val empty     = ptr_match && !maybe_full

  // Handshake
  io.enq.ready := !full
  io.deq.valid := !empty

  val do_enq = io.enq.fire
  val do_deq = io.deq.fire

  // Read data (combinational read of Mem; fine for modeling / FPGA LUTRAM style)
  io.deq.bits := ram.read(deq_ptr)

  // Pointer increment with wrap
  def wrapInc(ptr: UInt): UInt = Mux(ptr === (entries - 1).U, 0.U, ptr + 1.U)

  // Enqueue write
  when(do_enq) {
    ram.write(enq_ptr, io.enq.bits)
    enq_ptr := wrapInc(enq_ptr)
  }

  // Dequeue advance
  when(do_deq) {
    deq_ptr := wrapInc(deq_ptr)
  }

  // maybe_full update
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

  // Count calculation (works for any entries; power-of-2 optimized not required)
  val countWidth = log2Ceil(entries + 1)
  val count = Wire(UInt(countWidth.W))

  when(ptr_match) {
    count := Mux(maybe_full, entries.U, 0.U)
  }.otherwise {
    // circular distance deq_ptr -> enq_ptr
    when(enq_ptr > deq_ptr) {
      count := enq_ptr - deq_ptr
    }.otherwise {
      count := (entries.U - deq_ptr) + enq_ptr
    }
  }

  io.count := count
}
