
## 文档介绍
本文档介绍一款由本团队自主设计的支持RISCV32I的5级流水线处理器。该处理器的HDL编写基于现代硬件描述语言Chisel完成，经过编译得到处理器的Verilog实现。该处理器按照RV32I指令集标准的2024.04版实现，并且支持部分特权指令用于运行RT-Thread操作系统。本设计使用模块间的握手信号实现分布式流水线控制，无需专门的控制单元。

本文档为每个模块分章节进行介绍，使用以下格式（markdown）：
``` markdown
## 模块名称
### 概述
总体介绍该模块功能，与其他模块的联系
### 参数
介绍模块定义时的参数
### 输入/输出接口
介绍模块的IO端口
### 内部逻辑
按照模块内部的功能划分介绍具体的内部逻辑
``` 

## 模块-RVCore2（CPU TOP）

### 概述
RVCore2 是一个基于 RISC-V 指令集的处理器顶层模块，采用五级流水线结构（取指、译码、发射、执行、写回）。该模块支持基本的 RV32I指令集，并可根据配置参数选择是否支持 RVE 扩展（减少通用寄存器数量）。核心包含与内存交互的接口以及调试用的提交信息接口。

### 参数
- `XLen`: 数据位宽，默认为 32 位
- `CONFIG_RVE`: 布尔值，决定是否支持 RVE 扩展（启用时通用寄存器数量为 16，否则为 32）
- `NR_GPR`: 通用寄存器数量，由 `CONFIG_RVE` 决定
- `IndependentBru`: 布尔值，表示是否支持独立的分支单元（当前未使用）

### 输入/输出接口
#### 输入接口
- `from_mem`: 来自内存的数据输入
  - `data`: 32 位内存读取数据
- `inst`: 32 位指令输入

#### 输出接口
- `to_mem`: 向内存的写入接口
  - `data`: 32 位写入数据
  - `addr`: 32 位内存地址
  - `Wmask`: 2 位写掩码（00: 字节，01: 半字，10: 字，11: 双字）
  - `MemWrite`: 写使能信号
- `pc`: 32 位当前程序计数器值
- `commit`: 调试用提交信息
  - `valid`: 提交有效信号
  - `pc`: 提交指令的 PC 值
  - `next_pc`: 下一条指令的 PC 值
  - `inst`: 提交的指令

### 内部逻辑
1. **流水线结构**:
   - `IFU` (取指单元): 处理指令获取
   - `IDU` (译码单元): 指令译码
   - `ISU` (发射单元): 指令发射
   - `EXU` (执行单元): 指令执行和内存访问
   - `WBU` (写回单元): 结果写回

2. **流水线级间连接**:
   - 使用 `StageConnect` 模块连接各级流水线，处理数据传递和流水线刷新
   - 执行单元 (`EXU`) 可以产生重定向信号 (`redirect`)，用于刷新前级流水线

3. **寄存器文件**:
   - 使用 `ysyx_23060228_RegFile_BlackBox` 作为寄存器文件实现
   - 支持双读单写操作
   - 写回阶段 (`WBU`) 负责更新寄存器文件

4. **内存接口**:
   - 执行单元 (`EXU`) 直接处理内存读写请求
   - 支持不同宽度的内存访问（通过 `Wmask` 控制）

5. **调试接口**:
   - 提交信息 (`commit`) 在写回阶段捕获，延迟一个周期输出
   - 包含指令的 PC、下一条 PC 和指令内容

6. **控制流处理**:
   - 执行单元产生的重定向信号会反馈给取指单元，用于处理分支/跳转

## 模块-IFU (Instruction Fetch Unit)

### 概述
IFU模块是处理器流水线中的指令获取单元，负责从内存中获取指令、计算下一条指令地址、处理分支预测和跳转指令，并将指令和控制流信息传递给后续的解码阶段(IDU)。

### 参数
- 参数继承自NPCModule, 本模块使用：
- XLen: 通用寄存器数据位宽


### 输入/输出接口
class IFUIO extends NPCBundle {
    val inst      = Input(UInt(32.W))        // 从内存读取的指令
    val redirect  = Input(new Redirect)      // 重定向信号bundle，更改pc寄存器，来自处理器后端，下文介绍
    val to_idu    = Decoupled(new CtrlFlow)  // 控制流信号bundle，贯穿整条流水线，下文介绍  
    val pc        = Output(UInt(XLen.W))     // 当前程序计数器值   
}

// 以下Bundle已定义，无需重复编写
class CtrlFlow extends NPCBundle {           // 描述当前阶段的指令特征的信号束
    val inst      = UInt(32.W)               // 当前控制流指令
    val pc        = UInt(XLen.W)             // 指令地址
    val next_pc   = UInt(XLen.W)             // 下一条指令地址，有分支预测器产生，被后端检查修正前不一定正确
    val isBranch  = Bool()                   // 是否是分支指令
}

// 以下Bundle已定义，无需重复编写
class Redirect extends NPCBundle {           // 重定向信号bundle，后续next_pc选择的判据之一，来自处理器后端
  val target = UInt(XLen.W)                  // 重定向目标地址
  val valid  = Bool()                        // 该信号束是否有效
}

### 内部逻辑
**instMem Handshake**
```scala
class InstMem extends NPCBundle {
  val isFlush   = Output(Bool())
  
  val reqValid  = Output(Bool())
  val pc = Output(UInt((XLen).W))
  val reqReady  = Input(Bool())

  val respValid = Input(Bool())
  val inst = Input(UInt(32.W))
  val respReady = Output(Bool())
}
```
   - **Behaviour of InstMem**
      * 
        when         (isFlush)                     {counter := 0.U}
        elsewhen      (counter===0.U && !req.fire)     {counter := counter  }
        elsewhen  (counter===0.U &&  req.fire)     {counter increase; pcReg := pc}
        elsewhen(counter >= max.U && !resp.fire)   { counter := counter }
        elsewhen(counter >= max.U && resp.fire)    { counter := 0.U     }
        otherwise                                  {counter increase    }
      * state: idle(counter===0.U), finish(counter>=max.U)
        
      * reqReady  := respReady && (state===idle)
      * respValid := state===finish
      * inst      := Mem(pcReg)
   
   - **Behaviour of IFU**

      * 
      when     (redirect.valid)  {npc := target}
      elsewhen(!resp.fire)       {npc := pc}
      elsewhen(!out.fire)        {npc := pc}
      otherwise                  {npc change}
      * reqValid     := io.out.ready
      * respReady    := io.out.ready || redirect.valid
      * io.out.valid := io.instMem.respValid && !AnyInvalidCondition


**dataMem Handshake**
```scala
class SimpleBusReq extends NPCBundle {
  val addr = Output(UInt(XLen.W))
  val wdata = Output(UInt(XLen.W))
  val wmask = Output(UInt(8.W))
  val wen   = Output(Bool())
}

class SimpleBusResp extends NPCBundle {
  val rdata = Output(UInt(XLen.W)) 
}
```
- **Behaviour of dataMem**
   * 
     when         (isFlush)                     {counter := 0.U}
     elsewhen      (counter===0.U && !req.fire)     {counter := counter  }
     elsewhen  (counter===0.U &&  req.fire)     {counter increase; addrReg := addr}
     elsewhen(counter >= max.U && !resp.fire)   { counter := counter }
     elsewhen(counter >= max.U && resp.fire)    { counter := 0.U     }
     otherwise                                  {counter increase    }
   * state: idle(counter===0.U), finish(counter>=max.U), prefinish(counter === (max - 1).U)
     
   * reqReady  := respReady && (state===idle)
   * respValid := state===finish
   * rdata      := when(state===prefinish) Mem(addr) : rdata

- **Behaviour of LSU**
   * dmem.req.valid := io.in.valid
   * io.in.ready := dmem.req.ready && io.out.ready
   * dmem.resp.ready := io.out.ready
   * io.out.valid := dmem.resp.valid
   * AnyStopCodition = xxx || lsuNotReady

- **AXI4-Lite Behaviour of dataMem**
   * deal 1 channel at one time
   * 
   * 
     when         (isFlush)                     {counter := 0.U}
     elsewhen      (counter===0.U && !req.fire)     {counter := counter  }
     elsewhen  (counter===0.U &&  req.fire)     {counter increase; addrReg := addr}
     elsewhen(counter >= max.U && !resp.fire)   { counter := counter }
     elsewhen(counter >= max.U && resp.fire)    { counter := 0.U     }
     otherwise                                  {counter increase    }
   * state: idle(counter===0.U), finish(counter>=max.U), prefinish(counter === (max - 1).U)
     

   * rdata      := when(state===prefinish) Mem(addr) : rdata
   
   * reqValid := io_ar_valid || io_aw_valid || io_w_valid

   * reqReady := state===idle
   * io_dmem_ar_ready := reqReady
   * io_dmem_aw_ready := reqReady
   * io_dmem_w_ready  := reqReady

   * respValid := state===finish
   * respReady := (!wenReg && io_r_ready)|| 
                  ( wenReg && io_b_ready)
   * io_dmem_r_valid := !wenReg && respValid
   * io_dmem_b_valid :=  wenReg && respValid
   
   * AddrMem  := io_ar_valid ? io_ar_bits_addr :
                 io_aw_valid ? io_aw_bits_addr;
   * Wmask    := {4'b0000, io_w_bits_strb}
   * DataToMem := io_w_bits_data
   * MemWrite := io_w_valid
   * io_r_data := rdataReg

- **AXI4-Lite Behaviour of LSU**
   * dmem.req.valid := io.in.valid
      * readReq  = io.in.valid && (!io.ctrl.MemWrite)
      * writeReq = io.in.valid && ( io.ctrl.MemWrite)
      * io.dmem.ar.valid := readReq
      * io.dmem.aw.valid := writeReq
      * io.dmem. w.valid := writeReq
      * This version, `write data` and `write address` begin in same time
   * io.in.ready := dmem.req.ready && io.out.ready
      * io.in.ready := readReq  && (io.dmem.ar.ready)
                     ||writeReq &&  io.dmem.aw.ready && io.dmem.w.ready
   * dmem.resp.ready := io.out.ready
      * io.dmem.r.ready := io.out.ready
      * io.dmem.b.ready := io.out.ready
   * io.out.valid := dmem.resp.valid
      * io.out.valid := io.dmem.r.valid || io.dmem.b.valid
   * AnyStopCodition = xxx || lsuNotReady

1. **PC寄存器**:
   - 寄存器类型，设置初始值为0x80000000
   - 每个周期更新为`next_pc`

2. **指令类型判断**:
   - 通过操作码(inst[6:0])判断指令类型:
     - 分支指令(包括JAL(b1101111)、JALR(b1100111)和B-type(b1100011))
   - 通过指令判断特权指令
     - ECALL指令(b000000000000_00000_000_00000_1110011)
     - MRET指令(b0011000_00010_00000_000_00000_1110011)
   - 以上类型均不符合时，“无需跳转模式”，后续next_pc选择的判据之一

3. **jal指令目标计算**:
   - 对于JAL指令:
     - 通过操作码(inst[6:0])判断指令类型:跳转指令JAL(b1101111)，`jal模式`, 后续next_pc选择的判据之一
     - 计算立即数偏移量并符号扩展, Cat(Fill(XLen - 21, inst(31)), inst(31), inst(19,12), inst(20), inst(30, 21), 0.U(1.W))
     - `jal模式`目标地址 = pc + 偏移量

6. **简单分支预测**:
   - 静态的下一条指令snpc： pc + 4
   - 当前实现为简单的顺序预测predictPc ： snpc


4. **next_pc计算逻辑**:
   next_pc为选择器树的组合逻辑输出
   - 优先级顺序:
     1. 重定向信号有效时:    使用重定向目标
     2. IDU ready信号无效:       保持当前PC
     3. 无需跳转模式:         PC + 4
     4. JAL指令模式: 使用计算的跳转目标
     5. 其他分支指令: 使用分支预测PC
     6. 默认情况: 保持当前PC

5. **输出逻辑**:
   - 将当前pc、指令、next_pc和分支信息传递给IDU，解耦信号valid置为真
   - 向内存输出当前pc
   - 输出有效性由valid寄存器控制(当前始终为true)



## 模块-IDU (Instruction Decode Unit)

### 概述
IDU 模块是 RISC-V 处理器中的指令解码单元，负责将来自 IFU (Instruction Fetch Unit) 的指令进行解码，生成控制信号和数据源选择信号，并将解码后的信息传递给 ISU (Issue Unit)。

主要功能包括：
1. 指令类型识别和分类
2. 生成执行单元控制信号
3. 立即数扩展
4. 寄存器文件读写控制
5. 数据源选择

### 参数
模块继承自 `NPCModule` ，使用以下参数：
- `XLen`: 数据位宽（通常为 32 或 64）
- `IndependentBru`: 布尔值，指示是否使用独立的分支单元
使用以下参数定义指令类型
trait  TYPE_INST{
    def TYPE_N = "b0000".U
    def TYPE_I = "b0100".U
    def TYPE_R = "b0101".U
    def TYPE_S = "b0010".U
    def TYPE_B = "b0001".U
    def TYPE_U = "b0110".U
    def TYPE_J = "b0111".U
    

    def isRegWrite(instType : UInt) : Bool = instType(2,2) === 1.U
}


使用以下参数定义功能单元相关控制信号
object FuType extends HasNPCParameter{          // 决定`信号束`由哪个功能单元处理

    def num = 5
    def alu = "b000".U
    def lsu = "b001".U
    def mdu = "b010".U
    def csr = "b011".U
    def mou = "b100".U
    def bru = if(IndependentBru) "b101".U
              else               alu
    def apply() = UInt(log2Up(num).W)        // 定义该类信号的类型，后文用到
}

object FuOpType{                             // 决定功能单元对信号束进行何种操作，具体含义在功能单元内部定义
    def apply() = UInt(7.W)
}

object FuSrcType{                            // 决定功能单元所需的源操作数类型
    def rfSrc1 = "b000".U 
    def rfSrc2 = "b001".U 
    def pc     = "b010".U 
    def imm    = "b011".U
    def zero   = "b100".U 
    def four   = "b101".U

    def apply() = UInt(3.W)               // 该类信号的类型，后文用到 
}

object Instructions extends TYPE_INST     // 指令解码为微指令，后文用到
with HasNPCParameter
{
    def NOP = 0x00000013.U
    val DecodeDefault = List(TYPE_N, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
    def DecodeTable = RVI_Inst.table 
}

### 输入/输出接口
    val io = IO(new NPCBundle{
        val from_ifu = Flipped(Decoupled(new CtrlFlow)) // 来自 IFU 的解耦接口
        val to_isu = Decoupled(new DecodeIO)
    })


class DecodeIO extends NPCBundle {

    val cf      = new CtrlFlow         // 控制流信息（来自 IFU 的原始信息）
    val ctrl    = new CtrlSignal       // 控制信号，下文介绍该信号bundle
    val data    = new DataSrc          // 数据源信息，下文介绍该信号bundle

}

// 以下Bundle已定义，无需重复编写
class CtrlFlow extends NPCBundle {           // 描述当前阶段的指令特征的信号束
    val inst      = UInt(32.W)               // 当前控制流指令
    val pc        = UInt(XLen.W)             // 指令地址
    val next_pc   = UInt(XLen.W)             // 下一条指令地址，有分支预测器产生，被后端检查修正前不一定正确
    val isBranch  = Bool()                   // 是否是分支指令
}

class CtrlSignal extends NPCBundle {   // 控制信号束

    val MemWrite    = Bool()
    val ResSrc      = UInt()

    val fuSrc1Type  = FuSrcType()
    val fuSrc2Type  = FuSrcType()
    val fuType      = FuType()
    val fuOpType    = FuOpType()
    val rs1      = UInt(5.W)
    val rs2      = UInt(5.W)
    val rfWen       = Bool()
    val rd      = UInt(5.W)

}

class DataSrc extends NPCBundle {
    val fuSrc1  = UInt(XLen.W)         // 功能单元操作数
    val fuSrc2  = UInt(XLen.W)
    val imm     = UInt(XLen.W)         // 立即数

    val Alu0Res  = Decoupled(UInt(XLen.W))   // ALU计算结果
    val data_from_mem =  UInt(XLen.W)        // 从内存读取的数据
    val csrRdata = UInt(XLen.W)              // 从CSR读取的数据
    val rfSrc1  = UInt(XLen.W)               // 从寄存器读取的数据
    val rfSrc2  = UInt(XLen.W)

}


### 内部逻辑
1. **握手处理**:
   - 使用 `HandShakeDeal` 处理来自 IFU 和到 ISU 的 ready/valid 握手信号
   - `AnyInvalidCondition` 用于标记无效条件，该模块内设为false.B
   - 直接调用函数即可：HandShakeDeal(io.from_ifu, io.to_isu, AnyInvalidCondition)

2. **指令解码**:
   - 使用 `ListLookup` 查找指令解码表(`DecodeTable`)获取控制信号
   - 解码信息包括：
     - 指令类型(`instType`)
     - 功能单元类型(`fuType`)
     - 操作类型(`fuOpType`)
     - 源操作数1类型(`fuSrc1Type`)
     - 源操作数2类型(`fuSrc2Type`)
   val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil = ListLookup(inst, Instructions.DecodeDefault, Instructions.DecodeTable)   

3. **控制信号生成**:
参考IO端口中的val ctrl    = new CtrlSignal 
   - 寄存器写使能(`rfWen`): 由指令类型决定，调用上文`isRegWrite`函数
   - 提取指令中的源寄存器(`rs1`, `rs2`)和目标寄存器(`rd`)字段
   - 存储器写使能(`MemWrite`): S 类型指令时置位，其余时刻为false.B
   - 结果源选择(`ResSrc`): 选择器输出，
      - load 指令（inst(6,0) === "b0000011".U）置为 1.U
      - CSR 操作（inst(6,0) === "b1110011".U）置为 2.U
      - 默认情况为 0.U
   - 源操作数类型（`fuSrc1Type`，`fuSrc2Type`），功能单元类型(`fuType`)，操作类型(`fuOpType`)由指令解码结果赋值
4. **立即数扩展**:
使用Cat()进行拼接
使用SignExt(a:UInt, len:Int)进行有符号扩展，其中len表示最终结果的位宽
   - 根据指令类型进行不同的立即数扩展为XLen位，按照RISCV32I指令集规范进行扩展：
     - I 类型: 12 位符号扩展
     - U 类型: 20 位立即数左移 12 位并且扩展
     - J 类型: 20 位符号扩展（分五部分拼接），注意次序以及最低位补0
     - S 类型: 12 位符号扩展（分两部分拼接）
     - B 类型: 12 位符号扩展（分五部分拼接），注意次序以及最低位补0

5. **数据源准备**:
参考上文端口信号束`DataSrc`
   - 将立即数扩展结果存入 `data.imm`
   - 其他数据源(`fuSrc1`, `fuSrc2`, `rfSrc1`, `rfSrc2` 等)当前为未实现状态(DontCare)


## 模块-ISU (Issue Unit)

### 概述
该模块实现了一个带有记分牌(ScoreBoard)机制的指令发射单元(ISU)。主要功能包括：
1. 通过记分牌跟踪寄存器使用状态，检测数据冒险
2. 控制指令从解码阶段(IDU)到执行阶段(EXU)的流转
3. 处理操作数转发和立即数选择
4. 使用握手协议管理流水线控制

### 参数
- `maxScore` (ScoreBoard参数)：记分牌中每个寄存器的最大计数值，决定数据冒险检测的深度
- `NR_GPR` (来自HasNPCParameter)：通用寄存器数量
- `XLen` (来自HasNPCParameter)：数据位宽

### 输入/输出接口
val io = IO(new Bundle{
    val from_idu = Flipped(Decoupled(new DecodeIO)) // 来自解码单元的指令信息, 后文介绍
    val to_exu   = Decoupled(new DecodeIO)          // 发送到执行单元的指令信息
    val wb = Input(new WbuToRegIO)                  // 写回单元反馈, 关于通用寄存器忙碌状态，后文介绍
    val from_reg = new Bundle {                     // 寄存器文件读取的寄存器数值
        val rfSrc1 = Input(UInt(XLen.W))
        val rfSrc2 = Input(UInt(XLen.W))
    }
})

class WbuToRegIO extends NPCBundle {            // WBU向Regfile写回数据的信号束，在这里作为寄存器忙碌状态更新的依据
        val rd = UInt(5.W)
        val Res = UInt(XLen.W)
        val RegWrite = Bool()
}

class DecodeIO extends NPCBundle {

    val cf      = new CtrlFlow         // 控制流信息（来自 IFU 的原始信息）
    val ctrl    = new CtrlSignal       // 控制信号，下文介绍该信号bundle
    val data    = new DataSrc          // 数据源信息，下文介绍该信号bundle

}

// 以下Bundle已定义，无需重复编写
class CtrlFlow extends NPCBundle {           // 描述当前阶段的指令特征的信号束
    val inst      = UInt(32.W)               // 当前控制流指令
    val pc        = UInt(XLen.W)             // 指令地址
    val next_pc   = UInt(XLen.W)             // 下一条指令地址，有分支预测器产生，被后端检查修正前不一定正确
    val isBranch  = Bool()                   // 是否是分支指令
}

class CtrlSignal extends NPCBundle {   // 控制信号束

    val MemWrite    = Bool()
    val ResSrc      = UInt()

    val fuSrc1Type  = FuSrcType()
    val fuSrc2Type  = FuSrcType()
    val fuType      = FuType()
    val fuOpType    = FuOpType()
    val rs1      = UInt(5.W)
    val rs2      = UInt(5.W)
    val rfWen       = Bool()
    val rd      = UInt(5.W)

}

class DataSrc extends NPCBundle {
    val fuSrc1  = UInt(XLen.W)         // 功能单元操作数
    val fuSrc2  = UInt(XLen.W)
    val imm     = UInt(XLen.W)         // 立即数

    val Alu0Res  = Decoupled(UInt(XLen.W))   // ALU计算结果
    val data_from_mem =  UInt(XLen.W)        // 从内存读取的数据
    val csrRdata = UInt(XLen.W)              // 从CSR读取的数据
    val rfSrc1  = UInt(XLen.W)               // 从寄存器读取的数据
    val rfSrc2  = UInt(XLen.W)

}

### 内部逻辑

**ScoreBoard模块：**
参数 maxScore : Int，计分牌最大可记录分数
用普通的类实现，继承 HasNPCParameter
1. 创建寄存器组`busy`跟踪每个寄存器的使用状态，对应`NR_GPR`个寄存器
   每个busy寄存器具备计数器功能，计数器值为0表示对应通用寄存器不被占用，可以被读取
2. 提供功能,用函数实现：
   - `isBusy(idx: UInt) : Bool`：检查指定编号idx的寄存器是否被占用，计数器值为0表示对应通用寄存器不被占用，可以被读取
   - `mask(idx: UInt) : UInt`：根据寄存器编号idx，生成寄存器位掩码，返回值位宽NR_GPR，举例，当idx为2，返回值从右向左数序号，0，1，2..., 第2位置为1，其余为0.
   - `update(setMask: UInt, clearMask: UInt)`：根据设置/清除掩码更新记分牌状态，两个参数位宽均为NR_GPR，其含义如mask()所定义，setMask表示指定寄存器busy记分牌加1，clearMask表示指定寄存器记分牌减1.
      - 针对上述NR_GPR个busy寄存器（记分牌）设置更新逻辑，对于busy(0)，永远保持为0.U，其余记分牌根据函数两个参数做如下更新：
         - 同时设置和清除时保持原值
         - 设置掩码增加计数值(不超过maxScore)
         - 清除掩码减少计数值(不低于0)
         - 默认情况保持原值


**ISU模块主要逻辑：**
1. **数据冒险检测**：
   - 实例化ScoreBoard
   - 通过ScoreBoard的isBusy函数检查两个源寄存器是否被占用
   - 当检测到冒险时阻塞指令发射，AnyInvalidCondition被置为有效，通过函数HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition) 处理握手信号

2. **regfile连线函数**：

   - 定义rs1_rs2(rfSrc1 : UInt, rfSrc2 : UInt): (UInt, UInt)
   函数内直接将参数rfSrc1/rfSrc2赋值给to_exu端口信号
   将rs1/rs2作为函数输出

2. **操作数处理**：
参考端口to_exu.bits.
   - 从寄存器文件获取操作数值
   - 根据`fuSrc1Type/fuSrc2Type`选择操作数来源：
     - 寄存器值、PC、立即数或固定值(0/4),以下是映射
        FuSrcType.rfSrc1    -> rfSrc1,
        FuSrcType.pc        -> io.from_idu.bits.cf.pc,
        FuSrcType.zero      -> 0.U     
        FuSrcType.rfSrc2    -> rfSrc2,
        FuSrcType.imm       -> io.from_idu.bits.data.imm,
        FuSrcType.four      -> 4.U


4. **记分牌更新**：
   - 指令发射时(setMask)：标记目标寄存器为占用
   - 写回完成时(clearMask)：释放目标寄存器
   - 使用掩码机制高效更新多个寄存器状态
    val wbuClearMask  = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U)        
    val isFireSetMask = Mux(inBits.ctrl.rfWen && out.fire, sb.mask(inBits.ctrl.rd), 0.U)
    sb.update(isFireSetMask, wbuClearMask)
5. **指令信息传递**：
   - 将解码阶段的所有控制信号和数据处理后传递到执行阶段
   - 保持原始指令的PC、立即数等不变


## 模块-EXU (Execution Unit)

### 概述
EXU 是处理器中负责执行指令的核心模块，它接收来自指令发射单元（ISU）的指令信息，并根据指令类型分发到不同的功能单元（ALU、LSU、CSR）进行处理。处理完成后，将结果传递给写回单元（WBU）。同时，EXU 还负责处理分支跳转指令，生成重定向信号以修正预测错误的 PC 值。

### 参数
该模块继承自 `NPCModule` 和 `HasNPCParameter`，并使用 `TYPE_INST` trait，表明其与处理器核参数和指令类型相关。具体参数取决于父类和 trait 的定义。

### 输入/输出接口
val io = IO(new Bundle{
    val from_isu = Flipped(Decoupled(new DecodeIO))   // 来自指令译码单元的输入，包含指令的控制流信息、控制信号和数据源信息。
    val to_wbu = Decoupled(new ExuToWbuIO)            // 输出到写回单元，包含指令执行结果、控制流信息和控制信号。
    val to_mem = new ToMem                            // 从LSU功能单元输出到存储器
    val from_mem = new FromMem                        // 从存储器输入到LSU
    val redirect = Output(new Redirect)               // 输出重定向信号，用于修正预测错误的 PC 值
})

class Redirect extends NPCBundle {
  val target = UInt(XLen.W)
  val valid  = Bool()
}

class DecodeIO extends NPCBundle {

    val cf      = new CtrlFlow         // 控制流信息（来自 IFU 的原始信息）
    val ctrl    = new CtrlSignal       // 控制信号，下文介绍该信号bundle
    val data    = new DataSrc          // 数据源信息，下文介绍该信号bundle

}

// 以下Bundle已定义，无需重复编写
class CtrlFlow extends NPCBundle {           // 描述当前阶段的指令特征的信号束
    val inst      = UInt(32.W)               // 当前控制流指令
    val pc        = UInt(XLen.W)             // 指令地址
    val next_pc   = UInt(XLen.W)             // 下一条指令地址，有分支预测器产生，被后端检查修正前不一定正确
    val isBranch  = Bool()                   // 是否是分支指令
}

class CtrlSignal extends NPCBundle {   // 控制信号束

    val MemWrite    = Bool()
    val ResSrc      = UInt()

    val fuSrc1Type  = FuSrcType()
    val fuSrc2Type  = FuSrcType()
    val fuType      = FuType()
    val fuOpType    = FuOpType()
    val rs1      = UInt(5.W)
    val rs2      = UInt(5.W)
    val rfWen       = Bool()
    val rd      = UInt(5.W)

}

class DataSrc extends NPCBundle {
    val fuSrc1  = UInt(XLen.W)         // 功能单元操作数
    val fuSrc2  = UInt(XLen.W)
    val imm     = UInt(XLen.W)         // 立即数

    val Alu0Res  = Decoupled(UInt(XLen.W))   // ALU计算结果,该模块中需要得alu到驱动
    val data_from_mem =  UInt(XLen.W)        // 从内存读取的数据,该模块中需要得到lsu驱动
    val csrRdata = UInt(XLen.W)              // 从CSR读取的数据,该模块中需要得到csr驱动
    val rfSrc1  = UInt(XLen.W)               // 从寄存器读取的数据
    val rfSrc2  = UInt(XLen.W)

}

### 内部逻辑
1. **功能单元分发**：
需要例化三个功能单元模块，ALU,LSU，CSR
三者均需要类似的连线操作，连接2个操作数，操作类型数，例化alu0举例，确保srca,srcb,fuOpType,ready,valid被连接
alu.io.in.bits.srca := io.from_isu.bits.data.fuSrc1  // fuSrc2同理
alu.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
alu.io.out.ready := io.to_wbu.ready
alu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.alu)
io.to_wbu.bits.data.Alu0Res.bits := alu0.io.out.bits
其余模块均需要类似的连线，并且可能还有其他端口连写
   - **ALU**：处理算术逻辑运算指令。根据 `fuType` 判断是否为 ALU 指令，并将操作数、操作类型传递给 ALU 模块。
   - **LSU**：处理加载存储指令。同样根据 `fuType` 判断是否为 LSU 指令，并将操作数、操作类型传递给 LSU 模块。LSU 模块还负责与内存单元的交互。
      - lsu输入
   注意端口信号，from_mem,to_mem, ctrl, data作为输入，连接到：
    lsu0.io.from_mem     
    lsu0.io.ctrl 
    lsu0.io.data
      - lsu输出
   lsu0.io.out.bits，lsu0.io.to_mem作为输出，连接到：
    io.to_wbu.bits.data.data_from_mem
    io.to_mem 
   - **CSR**：处理控制和状态寄存器指令。根据 `fuType` 判断是否为 CSR 指令，并调用 CSR 模块的访问接口。
   输出结果连接到io.to_wbu.bits.data.csrRdata

2. **分支跳转处理**：
此前定义以下信号束包裹关于跳转结果的信号（无需重复定义）
class BruRes extends NPCBundle {
    val valid = Bool()              // 该信号束是否有效，即是否检测到对应跳转指令
    val targetPc = UInt(XLen.W)     // pc跳转的目标地址
}
使用Wire()例化一个bruRes对象，调用方法CalBruRes(),bruRes := CalBruRes(inBits, alu0, csr0)
此时bruRes携带有效信号和目标地址

   - 生成重定向信号 `redirect`，当预测的 PC 值(端口的next_pc)与实际计算的目标 PC 值不一致定义为预测错误。
   redirect.valid信号由from_isu.valid, bruRes.valid, 与预测错误共同决定，三者为真时valid有效, 并且target被设置为目标地址,
   - 更新 `out.bits.cf.next_pc` 为正确的目标 PC 值,如果预测错误未发生，则无需改变

3. **握手信号处理**：
   - 使用 `HandShakeDeal` 函数处理输入和输出的 `ready/valid` 信号。
调用如下函数
    HandShakeDeal(io.from_isu, io.to_wbu, 
                  AnyInvalidCondition = false.B, 
                  AnyStopCodition = io.redirect.valid
                  )



## 模块-ALU (算术逻辑单元)

### 概述
ALU模块实现了一个支持多种算术和逻辑操作的处理器核心组件。它能够执行基本算术运算（加减）、位操作（与/或/异或）、移位操作以及比较操作。此外，它还支持分支判断逻辑和32位/64位字长操作。

### 参数
- XLen：数据位宽（通过NPCBundle继承，通常为32或64位）

### 输入/输出接口
**输入接口 (io.in):**
- `srca` (UInt(XLen.W)): 第一个操作数
- `srcb` (UInt(XLen.W)): 第二个操作数
- `fuOpType` (FuOpType): 操作类型编码

**输出接口 (io.out):**
- `out` (UInt(XLen.W)): 运算结果
- `taken` (Bool): 分支判断结果（仅对分支指令有效）

**控制信号:**
- `in.valid` (Bool): 输入有效信号
- `in.ready` (Bool): 输入就绪信号（固定为true）
- `out.valid` (Bool): 输出有效信号（与in.valid同步）

### 内部逻辑

1. **基础运算单元:**
   - 加法器/减法器：通过补码实现加减法统一处理
   - 异或单元：用于比较和逻辑运算
   - 移位器：支持逻辑左移/右移和算术右移
   - 比较器：通过加法器结果生成slt/sltu信号

2. **操作类型解码:**
   - 使用ALUOpType对象定义的编码识别当前操作
   - 支持的操作包括：
     * 算术：add/sub/addw/subw
     * 逻辑：and/or/xor
     * 移位：sll/srl/sra/sllw/srlw/sraw
     * 比较：slt/sltu
     * 分支：beq/bne/blt/bge/bltu/bgeu
     * 跳转：jal/jalr/call/ret

3. **字长处理:**
   - 通过isWordOp识别32位操作
   - 对32位结果进行符号扩展

4. **分支判断逻辑:**
   - 根据操作类型和比较结果生成taken信号
   - 支持beq/bne/blt/bge/bltu/bgeu等多种分支条件

5. **辅助功能:**
   - SignExt/ZeroExt对象提供位扩展功能
   - 移位量根据操作类型选择5位或6位

### 补充说明

**SignExt对象:**
- 功能：符号位扩展
- 参数：
  - a: 输入数据
  - len: 目标位宽
- 逻辑：当目标位宽大于输入时，用最高位符号填充

**ZeroExt对象:**
- 功能：零扩展
- 参数：
  - a: 输入数据
  - len: 目标位宽
- 逻辑：当目标位宽大于输入时，用0填充

**ALUOpType对象:**
- 定义了所有支持的ALU操作编码
- 提供操作类型判断方法（如isWordOp, isBranch等）

## 模块-LSU (Load-Store Unit)

### 概述
LSU模块是处理器中负责处理加载(Load)和存储(Store)指令的功能单元。它负责与内存子系统交互，处理不同位宽的加载/存储操作，包括有符号和无符号扩展，并支持基本的原子操作。

### 参数
- `XLen`: 数据位宽(通过HasNPCParameter trait提供)
- 支持的操作类型定义在LSUOpType对象中，包括:
  - 加载指令: lb, lh, lw, ld, lbu, lhu, lwu
  - 存储指令: sb, sh, sw, sd
  - 原子操作: lr, sc, amoswap, amoadd等

### 输入/输出接口
#### 输入接口(LSUIO):
- `in`: 功能单元输入(继承自FunctionUnitIO)
  - `valid`: 输入有效信号
  - `bits`: 包含源操作数srca和srcb
- `from_mem`: 来自内存的数据
  - `data`: 从内存读取的数据
- `ctrl`: 控制信号
  - `fuOpType`: 功能单元操作类型(LSUOpType中的定义)
  - `MemWrite`: 内存写使能
- `data`: 数据源
  - `rfSrc2`: 寄存器文件源操作数2(用于存储指令的数据)

#### 输出接口:
- `out`: 功能单元输出
  - `valid`: 输出有效信号(直接传递输入valid)
  - `bits`: 处理后的数据(加载结果或0)
- `to_mem`: 到内存的接口
  - `data`: 要写入内存的数据
  - `addr`: 内存地址(计算为srca + srcb)
  - `Wmask`: 写掩码(根据操作类型确定)
  - `MemWrite`: 内存写使能信号

### 内部逻辑
1. **地址计算**:
   - 内存地址通过将输入操作数srca和srcb相加得到: `io.to_mem.addr := io.in.bits.srca + io.in.bits.srcb`

2. **写掩码生成**:
   - 根据操作类型生成不同的写掩码:
     - sb(存储字节): "b00"
     - sh(存储半字): "b01"
     - sw(存储字): "b10"
     - sd(存储双字): "b11"

3. **数据加载处理**:
   - 根据不同的加载指令类型对内存返回数据进行处理:
     - 有符号加载(lb, lh, lw): 使用符号扩展(SignExt)
     - 无符号加载(lbu, lhu, lwu): 使用零扩展(ZeroExt)
   - 从内存读取的数据被分割和扩展为XLen位宽

4. **控制信号传递**:
   - 内存写使能信号直接传递: `io.to_mem.MemWrite := io.ctrl.MemWrite`
   - 输出valid信号直接传递输入valid: `io.out.valid := io.in.valid`
   - 输入ready信号固定为true: `io.in.ready := true.B`

## 模块-CSR (Control and Status Register) 模块

### 概述
CSR模块是RISC-V处理器中用于管理和控制处理器状态的核心模块。它负责处理控制状态寄存器(CSR)的读写操作、异常处理和特权模式切换。该模块实现了RISC-V特权架构中定义的机器模式(M-mode)相关CSR，并支持基本的CSR操作指令和异常处理机制。

### 参数
- `XLen`: 数据位宽(32或64位)，决定寄存器的宽度和某些CSR的初始值

### 输入/输出接口
#### 输入接口
- `cfIn`: 控制流信息，包含当前指令和PC值
- `in.valid`: 输入有效信号
- `in.bits.srca`: 源操作数A
- `in.bits.srcb`: 源操作数B(CSR地址索引)
- `in.bits.fuOpType`: 功能操作类型(来自CSROpType)

#### 输出接口
- `jmp`: 跳转信号，指示是否需要跳转
- `out.valid`: 输出有效信号
- `out.bits`: 输出数据(CSR读取值或跳转地址)
- `in.ready`: 输入就绪信号(固定为true)

### 内部逻辑
1. **CSR寄存器组**:
   - `mtvec`: 机器模式陷阱向量基址寄存器
   - `mcause`: 机器模式陷阱原因寄存器
   - `mepc`: 机器模式异常程序计数器
   - `mstatus`: 机器模式状态寄存器(初始值根据XLEN不同而不同)

2. **CSR操作类型(CSROpType)**:
   - `jmp`: CSR跳转操作
   - `wrt`: CSR写操作
   - `set`: CSR置位操作
   - `clr`: CSR清除操作
   - 以及对应的立即数版本(`wrti`,`seti`,`clri`)

3. **特殊指令检测**:
   - `isEcall`: 检测到环境调用指令
   - `isMret`: 检测到机器模式返回指令
   - `isEbreak`: 检测到断点指令

4. **CSR读写逻辑**:
   - 根据`srcb`(CSR地址)选择要访问的CSR寄存器
   - 根据`fuOpType`决定操作类型(写/置位/清除)
   - 在写使能(`csrWen`)有效时更新对应CSR

5. **异常处理逻辑**:
   - 当发生`ecall`时:
     - 设置`mcause`为机器模式环境调用异常代码
     - 将当前PC保存到`mepc`
   - 当执行`mret`时返回`mepc`中保存的地址

6. **输出逻辑**:
   - 正常CSR操作时输出选择的CSR值
   - `ecall`时输出`mtvec`(陷阱处理入口)
   - `mret`时输出`mepc`(返回地址)
   - `jmp`信号在需要跳转时置位

7. **CSR地址常量**:
   - 定义了所有标准RISC-V CSR地址(机器模式、用户模式、监管员模式)
   - 包括状态寄存器、陷阱向量、异常处理相关CSR等

8. **异常和中断优先级**:
   - 定义了异常类型代码和优先级
   - 定义了中断类型和优先级


## 模块-WBU (Write Back Unit)

### 概述
WBU模块是处理器流水线中的写回阶段，负责将执行阶段(EXU)的结果写回到寄存器文件中。该模块接收来自EXU的数据，根据控制信号选择正确的写回数据源，并通过握手协议将数据传递到寄存器文件模块。

### 参数
无显式参数，但依赖于父类NPCModule和NPCBundle中定义的配置(如XLen表示数据位宽)。

### 输入/输出接口
#### 输入接口
- `from_exu`: 来自执行单元的Decoupled接口，包含:
  - `ctrl`: 控制信号(rd寄存器号、rfWen寄存器写使能、ResSrc结果选择信号)
  - `data`: 数据信号(ALU结果、内存读取数据、CSR读取数据)
  - `cf`: 控制流信息(传递给提交阶段)

#### 输出接口
- `to_reg`: 到寄存器文件的Decoupled接口，包含:
  - `rd`: 目标寄存器号(5位)
  - `Res`: 要写入的数据(XLen位)
  - `RegWrite`: 寄存器写使能信号
- `to_commit`: 输出到提交阶段的控制流信息

    val io = IO(new Bundle{
        val from_exu = Flipped(Decoupled(new ExuToWbuIO))
        val to_reg = Decoupled(new WbuToRegIO)

        val to_commit = Output(new CtrlFlow) //输出到提交阶段的控制流信息


    })

class WbuToRegIO extends NPCBundle {

        val rd = UInt(5.W)
        val Res = UInt(XLen.W)
        val RegWrite = Bool()
}
class ExuToWbuIO extends NPCBundle {


    val cf      = new CtrlFlow
    val ctrl    = new CtrlSignal
    val data    = new DataSrc

}
class CtrlFlow extends NPCBundle { // Signal bundle describing the instruction characteristics of the current stage
val inst = UInt(32.W) // Current control flow instruction
val pc = UInt(XLen.W) // Instruction address
val next_pc = UInt(XLen.W) // The address of the next instruction is generated by the branch predictor and may not be correct before being checked and corrected by the backend
val isBranch = Bool() // Is it a branch instruction?
}

class CtrlSignal extends NPCBundle { // Control signal bundle

val MemWrite = Bool()
val ResSrc = UInt()

val fuSrc1Type = FuSrcType()
val fuSrc2Type = FuSrcType()
val fuType = FuType()
val fuOpType = FuOpType()
val rs1 = UInt(5.W)
val rs2 = UInt(5.W)
val rfWen = Bool()
val rd = UInt(5.W)

}

class DataSrc extends NPCBundle {
val fuSrc1 = UInt(XLen.W) // Functional unit operand
val fuSrc2 = UInt(XLen.W)
val imm = UInt(XLen.W) // immediate value

val Alu0Res = Decoupled(UInt(XLen.W)) // ALU calculation result
val data_from_mem = UInt(XLen.W) // data read from memory
val csrRdata = UInt(XLen.W) // data read from CSR
val rfSrc1 = UInt(XLen.W) // data read from register
val rfSrc2 = UInt(XLen.W)

}
### 内部逻辑
1. **握手协议处理**:
   - 使用`HandShakeDeal`函数处理`from_exu`和`to_reg`之间的握手信号
   - `AnyInvalidCondition`目前硬编码为false.B(待后续添加实际条件)
   直接调用 HandShakeDeal(io.from_exu, io.to_reg, AnyInvalidCondition)

2. **数据选择逻辑**:
   - 根据`ResSrc`信号选择写回的DataSrc成员:
     - `0`: ALU计算结果(`ALURes`)
     - `1`: 内存读取数据(`data_from_mem`)
     - `2`: CSR读取数据(`csrRdata`)
   - 默认选择0.U(未匹配时)

3. **输出生成**:
   - `to_reg.rd`: 直接传递来自EXU的目标寄存器号
   - `to_reg.RegWrite`: 由EXU的`ctrl.rfWen`和当前输出的`io.to_reg.valid`信号共同决定
   - `to_commit`: 直接传递来自EXU的 cf

## 辅助模块-StageConnect

### 概述
StageConnect 是一个用于连接**两个不同模块**DecoupledIO 接口的 Chisel 实用模块，主要用于流水线（pipeline）架构中的阶段间数据传输。它实现了流水线寄存器（pipeline register）的功能，确保数据在流水线阶段间正确传递，同时支持流水线刷新（flush）和生产者触发（producer fire）控制。

### 参数
- `T <: Data`: 泛型参数，指定 DecoupledIO 接口中传输的数据类型。

### 输入/输出接口
- **输入接口**:
  - `left: DecoupledIO[T]`: 上游模块的输出接口（生产者端）。
    - `left.valid`: 上游模块输出的有效信号。
    - `left.bits`: 上游模块输出的数据。
  - `right_producer_fire: Bool`: 生产者触发信号，用于在特定条件下清除流水线寄存器的有效位。
  - `isFlush: Bool` (可选，默认 `false.B`): 流水线刷新信号，用于强制清除流水线寄存器的有效位。

- **输出接口**:
  - `right: DecoupledIO[T]`: 下游模块的输入接口（消费者端）。
    - `right.valid`: 下游模块输入的有效信号（经过寄存器缓冲）。
    - `right.bits`: 下游模块输入的数据（经过寄存器缓冲）。
  - `left.ready`: 上游模块的 ready 信号，直接连接到下游模块的 ready 信号。

### 内部逻辑
1. **流水线寄存器架构**:
   - 模块当前仅支持 `"pipeline"` 架构（硬编码）。
   - 使用一个寄存器 `valid` 存储下游模块的有效信号状态，初始化为 `false.B`。

2. **流水线刷新（flush）**:
   - 当 `isFlush` 为 `true` 时，强制将 `valid` 寄存器置为 `false.B`，清除当前数据。

3. **流水线数据传递**:
   - 当 `right.ready` 为 `true` 且 `left.valid` 为 `true` 时，`valid` 寄存器更新为 `left.valid`（即捕获新数据）。
   - 当 `right_producer_fire` 为 `true` 时，`valid` 寄存器被清除（`false.B`），表示生产者已完成当前操作。
   - 其他情况下，`valid` 寄存器保持当前值。

4. **数据通路**:
   - `right.valid` 直接连接到 `valid` 寄存器的输出。
   - `left.ready` 直接连接到 `right.ready`，实现反压传递。
   - `right.bits` 通过 `RegEnable` 寄存器缓冲 `left.bits`，仅在 `left.valid && right.ready` 时更新数据。


## 辅助模块-HandShakeDeal

### 概述
HandShakeDeal 是一个用于协调**同一个模块内**两个 DecoupledIO 接口（消费者和生产者）之间握手信号的模块。用于流水线（pipeline）架构中的**阶段内**(与`StageConnect`模块区别)握手信号控制。它根据输入的控制条件（AnyInvalidCondition 和 AnyStopCondition）来管理数据流的传输，确保在特定条件下消费者可以接收数据或生产者可以发送数据。

### 参数
- `T1`: 消费者接口的数据类型，必须是 `Data` 的子类。
- `T2`: 生产者接口的数据类型，必须是 `Data` 的子类。

### 输入/输出接口
- **输入接口**:
  - `consumer: DecoupledIO[T1]`: 消费者接口，包含 `valid` 和 `ready` 信号。
    - `consumer.valid`: 表示消费者是否有有效数据。
    - `consumer.ready`: 由模块生成，表示消费者是否可以接收数据。
  - `producer: DecoupledIO[T2]`: 生产者接口，包含 `valid` 和 `ready` 信号。
    - `producer.valid`: 由模块生成，表示生产者是否有有效数据。
    - `producer.ready`: 由外部驱动，表示生产者是否可以发送数据。
  - `AnyInvalidCondition: Bool`: 外部输入的控制信号，当为 `false` 时允许生产者发送数据。
  - `AnyStopCondition: Bool` (默认值: `false.B`): 外部输入的控制信号，当为 `false` 时允许消费者接收数据。

- **输出逻辑**:
  - `consumer.ready`: 由模块生成，表示消费者是否可以接收数据。
  - `producer.valid`: 由模块生成，表示生产者是否可以发送数据。

### 内部逻辑
1. **消费者就绪信号 (`consumer.ready`)**:
   - 当 `consumer.valid` 为 `false` 或者生产者成功发送数据（`producer.fire` 为 `true`）时，且 `AnyStopCondition` 为 `false` 时，`consumer.ready` 被置为 `true`。
   - 逻辑表达式:  
     ```scala
     consumer.ready := ((false.B === consumer.valid) || producer.fire) && (false.B === AnyStopCondition)
     ```

2. **生产者有效信号 (`producer.valid`)**:
   - 当 `consumer.valid` 为 `true` 且 `AnyInvalidCondition` 为 `false` 时，`producer.valid` 被置为 `true`。
   - 逻辑表达式:  
     ```scala
     producer.valid := consumer.valid && (false.B === AnyInvalidCondition)
     ```

### 功能说明
- 该模块主要用于在满足特定条件时，控制消费者和生产者之间的数据流。
- 当 `AnyStopCondition` 为 `false` 时，消费者可以准备接收数据（`consumer.ready` 为 `true`）。
- 当 `AnyInvalidCondition` 为 `false` 且消费者有有效数据时，生产者可以发送数据（`producer.valid` 为 `true`）。
- 模块的设计目的是在握手协议中插入额外的控制逻辑，以适应更复杂的数据流管理需求。
