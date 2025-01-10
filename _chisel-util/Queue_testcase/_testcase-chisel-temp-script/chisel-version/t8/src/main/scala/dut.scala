import chisel3._
import chisel3.util._

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue entries must be a positive number")

  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen))   // Enqueue interface: valid/ready handshake with input data
    val deq = Decoupled(gen)           // Dequeue interface: valid/ready handshake with output data
    val count = Output(UInt(log2Ceil(entries + 1).W)) // Current number of elements in the queue
    val flush = if (hasFlush) Some(Input(Bool())) else None // Optional flush support
  })

  // Internal storage: circular buffer
  val ram = Mem(entries, gen)

  // Pointers for enqueue (enq_ptr) and dequeue (deq_ptr)
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W)) // Points to the next writing position
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W)) // Points to the next reading position

  // Maybe full flag: indicates whether the queue is full when `enq_ptr` == `deq_ptr`
  val maybe_full = RegInit(false.B)

  // Pointer match indicates `enq_ptr` == `deq_ptr`
  val ptr_match = enq_ptr === deq_ptr

  // Full and empty conditions
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full

  // Enqueue logic
  val do_enq = io.enq.valid && io.enq.ready
  when(do_enq) {
    ram.write(enq_ptr, io.enq.bits)        // Write data to memory
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U) // Wrap around if needed
  }

  // Dequeue logic
  val do_deq = io.deq.valid && io.deq.ready
  when(do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U) // Wrap around if needed
  }

  // Update maybe_full on enqueue and dequeue
  when(do_enq =/= do_deq) {
    maybe_full := do_enq   // If enqueueing but not dequeueing, set maybe_full to true
  }

  // Flush logic (optional)
  if (hasFlush) {
    when(io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }

  // io.enq.ready: Queue can accept new data if it’s not full
  io.enq.ready := !full

  // io.deq.valid: Queue has valid data for dequeue if it’s not empty
  io.deq.valid := !empty
  io.deq.bits := ram.read(deq_ptr) // Provide data from memory at deq_ptr

  // Current count of elements in the queue
  io.count := Mux(
    ptr_match,
    Mux(maybe_full, entries.U, 0.U), // Full: `entries`, Empty: `0`
    Mux(deq_ptr > enq_ptr, entries.U + enq_ptr - deq_ptr, enq_ptr - deq_ptr)
  )
}
