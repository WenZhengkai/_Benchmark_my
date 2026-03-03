import chisel3._
import chisel3.util._

class QueueIO[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Bundle {
  val enq = Flipped(Decoupled(gen))
  val deq = Decoupled(gen)
  val count = Output(UInt(log2Ceil(entries + 1).W))
  val flush = if (hasFlush) Some(Input(Bool())) else None
  
  override def cloneType: this.type = new QueueIO(gen, entries, hasFlush).asInstanceOf[this.type]
}

class dut[T <: Data](gen: T, entries: Int, hasFlush: Boolean = false) extends Module {
  require(entries > 0, "Queue entries must be greater than 0")
  
  val io = IO(new QueueIO(gen, entries, hasFlush))
  
  // Memory for storage
  val ram = Mem(entries, gen)
  
  // Pointer management
  val enq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val deq_ptr = RegInit(0.U(log2Ceil(entries).W))
  val maybe_full = RegInit(false.B)
  
  // Pointer match condition
  val ptr_match = enq_ptr === deq_ptr
  
  // Full and empty logic
  val full = ptr_match && maybe_full
  val empty = ptr_match && !maybe_full
  
  // Enqueue and dequeue control signals
  val do_enq = WireDefault(io.enq.fire)
  val do_deq = WireDefault(io.deq.fire)
  
  // Handle flush if enabled
  val do_flush = if (hasFlush) io.flush.get else false.B
  
  when (do_flush) {
    enq_ptr := 0.U
    deq_ptr := 0.U
    maybe_full := false.B
  } .otherwise {
    // Enqueue operation
    when (do_enq) {
      ram(enq_ptr) := io.enq.bits
      enq_ptr := enq_ptr + 1.U
      when (enq_ptr === (entries - 1).U) {
        enq_ptr := 0.U
      }
    }
    
    // Dequeue operation
    when (do_deq) {
      deq_ptr := deq_ptr + 1.U
      when (deq_ptr === (entries - 1).U) {
        deq_ptr := 0.U
      }
    }
    
    // Update maybe_full
    when (do_enq =/= do_deq) {
      maybe_full := do_enq
    }
  }
  
  // IO connections
  io.enq.ready := !full || do_flush
  io.deq.valid := !empty && !do_flush
  io.deq.bits := ram(deq_ptr)
  
  // Count calculation
  val count = Wire(UInt(log2Ceil(entries + 1).W))
  val ptr_diff = enq_ptr - deq_ptr
  
  when (ptr_match) {
    count := Mux(maybe_full, entries.U, 0.U)
  } .elsewhen (enq_ptr > deq_ptr) {
    count := ptr_diff
  } .otherwise {
    count := entries.U + ptr_diff
  }
  
  // Handle flush effect on count
  io.count := Mux(do_flush, 0.U, count)
}

/*
object dut extends App {
  println("Generating dut Verilog")
  (new chisel3.stage.ChiselStage).emitVerilog(
    new dut(UInt(8.W), 4, hasFlush = true),
    Array("--target-dir", "generated")
  )
}
*/
