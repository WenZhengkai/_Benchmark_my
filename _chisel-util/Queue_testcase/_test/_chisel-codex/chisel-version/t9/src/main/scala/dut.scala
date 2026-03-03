import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, s"`entries` must be > 0, got $entries")

  val io = IO(new QueueIO(gen, entries, hasFlush))

  private val ptrWidth = math.max(1, log2Ceil(entries))

  val ram       = Mem(entries, gen)
  val enq_ptr   = RegInit(0.U(ptrWidth.W))
  val deq_ptr   = RegInit(0.U(ptrWidth.W))
  val maybeFull = RegInit(false.B)

  private def incWrap(ptr: UInt): UInt = {
    if (entries == 1) 0.U
    else Mux(ptr === (entries - 1).U, 0.U, ptr + 1.U)
  }

  val ptrMatch = enq_ptr === deq_ptr
  val empty    = ptrMatch && !maybeFull
  val full     = ptrMatch && maybeFull

  io.enq.ready := !full
  io.deq.valid := !empty
  io.deq.bits  := ram(deq_ptr)

  val do_enq = io.enq.valid && io.enq.ready
  val do_deq = io.deq.ready && io.deq.valid

  when(do_enq) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := incWrap(enq_ptr)
  }

  when(do_deq) {
    deq_ptr := incWrap(deq_ptr)
  }

  when(do_enq =/= do_deq) {
    maybeFull := do_enq
  }

  if (hasFlush) {
    when(io.flush.get) {
      enq_ptr   := 0.U
      deq_ptr   := 0.U
      maybeFull := false.B
    }
  }

  val cntWidth = log2Ceil(entries + 1)
  val countWire = Wire(UInt(cntWidth.W))

  val wrappedDistance = (entries.U(cntWidth.W) - deq_ptr.zext.asUInt)(cntWidth - 1, 0) + enq_ptr
  val linearDistance  = enq_ptr - deq_ptr

  when(ptrMatch) {
    countWire := Mux(maybeFull, entries.U, 0.U)
  }.elsewhen(deq_ptr > enq_ptr) {
    countWire := wrappedDistance
  }.otherwise {
    countWire := linearDistance
  }

  io.count := countWire
}
