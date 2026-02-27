// package arbiter

import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))  // 3 request input signals
    val g = Output(UInt(3.W)) // 3 grant output signals
  })
  
  // Define the state constants
  val sA :: sB :: sC :: sD :: Nil = Enum(4)
  
  // State register
  val state = RegInit(sA)
  
  // Default output values
  io.g := 0.U
  
  // Extract individual request signals for clarity
  val r0 = io.r(0)
  val r1 = io.r(1)
  val r2 = io.r(2)
  
  // State transition logic
  switch (state) {
    is (sA) {
      // State A transitions based on request signals with priority
      when (r0) {
        state := sB  // Device 0 has highest priority
      } .elsewhen (r1) {
        state := sC  // Device 1 has medium priority
      } .elsewhen (r2) {
        state := sD  // Device 2 has lowest priority
      } .otherwise {
        state := sA  // Stay in A if no requests
      }
    }
    
    is (sB) {
      // In state B, grant access to device 0
      io.g := "b001".U  // g0 = 1
      
      when (r0) {
        state := sB  // Stay in B as long as r0 is active
      } .otherwise {
        state := sA  // Return to A when r0 becomes inactive
      }
    }
    
    is (sC) {
      // In state C, grant access to device 1
      io.g := "b010".U  // g1 = 1
      
      when (r1) {
        state := sC  // Stay in C as long as r1 is active
      } .otherwise {
        state := sA  // Return to A when r1 becomes inactive
      }
    }
    
    is (sD) {
      // In state D, grant access to device 2
      io.g := "b100".U  // g2 = 1
      
      when (r2) {
        state := sD  // Stay in D as long as r2 is active
      } .otherwise {
        state := sA  // Return to A when r2 becomes inactive
      }
    }
  }
}
