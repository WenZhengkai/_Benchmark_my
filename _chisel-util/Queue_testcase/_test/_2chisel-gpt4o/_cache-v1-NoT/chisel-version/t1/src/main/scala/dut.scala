import chisel3._
import chisel3.util._

class QueueIO[T <: Data](gen: T) extends Bundle {
  val enq = Flipped(Decoupled(gen))
  val deq = Decoupled(gen)
  val count = Output(UInt(32.W))
}

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  val io = IO(new QueueIO(gen))
  private val ioFlush = if (hasFlush) Some(Input(Bool())) else None
  if (hasFlush) {
    io.addElement(ioFlush.get, "flush")
  }

  // Task 1: Implement Memory for Storage
  val ram = Mem(entries, gen)

  // Task 2: Implement Pointer Management
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val ptr_match = enq_ptr === deq_ptr

  // Task 3: Implement Full/Empty Logic
  val maybe_full = RegInit(false.B)
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  // Task 4: Implement Data Enqueue Logic
  io.enq.ready := !full
  when(io.enq.fire()) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U)
    when(io.deq.fire()) {
      maybe_full := maybe_full
    } .otherwise {
      maybe_full := true.B
    }
  }

  // Task 5: Implement Data Dequeue Logic
  io.deq.valid := !empty
  io.deq.bits := DontCare
  when(io.deq.fire()) {
    io.deq.bits := ram(deq_ptr)
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U)
    when(io.enq.fire()) {
      maybe_full := maybe_full
    } .otherwise {
      maybe_full := false.B
    }
  }

  // Task 6: Implement Flush Mechanism
  if (hasFlush) {
    when(ioFlush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // Task 7: Calculate and Output Count
  val ptr_diff = enq_ptr - deq_ptr
  when(maybe_full) {
    io.count := (entries.U - ptr_diff) % entries.U
  } .otherwise {
    io.count := ptr_diff
  }
}


