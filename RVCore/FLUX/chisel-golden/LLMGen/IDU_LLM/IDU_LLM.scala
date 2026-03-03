Below is the complete Chisel code for the IDU (Instruction Decode Unit) module based on your detailed description.

```scala
package npc

import chisel3._
import chisel3.util._

class IDU(implicit val p: HasNPCParameter) extends NPCModule {
  import Instructions._

  // Input/output interface definition
  val io = IO(new NPCBundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow)) // Decoupled interface from IFU
    val to_isu = Decoupled(new DecodeIO)           // Decoupled interface to ISU
  })

  // -------------------------------------
  // Task 1: Handshake Processing
  val AnyInvalidCondition = false.B
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)

  // -------------------------------------
  // Task 2: Instruction Decoding
  val inst = io.from_ifu.bits.inst
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil =
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  // -------------------------------------
  // Task 3: Control Signal Generation
  val ctrl = Wire(new CtrlSignal)

  ctrl.rfWen := isRegWrite(instType)              // Determine register write enable
  ctrl.rs1 := inst(19, 15)                        // Extract rs1
  ctrl.rs2 := inst(24, 20)                        // Extract rs2
  ctrl.rd := inst(11, 7)                          // Extract rd
  ctrl.MemWrite := (instType === TYPE_S)          // MemWrite for S type instructions
  ctrl.ResSrc := MuxCase(0.U, Array(
    (inst(6, 0) === "b0000011".U) -> 1.U,         // Load instructions
    (inst(6, 0) === "b1110011".U) -> 2.U          // CSR instructions
  ))
  ctrl.fuSrc1Type := fuSrc1Type                   // Functional unit source 1 type
  ctrl.fuSrc2Type := fuSrc2Type                   // Functional unit source 2 type
  ctrl.fuType := fuType                           // Functional unit type
  ctrl.fuOpType := fuOpType                       // Functional unit operation type

  // -------------------------------------
  // Task 4: Immediate Extension
  val imm = Wire(UInt(XLen.W))
  imm := MuxCase(0.U, Array(
    (instType === TYPE_I) -> SignExt(inst(31, 20), XLen), // I type
    (instType === TYPE_U) -> SignExt(Cat(inst(31, 12), Fill(12, 0.U)), XLen), // U type
    (instType === TYPE_J) -> SignExt(Cat(inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U), XLen), // J type
    (instType === TYPE_S) -> SignExt(Cat(inst(31, 25), inst(11, 7)), XLen), // S type
    (instType === TYPE_B) -> SignExt(Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U), XLen)  // B type
  ))

  // -------------------------------------
  // Task 5: Data Source Preparation
  val data = Wire(new DataSrc)
  data := DontCare
  data.imm := imm                                 // Assign immediate value
  data.rfSrc1 := DontCare                         // Default values for data sources
  data.rfSrc2 := DontCare

  // -------------------------------------
  // Task 6: Output Signal Connection
  io.to_isu.bits.cf := io.from_ifu.bits.cf        // Copy control flow information
  io.to_isu.bits.ctrl := ctrl                     // Connect control signals
  io.to_isu.bits.data := data                     // Connect data signals
}
```

### Additional Considerations:
1. **`HandShakeDeal` Function**: This function needs to be defined elsewhere and implements the ready/valid handshake logic. Ensure it is properly defined.
2. **Instruction Decoding Table (`Instructions.DecodeTable`)**: This should include all RISC-V instructions with their mappings to `instType`, `fuType`, `fuOpType`, etc.
3. **`SignExt` Function**: Ensure the function for sign-extension is implemented. For example:
   ```scala
   def SignExt(value: UInt, len: Int): UInt = {
     val signBit = value(value.getWidth - 1)
     Cat(Fill(len - value.getWidth, signBit), value)
   }
   ```
4. **Global Parameters (`HasNPCParameter`)**: This trait should define global parameters such as `XLen` and other system-wide constants.

You can integrate this code into your project after verifying the dependencies and helper functions. Let me know if you need assistance with any missing pieces!
httpx - INFO - HTTP Request: POST https://a.fe8.cn/v1/chat/completions "HTTP/1.1 200 OK"
Below is the complete Chisel code for the `IDU` module (`Instruction Decode Unit`) based on your provided design task and specifications:

```scala
package riscv

import chisel3._
import chisel3.util._

class IDU(XLen: Int, IndependentBru: Boolean) extends NPCModule {
  // Input/Output interface
  val io = IO(new NPCBundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu = Decoupled(new DecodeIO)
  })

  // === Handshake Processing === //
  val AnyInvalidCondition = false.B
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)

  // Extract instruction from IFU input
  val inst = io.from_ifu.bits.cf.inst

  // === Instruction Decoding === //
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil =
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  // === Control Signal Generation === //
  val ctrl = Wire(new CtrlSignal)
  ctrl.rfWen := Instructions.isRegWrite(instType)
  ctrl.rs1 := inst(19, 15)
  ctrl.rs2 := inst(24, 20)
  ctrl.rd := inst(11, 7)
  ctrl.MemWrite := (instType === Instructions.TYPE_S)
  ctrl.ResSrc := MuxCase(
    0.U,
    Array(
      (inst(6, 0) === "b0000011".U) -> 1.U, // Load
      (inst(6, 0) === "b1110011".U) -> 2.U  // CSR
    )
  )
  ctrl.fuSrc1Type := fuSrc1Type
  ctrl.fuSrc2Type := fuSrc2Type
  ctrl.fuType := fuType
  ctrl.fuOpType := fuOpType

  // === Immediate Extension === //
  val imm = Wire(UInt(XLen.W))
  imm := MuxCase(
    0.U,
    Array(
      // I type: 12-bit sign extension
      (instType === Instructions.TYPE_I) -> SignExt(inst(31, 20), XLen),
      
      // U type: shift left 12 bits and extend
      (instType === Instructions.TYPE_U) -> Cat(inst(31, 12), 0.U(12.W)),
      
      // J type: immediate is concatenated in 5 parts and sign-extended
      (instType === Instructions.TYPE_J) -> SignExt(Cat(inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U(1.W)), XLen),
      
      // S type: immediate is concatenated in 2 parts and sign-extended
      (instType === Instructions.TYPE_S) -> SignExt(Cat(inst(31, 25), inst(11, 7)), XLen),
      
      // B type: immediate is concatenated in 5 parts and sign-extended
      (instType === Instructions.TYPE_B) -> SignExt(Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U(1.W)), XLen)
    )
  )

  // === Data Source Preparation === //
  val data = Wire(new DataSrc)
  data := DontCare // Assign defaults
  data.imm := imm  // Immediate extension result

  // === Output Signal Connection === //
  io.to_isu.bits.cf := io.from_ifu.bits.cf // Connect control flow information from IFU
  io.to_isu.bits.ctrl := ctrl              // Connect control signals
  io.to_isu.bits.data := data              // Connect data sources
  io.to_isu.valid := io.from_ifu.valid     // Output valid handshake signal
}
```

### Notes:
1. **HandShakeDeal Function**
   - The `HandShakeDeal` function connects the handshake between `io.from_ifu` and `io.to_isu`. It is assumed to handle valid/ready and any invalid conditions.
   - If this is a pre-defined utility, ensure it is included in your library or implemented separately.

2. **SignExt Function**
   - The `SignExt` function is used to handle signed immediate extension. This is typically implemented as a utility function:
     ```scala
     def SignExt(value: UInt, length: Int): UInt = {
       val signBit = value.head(1)
       val extendedBits = Fill(length - value.getWidth, signBit)
       Cat(extendedBits, value)
     }
     ```

3. **Instructions and DecodeTable**
   - The `Instructions` object defines a decode table (`DecodeTable`) that matches instruction opcodes to various decoded outputs. Ensure the table (`RVI_Inst.table`) is correctly defined elsewhere.

4. **Additional Classes/Objects**
   - Classes `CtrlFlow`, `CtrlSignal`, and `DataSrc`, along with the objects (`FuType`, `FuOpType`, `FuSrcType`, and `Instructions`), must be correctly implemented as described in your specification.

Let me know if you need clarification on any part or further assistance!
httpx - INFO - HTTP Request: POST https://a.fe8.cn/v1/chat/completions "HTTP/1.1 200 OK"
Below is the complete Chisel code for the instruction decode unit (IDU), following the design tasks provided:

```scala
package NPC

import chisel3._
import chisel3.util._

class IDU extends NPCModule {
  val io = IO(new NPCBundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow)) // Decoupled input from IFU
    val to_isu = Decoupled(new DecodeIO) // Decoupled output to ISU
  })

  // -------------------- Task 1: Handshake Processing --------------------
  // Manage ready/valid signals between IFU and ISU
  val AnyInvalidCondition = false.B // For now, no pipeline invalidation condition
  HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)

  // -------------------- Task 2: Instruction Decoding --------------------
  // Decode the instruction using ListLookup
  val inst = io.from_ifu.bits.cf.inst
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil =
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  // -------------------- Task 3: Control Signal Generation --------------------
  val ctrl = Wire(new CtrlSignal)

  ctrl.rfWen := Instructions.isRegWrite(instType) // Write enable for register file

  // Extract register identifiers: rs1, rs2, rd
  ctrl.rs1 := inst(19, 15)                    // rs1 field
  ctrl.rs2 := inst(24, 20)                    // rs2 field
  ctrl.rd := inst(11, 7)                      // Destination register field

  // Memory write control for S type instructions
  ctrl.MemWrite := (instType === Instructions.TYPE_S)

  // Result source control
  ctrl.ResSrc := MuxCase(0.U, Array(
    (inst(6, 0) === "b0000011".U) -> 1.U,   // Load instructions → memory result source
    (inst(6, 0) === "b1110011".U) -> 2.U    // CSR instructions → CSR result source
  ))

  // Pass functional unit source types, type, and operation type
  ctrl.fuSrc1Type := fuSrc1Type
  ctrl.fuSrc2Type := fuSrc2Type
  ctrl.fuType := fuType
  ctrl.fuOpType := fuOpType

  // -------------------- Task 4: Immediate Extension --------------------
  // Extend the immediate value based on instruction type
  val imm = Wire(UInt(XLen.W))

  imm := MuxCase(0.U, Array(
    (instType === Instructions.TYPE_I) -> SignExt(inst(31, 20), XLen),          // I type
    (instType === Instructions.TYPE_U) -> SignExt(Cat(inst(31, 12), Fill(12, 0.U)), XLen), // U type
    (instType === Instructions.TYPE_J) -> SignExt(Cat(inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U), XLen), // J type
    (instType === Instructions.TYPE_S) -> SignExt(Cat(inst(31, 25), inst(11, 7)), XLen), // S type
    (instType === Instructions.TYPE_B) -> SignExt(Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U), XLen) // B type
  ))

  // -------------------- Task 5: Data Source Preparation --------------------
  val data = Wire(new DataSrc)
  data := DontCare // Initialize all fields of DataSrc to default (don't care)
  data.imm := imm // Assign the extended immediate value to data.imm

  // -------------------- Task 6: Output Signal Connection --------------------
  // Connect control flow information from IFU to ISU
  io.to_isu.cf := io.from_ifu.bits.cf

  // Connect control signals to ISU
  io.to_isu.ctrl := ctrl

  // Connect data source signals to ISU
  io.to_isu.data := data
}
```

### Notes:

1. **Modules Used**:
   - `NPCBundle`, `CtrlFlow`, `CtrlSignal`, and `DecodeIO` were provided in the original specification. These were used as input/output bundles.
   - The `HandShakeDeal` function handles the handshake logic between `io.from_ifu` and `io.to_isu`.

2. **Immediate Value Extension**:
   - `SignExt` ensures proper sign extension for immediate values.

3. **Default Values**:
   - The `DontCare` method initializes unused fields in `data` to reduce redundant logic.

4. **Control Signal Logic**:
   - Instruction types such as `I`, `U`, `S`, etc., are handled specifically for generating `CtrlSignal` values (e.g., `rfWen`, `MemWrite`, etc.).

5. **Instruction Decoding**:
   - `ListLookup` decodes the instruction into micro-control signals (`instType`, `fuType`, etc.) based on the tables provided in `Instructions`.

This code fully implements the IDU specification in Chisel.
httpx - INFO - HTTP Request: POST https://a.fe8.cn/v1/chat/completions "HTTP/1.1 200 OK"
Below is the complete Chisel code for implementing the IDU (Instruction Decode Unit) module based on your design specification.

```scala
package riscv_processor

import chisel3._
import chisel3.util._
import chisel3.experimental._

class IDU(XLen: Int, IndependentBru: Boolean) extends Module {
  class CtrlFlow extends Bundle {
    val inst = UInt(32.W)
    val pc = UInt(XLen.W)
    val next_pc = UInt(XLen.W)
    val isBranch = Bool()
  }

  class CtrlSignal extends Bundle {
    val MemWrite = Bool()
    val ResSrc = UInt(2.W)
    val fuSrc1Type = UInt(3.W)
    val fuSrc2Type = UInt(3.W)
    val fuType = UInt(3.W)
    val fuOpType = UInt(7.W)
    val rs1 = UInt(5.W)
    val rs2 = UInt(5.W)
    val rfWen = Bool()
    val rd = UInt(5.W)
  }

  class DataSrc extends Bundle {
    val fuSrc1 = UInt(XLen.W)
    val fuSrc2 = UInt(XLen.W)
    val imm = UInt(XLen.W)
    val Alu0Res = Decoupled(UInt(XLen.W))
    val data_from_mem = UInt(XLen.W)
    val csrRdata = UInt(XLen.W)
    val rfSrc1 = UInt(XLen.W)
    val rfSrc2 = UInt(XLen.W)
  }

  class DecodeIO extends Bundle {
    val cf = new CtrlFlow
    val ctrl = new CtrlSignal
    val data = new DataSrc
  }

  object FuType {
    def num = if (IndependentBru) 6 else 5
    def alu = 0.U
    def lsu = 1.U
    def mdu = 2.U
    def csr = 3.U
    def mou = 4.U
    def bru = if (IndependentBru) 5.U else alu
    def apply() = UInt(log2Up(num).W)
  }

  object FuSrcType {
    def rfSrc1 = "b000".U
    def rfSrc2 = "b001".U
    def pc = "b010".U
    def imm = "b011".U
    def zero = "b100".U
    def four = "b101".U
    def apply() = UInt(3.W)
  }

  object FuOpType {
    def apply() = UInt(7.W)
  }

  object Instructions {
    val TYPE_N = "b0000".U
    val TYPE_I = "b0100".U
    val TYPE_R = "b0101".U
    val TYPE_S = "b0010".U
    val TYPE_B = "b0001".U
    val TYPE_U = "b0110".U
    val TYPE_J = "b0111".U

    def isRegWrite(instType: UInt): Bool = instType(2) === 1.U

    def NOP = "h00000013".U

    val DecodeDefault = List(TYPE_N, FuType.alu, "b0000000".U, FuSrcType.zero, FuSrcType.zero)
    val DecodeTable = Array(
      // Add specific instruction decoding here
    )
  }

  object ALUOpType {
    def sll = "b000001".U
  }

  val io = IO(new Bundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu = Decoupled(new DecodeIO)
  })

  // Task 1: Handshake processing
  val HandShakeDeal = Module(new HandShakeDeal) // Assume HandShakeDeal is implemented separately
  val AnyInvalidCondition = false.B
  HandShakeDeal.io.in := io.from_ifu
  HandShakeDeal.io.out := io.to_isu
  HandShakeDeal.io.anyInvalidCondition := AnyInvalidCondition

  // Task 2: Instruction decoding
  val inst = io.from_ifu.bits.inst
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil =
    ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  // Task 3: Control signal generation
  val ctrl = Wire(new CtrlSignal)
  ctrl.rfWen := Instructions.isRegWrite(instType)
  ctrl.rs1 := inst(19, 15)
  ctrl.rs2 := inst(24, 20)
  ctrl.rd := inst(11, 7)
  ctrl.MemWrite := instType === Instructions.TYPE_S
  ctrl.ResSrc := Mux(inst(6, 0) === "b0000011".U, 1.U,
    Mux(inst(6, 0) === "b1110011".U, 2.U, 0.U))
  ctrl.fuSrc1Type := fuSrc1Type
  ctrl.fuSrc2Type := fuSrc2Type
  ctrl.fuType := fuType
  ctrl.fuOpType := fuOpType

  // Task 4: Immediate extension
  val imm = Wire(UInt(XLen.W))
  imm := MuxLookup(instType, 0.U, Seq(
    Instructions.TYPE_I -> SignExt(inst(31, 20), XLen),
    Instructions.TYPE_U -> Cat(inst(31, 12), Fill(12, 0.U)),
    Instructions.TYPE_J -> SignExt(Cat(inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U), XLen),
    Instructions.TYPE_S -> SignExt(Cat(inst(31, 25), inst(11, 7)), XLen),
    Instructions.TYPE_B -> SignExt(Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U), XLen)
  ))

  // Task 5: Data source preparation
  val data = Wire(new DataSrc)
  data := DontCare
  data.imm := imm

  // Task 6: Output signal connection
  io.to_isu.bits.cf := io.from_ifu.bits
  io.to_isu.bits.ctrl := ctrl
  io.to_isu.bits.data := data
  io.to_isu.valid := io.from_ifu.valid
}
```

Please note:
1. You'll need to implement or import `HandShakeDeal` if it doesn't already exist in your project.
2. Populate the `Instructions.DecodeTable` array with the desired instruction decoding logic.
3. You might need to adjust or enhance specific parts of this code depending on your exact ISA and processor architecture requirements.
httpx - INFO - HTTP Request: POST https://a.fe8.cn/v1/chat/completions "HTTP/1.1 200 OK"
Certainly! Below is the complete Chisel code implementing the `IDU` (Instruction Decode Unit) module as described in your design tasks:

```scala
package riscv

import chisel3._
import chisel3.util._

// Trait defining instruction types
trait TYPE_INST {
  def TYPE_N = "b0000".U
  def TYPE_I = "b0100".U
  def TYPE_R = "b0101".U
  def TYPE_S = "b0010".U
  def TYPE_B = "b0001".U
  def TYPE_U = "b0110".U
  def TYPE_J = "b0111".U

  def isRegWrite(instType: UInt): Bool = instType(2, 2) === 1.U
}

// Object defining functional unit control signals
object FuType {
  def num = 5
  def alu = "b000".U
  def lsu = "b001".U
  def mdu = "b010".U
  def csr = "b011".U
  def mou = "b100".U
  def bru = alu // configurable independent branch unit logic
  def apply() = UInt(log2Up(num).W)
}

object FuOpType {
  def apply() = UInt(7.W)
}

object FuSrcType {
  def rfSrc1 = "b000".U
  def rfSrc2 = "b001".U
  def pc = "b010".U
  def imm = "b011".U
  def zero = "b100".U
  def four = "b101".U
  def apply() = UInt(3.W)
}

// Instruction decoding table
object Instructions extends TYPE_INST {
  def NOP = 0x00000013.U
  val DecodeDefault = List(TYPE_N, FuType.alu, "b000".U, FuSrcType.zero, FuSrcType.zero)
  def DecodeTable = Seq(
    // Example of instruction and type decoding (extend the table as needed)
    "b0000000???????????????0000011".U -> List(TYPE_I, FuType.lsu, "b000".U, FuSrcType.rfSrc1, FuSrcType.imm)
  )
}

// Control flow bundle
class CtrlFlow extends Bundle {
  val inst = UInt(32.W)
  val pc = UInt(64.W)
  val next_pc = UInt(64.W)
  val isBranch = Bool()
}

// Control signal bundle
class CtrlSignal extends Bundle {
  val MemWrite = Bool()
  val ResSrc = UInt(2.W)
  val fuSrc1Type = FuSrcType()
  val fuSrc2Type = FuSrcType()
  val fuType = FuType()
  val fuOpType = FuOpType()
  val rs1 = UInt(5.W)
  val rs2 = UInt(5.W)
  val rfWen = Bool()
  val rd = UInt(5.W)
}

// Data source bundle
class DataSrc extends Bundle {
  val fuSrc1 = UInt(64.W)
  val fuSrc2 = UInt(64.W)
  val imm = UInt(64.W)
  val Alu0Res = Decoupled(UInt(64.W))
  val data_from_mem = UInt(64.W)
  val csrRdata = UInt(64.W)
  val rfSrc1 = UInt(64.W)
  val rfSrc2 = UInt(64.W)
}

// Decode IO bundle
class DecodeIO extends Bundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// Instruction Decode Unit (IDU) Module
class IDU extends Module {
  val io = IO(new Bundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu = Decoupled(new DecodeIO)
  })

  // Handshake processing
  val AnyInvalidCondition = false.B
  io.to_isu.valid := io.from_ifu.valid && !AnyInvalidCondition
  io.from_ifu.ready := io.to_isu.ready && !AnyInvalidCondition

  // Decode instruction
  val inst = io.from_ifu.bits.inst
  val decodeList = Instructions.DecodeDefault
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil =
    ListLookup(inst, decodeList, Instructions.DecodeTable)

  // Control signal generation
  val ctrl = Wire(new CtrlSignal)
  ctrl.rfWen := Instructions.isRegWrite(instType)
  ctrl.rs1 := inst(19, 15)
  ctrl.rs2 := inst(24, 20)
  ctrl.rd := inst(11, 7)
  ctrl.MemWrite := instType === Instructions.TYPE_S
  ctrl.ResSrc := Mux(inst(6, 0) === "b0000011".U, 1.U,
                 Mux(inst(6, 0) === "b1110011".U, 2.U, 0.U))
  ctrl.fuSrc1Type := fuSrc1Type
  ctrl.fuSrc2Type := fuSrc2Type
  ctrl.fuType := fuType
  ctrl.fuOpType := fuOpType

  // Immediate extension
  val imm = Wire(UInt(64.W))
  imm := MuxLookup(instType, 0.U, Seq(
    Instructions.TYPE_I -> SignExt(inst(31, 20), 64),
    Instructions.TYPE_U -> Cat(inst(31, 12), Fill(12, 0.U)),
    Instructions.TYPE_J -> SignExt(Cat(inst(31), inst(19, 12), inst(20), inst(30, 21), 0.U), 64),
    Instructions.TYPE_S -> SignExt(Cat(inst(31, 25), inst(11, 7)), 64),
    Instructions.TYPE_B -> SignExt(Cat(inst(31), inst(7), inst(30, 25), inst(11, 8), 0.U), 64)
  ))

  // Data source preparation
  val data = Wire(new DataSrc)
  data := DontCare
  data.imm := imm

  // Output signal connection
  io.to_isu.bits.cf := io.from_ifu.bits
  io.to_isu.bits.ctrl := ctrl
  io.to_isu.bits.data := data
}

object IDUMain extends App {
  println("Generating Verilog for IDU...")
  (new chisel3.stage.ChiselStage).emitVerilog(new IDU)
}
```