import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Internal Registers and Wires
  val ready_r = RegInit(true.B) // Indicates if the module can accept new data
  val occupied = RegInit(false.B) // Indicates if the module holds unsent data
  val hold = Reg(data.cloneType) // Register to temporarily hold data

  // Combinational Wires
  val drain = Wire(Bool()) // Determines if data should be outputted
  val load = Wire(Bool()) // Determines if new data should be loaded

  // Data Forwarding Logic
  drain := occupied && io.deq.ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Data Handling Logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := occupied || io.enq.valid

  // Control Logic
  when(load) {
    hold := io.enq.bits
    occupied := true.B
  }
  when(drain) {
    occupied := false.B
  }

  // Update ready_r based on conditions
  ready_r := !occupied || drain
}

// Companion object for instantiation
object dut {
  def apply[D <: Data](data: D): dut[D] = new dut(data)
}
