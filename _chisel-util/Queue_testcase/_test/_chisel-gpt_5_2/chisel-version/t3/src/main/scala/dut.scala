import chisel3._
import chisel3.util._

/** QueueIO compatible with the spec (Decoupled enq/deq, optional flush, plus count).
  */
class QueueIO[T <: Data](gen: T, entries: Int, hasFlush: Boolean) extends Bundle {
  val enq   = Flipped(Decoupled(gen))
  val deq   = Decoupled(gen)
  val count = Output(UInt(log2Ceil(entries + 1).W))
  val flush = if (hasFlush) Input(Bool()) else null

  override def cloneType: this.type = new QueueIO(gen, entries, hasFlush).asInstanceOf[this.type]
}

/** dut: a parametrizable synchronous FIFO queue.
  */
class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "entries must be a positive integer")

  val io = IO(new QueueIO(gen, entries, hasFlush))

  private val ptrWidth = log2Ceil(entries)

  // Storage
  val ram = Mem(entries, gen)

  // Pointer management
  val enq_ptr    = RegInit(0.U(ptrWidth.W))
  val deq_ptr    = RegInit(0.U(ptrWidth.W))
  val maybe_full = RegInit(false.B)

  val ptr_match = enq_ptr === deq_ptr
  val empty     = ptr_match && !maybe_full
  val full      = ptr_match && maybe_full

  // Handshake
  io.enq.ready := !full
  io.deq.valid := !empty

  // Synchronous read (registered output)
  // deq.bits must be valid whenever io.deq.valid is high (after a cycle for first data).
  val deq_data = Reg(gen.cloneType)
  when(!empty) {
    deq_data := ram.read(deq_ptr)
  }
  io.deq.bits := deq_data

  val do_enq = io.enq.fire
  val do_deq = io.deq.fire

  // Enqueue write
  when(do_enq) {
    ram.write(enq_ptr, io.enq.bits)
  }

  // Pointer increment with wrap
  def inc(ptr: UInt): UInt = Mux(ptr === (entries - 1).U, 0.U, ptr + 1.U)

  // Update pointers / maybe_full
  switch(Cat(do_enq, do_deq)) {
    is("b10".U) { // enq only
      enq_ptr := inc(enq_ptr)
      maybe_full := true.B
    }
    is("b01".U) { // deq only
      deq_ptr := inc(deq_ptr)
      maybe_full := false.B
    }
    is("b11".U) { // both
      enq_ptr := inc(enq_ptr)
      deq_ptr := inc(deq_ptr)
      // maybe_full unchanged when both happen
    }
  }

  // Flush mechanism
  if (hasFlush) {
    when(io.flush) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Count calculation
  // - If pointers match: count is 0 when empty, entries when full
  // - Else: circular difference, accounting for wrap
  val diff = Wire(UInt(log2Ceil(entries + 1).W))
  when(enq_ptr >= deq_ptr) {
    diff := (enq_ptr - deq_ptr).asUInt
  }.otherwise {
    diff := (enq_ptr + entries.U - deq_ptr).asUInt
  }

  io.count := Mux(ptr_match, Mux(maybe_full, entries.U, 0.U), diff)
}
