import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Task 1: Set Up Registers and Wires
  // Register to track if the module is ready to accept new data
  val ready_r = RegInit(true.B)
  // Register to track occupancy status
  val occupied = RegInit(false.B)
  // Register to store incoming data
  val hold = Reg(data.cloneType)
  // Wires for combinational logic control
  val load = Wire(Bool())
  val drain = Wire(Bool())

  // Task 2: Implement Data Forwarding Logic
  // Logic for determining when to drain data
  drain := occupied && io.deq.ready
  // Logic for determining when to load data
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Task 3: Implement Data Handling Logic
  // Determine what data to output
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  // Determine if output is valid
  io.deq.valid := io.enq.valid || occupied

  // Task 4: Implement Control Logic
  when(load) {
    // Update hold with new data
    hold := io.enq.bits
    // Indicate that the module is occupied
    occupied := true.B
  } .elsewhen(drain) {
    // Clear occupancy when data is drained
    occupied := false.B
  }

  // Update ready_r based on occupancy and load/drain conditions
  ready_r := !load && (!occupied || drain)

  // Connect ready signal for input interface
  io.enq.ready := ready_r
}

