import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, val entries: Int, val hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue must have positive depth")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen))
    val deq = Decoupled(gen)
    val count = Output(UInt(log2Ceil(entries + 1).W))
    val flush = if (hasFlush) Some(Input(Bool())) else None
  })

  // Task 1: Implement `ram`
  val ram = Mem(entries, gen)

  // Task 2: Implement Pointer Management
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))

  // Wraparound logic
  val enq_ptr_next = WireDefault(enq_ptr + 1.U)
  val deq_ptr_next = WireDefault(deq_ptr + 1.U)

  enq_ptr_next := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U)
  deq_ptr_next := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U)

  val ptr_match = enq_ptr === deq_ptr

  // Task 3: Implement Full/Empty Logic
  val maybe_full = RegInit(false.B)
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  // Task 4: Implement Data Enqueue Logic
  val do_enq = io.enq.valid && !full

  when(do_enq) {
    ram.write(enq_ptr, io.enq.bits)
    enq_ptr := enq_ptr_next
    when(pointer_match) {
      maybe_full := true.B
    }
  }

  // Task 5: Implement Data Dequeue Logic
  val do_deq = io.deq.ready && !empty

  io.deq.valid := !empty
  io.deq.bits := ram.read(deq_ptr)

  when(do_deq) {
    deq_ptr := deq_ptr_next
    when(pointer_match) {
      maybe_full := false.B
    }
  }

  // Task 6: Implement Flush Mechanism (Optional Feature)
  if (hasFlush) {
    when(io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Task 7: Implement Count Calculation Logic
  when(enq_ptr >= deq_ptr) {
    io.count := enq_ptr - deq_ptr
  }.otherwise {
    io.count := (entries.U - deq_ptr) + enq_ptr
  }

  // Task 8: Implement Module Interface and Signals
  io.enq.ready := !full

  // Task 9: Integrate and Handle Corner Cases
  // The design handles edge cases automatically:
  // - Attempts to enqueue when full will block enqueue
  // - Attempts to dequeue when empty will block dequeue
  // - Correct as `entries` is not a power of two due to pointer wraparound management

}

