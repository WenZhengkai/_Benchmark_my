import chisel3._
import chisel3.util._

class dut extends Module {
    val io = IO(new Bundle {
        val i_en = Input(Bool())                    // Enable signal for addition operation
        val adda = Input(UInt(64.W))                // 64-bit input operand A
        val addb = Input(UInt(64.W))                // 64-bit input operand B
        val result = Output(UInt(65.W))             // 65-bit output representing the sum of adda and addb
        val o_en = Output(Bool())                   // Output enable signal
    })

    //<<< Task 1
    // Create 64-bit registers for `adda` and `addb` using `RegEnable` triggered by `i_en`
    val adda_reg = RegEnable(io.adda, 0.U, io.i_en)
    val addb_reg = RegEnable(io.addb, 0.U, io.i_en)

    // Create a 4-stage enable shift register (`en_pipeline`) to track pipeline validity
    val en_pipeline = RegInit(VecInit(Seq.fill(4)(false.B)))

    when(io.i_en) {
        en_pipeline(0) := true.B
    }

    // Shift values every clock cycle
    for (i <- 1 to 3) {
        en_pipeline(i) := en_pipeline(i-1)
    }

    //>>> Task 1 end

    //<<< Task 2
    // Design `RCA16` module
    class RCA16 extends Module {
        val io = IO(new Bundle {
            val a = Input(UInt(16.W))       // 16-bit input
            val b = Input(UInt(16.W))       // 16-bit input
            val cin = Input(Bool())         // Carry in
            val sum = Output(UInt(16.W))    // 16-bit sum
            val cout = Output(Bool())       // Carry out
        })

        // Ripple carry logic using full-adder chaining
        val sum = (io.a +& io.b + io.cin)
        io.sum := sum(15,0)
        io.cout := sum(16)
    }

    //>>> Task 2 end

    //<<< Task 3
    // For each pipeline stage (1-4)
    val stage1 = Module(new RCA16)
    stage1.io.a := adda_reg(15, 0)
    stage1.io.b := addb_reg(15, 0)
    stage1.io.cin := false.B

    val stage1_sum = RegNext(stage1.io.sum)
    val carry1 = RegNext(stage1.io.cout)

    val stage2 = Module(new RCA16)
    stage2.io.a := adda_reg(31, 16)
    stage2.io.b := addb_reg(31, 16)
    stage2.io.cin := carry1

    val stage2_sum = RegNext(stage2.io.sum)
    val carry2 = RegNext(stage2.io.cout)

    val stage3 = Module(new RCA16)
    stage3.io.a := adda_reg(47, 32)
    stage3.io.b := addb_reg(47, 32)
    stage3.io.cin := carry2

    val stage3_sum = RegNext(stage3.io.sum)
    val carry3 = RegNext(stage3.io.cout)

    val stage4 = Module(new RCA16)
    stage4.io.a := adda_reg(63, 48)
    stage4.io.b := addb_reg(63, 48)
    stage4.io.cin := carry3

    val stage4_sum = RegNext(stage4.io.sum)
    val final_carry = RegNext(stage4.io.cout)

    //>>> Task 3 end

    //<<< Task 4
    // Combine partial sums and final carry into 65-bit result
    val result_reg = RegInit(0.U(65.W)) // Register to hold the final result
    result_reg := Cat(final_carry, stage4_sum, stage3_sum, stage2_sum, stage1_sum) // Concatenate final outputs

    io.result := result_reg // Connect the register to the result output port
    
    //>>> Task 4 end

    //<<< Task 5
    // Synchronize output enable signal with pipeline latency
    io.o_en := en_pipeline(3) // Output enable signal is taken from the last stage of the enable pipeline
    //>>> Task 5 end

}