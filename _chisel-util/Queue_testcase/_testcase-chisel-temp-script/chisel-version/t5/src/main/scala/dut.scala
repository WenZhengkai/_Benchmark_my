// package fifo

import chisel3._
import chisel3.util._

class QueueIO[T <: Data](val gen: T, val entries: Int, val hasFlush: Boolean = false) extends Bundle {
  val enq = Flipped(DecoupledIO(gen.cloneType))
  val deq = DecoupledIO(gen.cloneType)
  val count = Output(UInt(log2Ceil(entries + 1).W))
  
  val flush = if (hasFlush) Some(Input(Bool())) else None
}

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue entries must be greater than zero")
  
  val io = IO(new QueueIO(gen, entries, hasFlush))
  
  // Storage for queue elements
  val ram = Mem(entries, gen)
  
  // Pointers for enqueue and dequeue operations
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)
  
  val ptr_match = enq_ptr === deq_ptr
  val empty = ptr_match && !maybe_full
  val full = ptr_match && maybe_full
  
  // Connect ready/valid signals
  io.deq.valid := !empty
  io.enq.ready := !full
  
  // Enqueue and dequeue flags
  val do_enq = io.enq.fire()
  val do_deq = io.deq.fire()
  
  // Enqueue operation
  when (do_enq) {
    ram(enq_ptr) := io.enq.bits
    enq_ptr := Mux(enq_ptr === (entries - 1).U, 0.U, enq_ptr + 1.U)
  }
  
  // Dequeue operation
  when (do_deq) {
    deq_ptr := Mux(deq_ptr === (entries - 1).U, 0.U, deq_ptr + 1.U)
  }
  
  // Set maybe_full flag based on operations
  when (do_enq =/= do_deq) {
    maybe_full := do_enq
  }
  
  // Flush operation if supported
  if (hasFlush) {
    when (io.flush.get) {
      enq_ptr := 0.U
      deq_ptr := 0.U
      maybe_full := false.B
    }
  }
  
  // Connect dequeue data
  io.deq.bits := ram(deq_ptr)
  
  // Calculate and output the number of elements in the queue
  if (isPow2(entries)) {
    val ptr_diff = enq_ptr - deq_ptr
    when (ptr_match) {
      io.count := Mux(maybe_full, entries.U, 0.U)
    }.otherwise {
      io.count := Mux(enq_ptr > deq_ptr, ptr_diff, entries.U + ptr_diff)
    }
  } else {
    val ptr_diff = enq_ptr - deq_ptr
    val reverse_ptr_diff = deq_ptr - enq_ptr
    when (ptr_match) {
      io.count := Mux(maybe_full, entries.U, 0.U)
    }.elsewhen (enq_ptr > deq_ptr) {
      io.count := ptr_diff
    }.otherwise {
      io.count := entries.U - reverse_ptr_diff
    }
  }
}
