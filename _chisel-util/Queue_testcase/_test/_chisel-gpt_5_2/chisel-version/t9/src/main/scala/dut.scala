import chisel3._
import chisel3.util._

/** FIFO queue with optional flush, compatible with chisel3.util.QueueIO.
  *
  * @param gen       element type
  * @param entries   depth (> 0)
  * @param hasFlush  include io.flush when true
  */
class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "entries must be a positive integer")

  val io = IO(new QueueIO(gen, entries, hasFlush))

  // Storage
  val ram = Mem(entries, gen)

  // Pointer width (at least 1 bit)
  private val ptrBits = log2Ceil(entries)

  // Pointers + full/empty disambiguator
  val enq_ptr    = RegInit(0.U(ptrBits.W))
  val deq_ptr    = RegInit(0.U(ptrBits.W))
  val maybe_full = RegInit(false.B)

  val ptr_match = enq_ptr === deq_ptr
  val empty     = ptr_match && !maybe_full
  val full      = ptr_match && maybe_full

  // Handshakes
  val do_enq = io.enq.fire
  val do_deq = io.deq.fire

  io.enq.ready := !full
  io.deq.valid := !empty

  // Read data (combinational read from Mem; matches the classic Queue implementation)
  io.deq.bits := ram(deq_ptr)

  // Pointer increment with wrap
  private def inc(ptr: UInt): UInt = Mux(ptr === (entries - 1).U, 0.U, ptr + 1.U)

  // Enqueue write + advance
  when(do_enq) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := inc(enq_ptr)
  }

  // Dequeue advance
  when(do_deq) {
    deq_ptr := inc(deq_ptr)
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

  // Count calculation (occupancy)
  // Note: count width is log2Ceil(entries+1) to represent 0..entries
  val countBits = log2Ceil(entries + 1)
  val diff = enq_ptr - deq_ptr

  val ptrWidthIsPow2 = isPow2(entries)
  val count = Wire(UInt(countBits.W))

  when(ptr_match) {
    count := Mux(maybe_full, entries.U, 0.U)
  }.otherwise {
    if (ptrWidthIsPow2) {
      // modulo arithmetic already works when entries is power of 2
      count := diff
    } else {
      // handle wrap explicitly for non-power-of-2 depths
      count := Mux(enq_ptr > deq_ptr, diff, (entries.U - deq_ptr) + enq_ptr)
    }
  }

  io.count := count
}
