import chisel3._
import chisel3.util._

/** Queue-like IO with optional flush and count.
  * - enq: Decoupled producer
  * - deq: Decoupled consumer
  * - count: current occupancy (0..entries)
  * - flush: when present, clears the queue
  */
class QueueIO[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Bundle {
  require(entries > 0, "entries must be > 0")

  val enq   = Flipped(Decoupled(gen))
  val deq   = Decoupled(gen)
  val count = Output(UInt(log2Ceil(entries + 1).W))

  // Optional flush port
  val flush = if (hasFlush) Input(Bool()) else null

  override def cloneType: this.type =
    new QueueIO(gen, entries, hasFlush).asInstanceOf[this.type]
}

/** dut: a parameterized FIFO queue with optional flush.
  *
  * Implements a circular buffer using:
  * - ram: Mem(entries) for storage
  * - enq_ptr/deq_ptr: circular pointers
  * - maybe_full: disambiguates full vs empty when pointers match
  */
class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "entries must be > 0")

  val io = IO(new QueueIO(gen, entries, hasFlush))

  // Storage
  val ram = Mem(entries, gen)

  // Pointer management
  private val ptrW    = log2Ceil(entries)
  private val enq_ptr = RegInit(0.U(ptrW.W))
  private val deq_ptr = RegInit(0.U(ptrW.W))
  private val maybe_full = RegInit(false.B)

  private val ptr_match = enq_ptr === deq_ptr
  private val empty     = ptr_match && !maybe_full
  private val full      = ptr_match &&  maybe_full

  // Handshake logic
  io.enq.ready := !full
  io.deq.valid := !empty

  // Read data (combinational read of Mem is OK for this spec)
  io.deq.bits := ram.read(deq_ptr)

  val do_enq = io.enq.fire
  val do_deq = io.deq.fire

  // Pointer increment helper
  private def inc(ptr: UInt): UInt = Mux(ptr === (entries - 1).U, 0.U, ptr + 1.U)

  // Updates (enqueue/dequeue)
  when(do_enq) {
    ram.write(enq_ptr, io.enq.bits)
    enq_ptr := inc(enq_ptr)
  }
  when(do_deq) {
    deq_ptr := inc(deq_ptr)
  }

  // maybe_full update
  when(do_enq =/= do_deq) {
    maybe_full := do_enq
  }

  // Flush mechanism
  if (hasFlush) {
    when(io.flush) {
      enq_ptr    := 0.U
      deq_ptr    := 0.U
      maybe_full := false.B
    }
  }

  // Count calculation
  private val enq_deq_same = ptr_match
  private val diff = enq_ptr - deq_ptr // wraps naturally in UInt arithmetic

  val count = Wire(UInt(log2Ceil(entries + 1).W))
  when(enq_deq_same) {
    count := Mux(maybe_full, entries.U, 0.U)
  }.otherwise {
    // Circular buffer distance
    count := Mux(enq_ptr > deq_ptr, diff, (entries.U - (deq_ptr - enq_ptr)))
  }
  io.count := count
}
