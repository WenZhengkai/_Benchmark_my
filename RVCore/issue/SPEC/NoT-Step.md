
## 步骤描述

- 1 Framework与Coding Tasks初始化， 将去除Design Task的Spec导入`s1 Framework`; 将完整Spec导入`s2 Coding Tasks`; 创建变量 Finished Tasks；
- 2 `s1 Framework`作为prompt输入给LLM，得到框架代码
- 3 框架代码添加到变量Finished Tasks
- 4 设置任务分组，任务总数为Y，计算任务分组数为X=Y/2, 非整数情况则向上取整。
- 5 从Task 1开始，根据当前的任务分组步长X，设置N=1， M=1+X -1；执行M到N的Task；设置Coding Tasks中的N,M;导入Finished Tasks。
- 6 `s2 Coding Tasks`作为prompt输入给LLM，得到代码；识别代码中的注释范围，抽取后添加变量Finished Tasks相应位置
- 7 重复第5步和第6步，以X为步长，依次设置N与M，M最大只能等于Y，当M=Y时，即完成所有Task时，结束循环。
- 8 导出最终的变量`Finished Tasks`作为输出结果


## NoT模板
### s1 Framework
Please act as a professional Chisel designer. Give me the Chisel code as #### Demand and Templete.
````
Spec without Tasks
````

#### Demand
Output Framework of Chisel code, include packages import, Module definition, IO definition.
Other part must be omitted using annote `// Tasks omitted`

#### Templete
``` scala
import chisel3._
import chisel3.util._
// other packages
class xxx extends Module {
    val io = IO(...)
    // Tasks omitted
}
```

### s2 Coding Tasks
Please act as a professional Chisel designer. Give me the Chisel code as #### Finished Tasks and Demand.
````
Spec with Task
````

#### Finished Tasks
``` scala

```

#### Demand
Output Task `N`-`M` of Chisel code, warpped in `//<<< Task n ` and `//>>> Task n end`.
Other part of Tasks must be omitted using annote `// Other Tasks omitted`


## NoT示例
## NoT multi steps record 2
### s1 Framework
Please act as a professional Chisel designer. Give me the Chisel code as #### Demand and Templete.
````
# Specification
## Overview
Implement a module of a 64-bit ripple carry adder, which includes several registers to enable the pipeline stages. The output result is available on the result port, and the o_en = 1 indicates the availability of the result.

## Module name 
    AdderPipe64bit               
## Input ports
    i_en: Enable signal for addition operation
    adda: 64-bit input operand A
    addb: 64-bit input operand B
   
## Output ports
    result: 65-bit output representing the sum of adda and addb.
    o_en: Output enable signal.   
````

#### Demand
Output Framework of Chisel code, include packages import, Module definition, IO definition.
Other part must be omitted using annote `// Tasks omitted`

#### Templete
``` scala
import chisel3._
import chisel3.util._
// other packages
class xxx extends Module {
    val io = IO(...)
    // Tasks omitted
}
```

#### output
```scala
import chisel3._
import chisel3.util._

class AdderPipe64bit extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // Tasks omitted
}
```

### s2 Coding Tasks
Please act as a professional Chisel designer. Give me the Chisel code as #### Finished Tasks and Demand.
````
# Specification
## Overview
Implement a module of a 64-bit ripple carry adder, which includes several registers to enable the pipeline stages. The output result is available on the result port, and the o_en = 1 indicates the availability of the result.

## Module name 
    AdderPipe64bit               
## Input ports
    i_en: Enable signal for addition operation
    adda: 64-bit input operand A
    addb: 64-bit input operand B
   
## Output ports
    result: 65-bit output representing the sum of adda and addb.
    o_en: Output enable signal.   

## Design Task


### Task 1: **Input Registering and Enable Pipeline**
**Objective:** Capture input operands and synchronize enable signals with pipeline stages  
**Step:**  
1. Create 64-bit registers for `adda` and `addb` using `RegEnable` triggered by `i_en`  
2. Create a 4-stage enable shift register (`en_pipeline`) to track pipeline validity  
3. Connect `en_pipeline(0)` to `i_en` and shift values every clock cycle  

---

### Task 2: **16-bit Ripple Carry Adder (RCA) Implementation**
**Objective:** Create reusable 16-bit RCA logic for pipeline stages  
**Step:**  
1. Design `RCA16` module with:  
   - Inputs: `a` (16-bit), `b` (16-bit), `cin` (1-bit)  
   - Outputs: `sum` (16-bit), `cout` (1-bit)  
2. Implement ripple carry logic using full-adder chaining  

---

### Task 3: **Pipeline Stage Implementation**
**Objective:** Process 16-bit slices sequentially with registered propagation  
**Step:**  
1. For each pipeline stage (1-4):  
   - Slice inputs: `adda_reg[stage*16-1 : (stage-1)*16]`  
   - Instantiate `RCA16` with previous stage's carry  
   - Add registers for:  
     - Partial sum segment (16-bit)  
     - Propagated carry (1-bit)  
     - Enable signal (from `en_pipeline`)  

---

### Task 4: **Result Aggregation Logic**
**Objective:** Combine partial sums and final carry into 65-bit result  
**Step:**  
1. Create concatenation register for final output:  
   ```scala  
   result_reg := Cat(final_carry, stage4_sum, stage3_sum, stage2_sum, stage1_sum)
   ```  
2. Connect `result_reg` to output port `result`  

---

### Task 5: **Output Enable Generation**
**Objective:** Synchronize output validity signal with pipeline latency  
**Step:**  
1. Connect `o_en` to the last stage of enable pipeline:  
   ```scala  
   o_en := en_pipeline(3)
   ```  
2. Ensure reset synchronization for enable pipeline  

---

````

#### Finished Tasks
``` scala
import chisel3._
import chisel3.util._

class AdderPipe64bit extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // Tasks omitted
}
```

#### Demand
Output Task `N`-`M` of Chisel code, warpped in `//<<< Task n //>>> Task n end`.
Other part of Tasks must be omitted using annote `// Other Tasks omitted`




### s2 Coding Tasks 1-2
Please act as a professional Chisel designer. Give me the Chisel code as #### Finished Tasks and Demand.

````
# Specification
## Overview
Implement a module of a 64-bit ripple carry adder, which includes several registers to enable the pipeline stages. The output result is available on the result port, and the o_en = 1 indicates the availability of the result.

## Module name 
    AdderPipe64bit               
## Input ports
    i_en: Enable signal for addition operation
    adda: 64-bit input operand A
    addb: 64-bit input operand B
   
## Output ports
    result: 65-bit output representing the sum of adda and addb.
    o_en: Output enable signal.   

## Design Task


### Task 1: **Input Registering and Enable Pipeline**
**Objective:** Capture input operands and synchronize enable signals with pipeline stages  
**Step:**  
1. Create 64-bit registers for `adda` and `addb` using `RegEnable` triggered by `i_en`  
2. Create a 4-stage enable shift register (`en_pipeline`) to track pipeline validity  
3. Connect `en_pipeline(0)` to `i_en` and shift values every clock cycle  

---

### Task 2: **16-bit Ripple Carry Adder (RCA) Implementation**
**Objective:** Create reusable 16-bit RCA logic for pipeline stages  
**Step:**  
1. Design `RCA16` module with:  
   - Inputs: `a` (16-bit), `b` (16-bit), `cin` (1-bit)  
   - Outputs: `sum` (16-bit), `cout` (1-bit)  
2. Implement ripple carry logic using full-adder chaining  

---

### Task 3: **Pipeline Stage Implementation**
**Objective:** Process 16-bit slices sequentially with registered propagation  
**Step:**  
1. For each pipeline stage (1-4):  
   - Slice inputs: `adda_reg[stage*16-1 : (stage-1)*16]`  
   - Instantiate `RCA16` with previous stage's carry  
   - Add registers for:  
     - Partial sum segment (16-bit)  
     - Propagated carry (1-bit)  
     - Enable signal (from `en_pipeline`)  

---

### Task 4: **Result Aggregation Logic**
**Objective:** Combine partial sums and final carry into 65-bit result  
**Step:**  
1. Create concatenation register for final output:  
   ```scala  
   result_reg := Cat(final_carry, stage4_sum, stage3_sum, stage2_sum, stage1_sum)
   ```  
2. Connect `result_reg` to output port `result`  

---

### Task 5: **Output Enable Generation**
**Objective:** Synchronize output validity signal with pipeline latency  
**Step:**  
1. Connect `o_en` to the last stage of enable pipeline:  
   ```scala  
   o_en := en_pipeline(3)
   ```  
2. Ensure reset synchronization for enable pipeline  

---

````

#### Finished Tasks
``` scala
import chisel3._
import chisel3.util._

class AdderPipe64bit extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // Tasks omitted
}
```

#### Demand
Output Task `1`-`2` of Chisel code, warpped in `//<<< Task n //>>> Task n end`.
Other part of Tasks must be omitted using annote `// Other Tasks omitted`

#### Output
```scala
import chisel3._
import chisel3.util._

class AdderPipe64bit extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // <<< Task 1 >>>
  // Input Registering and Enable Pipeline

  // Create 64-bit registers for `adda` and `addb` using `RegEnable` triggered by `i_en`
  val adda_reg = RegEnable(io.adda, 0.U(64.W), io.i_en)
  val addb_reg = RegEnable(io.addb, 0.U(64.W), io.i_en)

  // Create a 4-stage enable shift register (`en_pipeline`) to track pipeline validity
  val en_pipeline = RegInit(VecInit(Seq.fill(4)(false.B)))

  // Connect `en_pipeline(0)` to `i_en` and shift values every clock cycle
  when(io.i_en) {
    en_pipeline(0) := true.B
  }
  .otherwise {
    en_pipeline(0) := false.B
  }

  for (i <- 1 until 4) {
    en_pipeline(i) := en_pipeline(i - 1)
  }
  // <<< Task 1 end >>>

  // <<< Task 2 >>>
  // 16-bit Ripple Carry Adder (RCA) Implementation

  // Design `RCA16` module
  class RCA16 extends Module {
    val io = IO(new Bundle {
      val a = Input(UInt(16.W))
      val b = Input(UInt(16.W))
      val cin = Input(Bool())
      val sum = Output(UInt(16.W))
      val cout = Output(Bool())
    })

    // Implement ripple carry logic using full-adder chaining
    val (sum, carry) = io.a.zip(io.b).foldLeft((0.U(16.W), io.cin)) {
      case ((s, c), (a, b)) =>
        val fullAdderSum = a ^ b ^ c
        val fullAdderCarry = (a & b) | (b & c) | (a & c)
        (Cat(fullAdderSum, s(15, 1)), fullAdderCarry)
    }
    io.sum := sum
    io.cout := carry
  }

  // <<< Task 2 end >>>

  // Other Tasks omitted
}
```


### s2 Coding Tasks 3-4
Please act as a professional Chisel designer. Give me the Chisel code as #### Finished Tasks and Demand.
````
# Specification
## Overview
Implement a module of a 64-bit ripple carry adder, which includes several registers to enable the pipeline stages. The output result is available on the result port, and the o_en = 1 indicates the availability of the result.

## Module name 
    AdderPipe64bit               
## Input ports
    i_en: Enable signal for addition operation
    adda: 64-bit input operand A
    addb: 64-bit input operand B
   
## Output ports
    result: 65-bit output representing the sum of adda and addb.
    o_en: Output enable signal.   

## Design Task


### Task 1: **Input Registering and Enable Pipeline**
**Objective:** Capture input operands and synchronize enable signals with pipeline stages  
**Step:**  
1. Create 64-bit registers for `adda` and `addb` using `RegEnable` triggered by `i_en`  
2. Create a 4-stage enable shift register (`en_pipeline`) to track pipeline validity  
3. Connect `en_pipeline(0)` to `i_en` and shift values every clock cycle  

---

### Task 2: **16-bit Ripple Carry Adder (RCA) Implementation**
**Objective:** Create reusable 16-bit RCA logic for pipeline stages  
**Step:**  
1. Design `RCA16` module with:  
   - Inputs: `a` (16-bit), `b` (16-bit), `cin` (1-bit)  
   - Outputs: `sum` (16-bit), `cout` (1-bit)  
2. Implement ripple carry logic using full-adder chaining  

---

### Task 3: **Pipeline Stage Implementation**
**Objective:** Process 16-bit slices sequentially with registered propagation  
**Step:**  
1. For each pipeline stage (1-4):  
   - Slice inputs: `adda_reg[stage*16-1 : (stage-1)*16]`  
   - Instantiate `RCA16` with previous stage's carry  
   - Add registers for:  
     - Partial sum segment (16-bit)  
     - Propagated carry (1-bit)  
     - Enable signal (from `en_pipeline`)  

---

### Task 4: **Result Aggregation Logic**
**Objective:** Combine partial sums and final carry into 65-bit result  
**Step:**  
1. Create concatenation register for final output:  
   ```scala  
   result_reg := Cat(final_carry, stage4_sum, stage3_sum, stage2_sum, stage1_sum)
   ```  
2. Connect `result_reg` to output port `result`  

---

### Task 5: **Output Enable Generation**
**Objective:** Synchronize output validity signal with pipeline latency  
**Step:**  
1. Connect `o_en` to the last stage of enable pipeline:  
   ```scala  
   o_en := en_pipeline(3)
   ```  
2. Ensure reset synchronization for enable pipeline  

---

````

#### Finished Tasks
``` scala
import chisel3._
import chisel3.util._

class AdderPipe64bit extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // <<< Task 1 >>>
  // Input Registering and Enable Pipeline

  // Create 64-bit registers for `adda` and `addb` using `RegEnable` triggered by `i_en`
  val adda_reg = RegEnable(io.adda, 0.U(64.W), io.i_en)
  val addb_reg = RegEnable(io.addb, 0.U(64.W), io.i_en)

  // Create a 4-stage enable shift register (`en_pipeline`) to track pipeline validity
  val en_pipeline = RegInit(VecInit(Seq.fill(4)(false.B)))

  // Connect `en_pipeline(0)` to `i_en` and shift values every clock cycle
  when(io.i_en) {
    en_pipeline(0) := true.B
  }
  .otherwise {
    en_pipeline(0) := false.B
  }

  for (i <- 1 until 4) {
    en_pipeline(i) := en_pipeline(i - 1)
  }
  // <<< Task 1 end >>>

  // <<< Task 2 >>>
  // 16-bit Ripple Carry Adder (RCA) Implementation

  // Design `RCA16` module
  class RCA16 extends Module {
    val io = IO(new Bundle {
      val a = Input(UInt(16.W))
      val b = Input(UInt(16.W))
      val cin = Input(Bool())
      val sum = Output(UInt(16.W))
      val cout = Output(Bool())
    })

    // Implement ripple carry logic using full-adder chaining
    val (sum, carry) = io.a.zip(io.b).foldLeft((0.U(16.W), io.cin)) {
      case ((s, c), (a, b)) =>
        val fullAdderSum = a ^ b ^ c
        val fullAdderCarry = (a & b) | (b & c) | (a & c)
        (Cat(fullAdderSum, s(15, 1)), fullAdderCarry)
    }
    io.sum := sum
    io.cout := carry
  }

  // <<< Task 2 end >>>

  // Other Tasks omitted
}
```

#### Demand
Output Task `3`-`4` of Chisel code, warpped in `//<<< Task n //>>> Task n end`.
Other part of Tasks must be omitted using annote `// Other Tasks omitted`
#### Output
```scala
import chisel3._
import chisel3.util._

class AdderPipe64bit extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // Other Tasks omitted

  class RCA16 extends Module {
    val io = IO(new Bundle {
      val a = Input(UInt(16.W))
      val b = Input(UInt(16.W))
      val cin = Input(Bool())
      val sum = Output(UInt(16.W))
      val cout = Output(Bool())
    })

    // Implement ripple carry logic using full-adder chaining
    val (sum, carry) = io.a.zip(io.b).foldLeft((0.U(16.W), io.cin)) {
      case ((s, c), (a, b)) =>
        val fullAdderSum = a ^ b ^ c
        val fullAdderCarry = (a & b) | (b & c) | (a & c)
        (Cat(fullAdderSum, s(15, 1)), fullAdderCarry)
    }
    io.sum := sum
    io.cout := carry
  }

  //<<< Task 3 >>>
  // Pipeline Stage Implementation

  // Instantiate RCA16s for each 16-bit segment and register the outputs
  val stage1 = Module(new RCA16())
  stage1.io.a := adda_reg(15, 0)
  stage1.io.b := addb_reg(15, 0)
  stage1.io.cin := false.B

  val stage1_sum_reg  = RegEnable(stage1.io.sum, 0.U(16.W), en_pipeline(0))
  val stage1_cout_reg = RegEnable(stage1.io.cout, false.B, en_pipeline(0))

  val stage2 = Module(new RCA16())
  stage2.io.a := adda_reg(31, 16)
  stage2.io.b := addb_reg(31, 16)
  stage2.io.cin := stage1_cout_reg

  val stage2_sum_reg  = RegEnable(stage2.io.sum, 0.U(16.W), en_pipeline(1))
  val stage2_cout_reg = RegEnable(stage2.io.cout, false.B, en_pipeline(1))

  val stage3 = Module(new RCA16())
  stage3.io.a := adda_reg(47, 32)
  stage3.io.b := addb_reg(47, 32)
  stage3.io.cin := stage2_cout_reg

  val stage3_sum_reg  = RegEnable(stage3.io.sum, 0.U(16.W), en_pipeline(2))
  val stage3_cout_reg = RegEnable(stage3.io.cout, false.B, en_pipeline(2))

  val stage4 = Module(new RCA16())
  stage4.io.a := adda_reg(63, 48)
  stage4.io.b := addb_reg(63, 48)
  stage4.io.cin := stage3_cout_reg

  val stage4_sum_reg  = RegEnable(stage4.io.sum, 0.U(16.W), en_pipeline(3))
  val stage4_cout_reg = RegEnable(stage4.io.cout, false.B, en_pipeline(3))

  // <<< Task 3 end >>>

  //<<< Task 4 >>>
  // Result Aggregation Logic

  // Create concatenation register for final output
  io.result := Cat(stage4_cout_reg, stage4_sum_reg, stage3_sum_reg, stage2_sum_reg, stage1_sum_reg)
  // <<< Task 4 end >>>

  // Other Tasks omitted
}
```


### s2 Coding Tasks 5
Please act as a professional Chisel designer. Give me the Chisel code as #### Finished Tasks and Demand.
````
# Specification
## Overview
Implement a module of a 64-bit ripple carry adder, which includes several registers to enable the pipeline stages. The output result is available on the result port, and the o_en = 1 indicates the availability of the result.

## Module name 
    AdderPipe64bit               
## Input ports
    i_en: Enable signal for addition operation
    adda: 64-bit input operand A
    addb: 64-bit input operand B
   
## Output ports
    result: 65-bit output representing the sum of adda and addb.
    o_en: Output enable signal.   

## Design Task


### Task 1: **Input Registering and Enable Pipeline**
**Objective:** Capture input operands and synchronize enable signals with pipeline stages  
**Step:**  
1. Create 64-bit registers for `adda` and `addb` using `RegEnable` triggered by `i_en`  
2. Create a 4-stage enable shift register (`en_pipeline`) to track pipeline validity  
3. Connect `en_pipeline(0)` to `i_en` and shift values every clock cycle  

---

### Task 2: **16-bit Ripple Carry Adder (RCA) Implementation**
**Objective:** Create reusable 16-bit RCA logic for pipeline stages  
**Step:**  
1. Design `RCA16` module with:  
   - Inputs: `a` (16-bit), `b` (16-bit), `cin` (1-bit)  
   - Outputs: `sum` (16-bit), `cout` (1-bit)  
2. Implement ripple carry logic using full-adder chaining  

---

### Task 3: **Pipeline Stage Implementation**
**Objective:** Process 16-bit slices sequentially with registered propagation  
**Step:**  
1. For each pipeline stage (1-4):  
   - Slice inputs: `adda_reg[stage*16-1 : (stage-1)*16]`  
   - Instantiate `RCA16` with previous stage's carry  
   - Add registers for:  
     - Partial sum segment (16-bit)  
     - Propagated carry (1-bit)  
     - Enable signal (from `en_pipeline`)  

---

### Task 4: **Result Aggregation Logic**
**Objective:** Combine partial sums and final carry into 65-bit result  
**Step:**  
1. Create concatenation register for final output:  
   ```scala  
   result_reg := Cat(final_carry, stage4_sum, stage3_sum, stage2_sum, stage1_sum)
   ```  
2. Connect `result_reg` to output port `result`  

---

### Task 5: **Output Enable Generation**
**Objective:** Synchronize output validity signal with pipeline latency  
**Step:**  
1. Connect `o_en` to the last stage of enable pipeline:  
   ```scala  
   o_en := en_pipeline(3)
   ```  
2. Ensure reset synchronization for enable pipeline  

---

````

#### Finished Tasks
``` scala
import chisel3._
import chisel3.util._

class AdderPipe64bit extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // <<< Task 1 >>>
  // Input Registering and Enable Pipeline

  // Create 64-bit registers for `adda` and `addb` using `RegEnable` triggered by `i_en`
  val adda_reg = RegEnable(io.adda, 0.U(64.W), io.i_en)
  val addb_reg = RegEnable(io.addb, 0.U(64.W), io.i_en)

  // Create a 4-stage enable shift register (`en_pipeline`) to track pipeline validity
  val en_pipeline = RegInit(VecInit(Seq.fill(4)(false.B)))

  // Connect `en_pipeline(0)` to `i_en` and shift values every clock cycle
  when(io.i_en) {
    en_pipeline(0) := true.B
  }
  .otherwise {
    en_pipeline(0) := false.B
  }

  for (i <- 1 until 4) {
    en_pipeline(i) := en_pipeline(i - 1)
  }
  // <<< Task 1 end >>>

  // <<< Task 2 >>>
  // 16-bit Ripple Carry Adder (RCA) Implementation

  // Design `RCA16` module
  class RCA16 extends Module {
    val io = IO(new Bundle {
      val a = Input(UInt(16.W))
      val b = Input(UInt(16.W))
      val cin = Input(Bool())
      val sum = Output(UInt(16.W))
      val cout = Output(Bool())
    })

    // Implement ripple carry logic using full-adder chaining
    val (sum, carry) = io.a.zip(io.b).foldLeft((0.U(16.W), io.cin)) {
      case ((s, c), (a, b)) =>
        val fullAdderSum = a ^ b ^ c
        val fullAdderCarry = (a & b) | (b & c) | (a & c)
        (Cat(fullAdderSum, s(15, 1)), fullAdderCarry)
    }
    io.sum := sum
    io.cout := carry
  }

  // <<< Task 2 end >>>

    //<<< Task 3 >>>
  // Pipeline Stage Implementation

  // Instantiate RCA16s for each 16-bit segment and register the outputs
  val stage1 = Module(new RCA16())
  stage1.io.a := adda_reg(15, 0)
  stage1.io.b := addb_reg(15, 0)
  stage1.io.cin := false.B

  val stage1_sum_reg  = RegEnable(stage1.io.sum, 0.U(16.W), en_pipeline(0))
  val stage1_cout_reg = RegEnable(stage1.io.cout, false.B, en_pipeline(0))

  val stage2 = Module(new RCA16())
  stage2.io.a := adda_reg(31, 16)
  stage2.io.b := addb_reg(31, 16)
  stage2.io.cin := stage1_cout_reg

  val stage2_sum_reg  = RegEnable(stage2.io.sum, 0.U(16.W), en_pipeline(1))
  val stage2_cout_reg = RegEnable(stage2.io.cout, false.B, en_pipeline(1))

  val stage3 = Module(new RCA16())
  stage3.io.a := adda_reg(47, 32)
  stage3.io.b := addb_reg(47, 32)
  stage3.io.cin := stage2_cout_reg

  val stage3_sum_reg  = RegEnable(stage3.io.sum, 0.U(16.W), en_pipeline(2))
  val stage3_cout_reg = RegEnable(stage3.io.cout, false.B, en_pipeline(2))

  val stage4 = Module(new RCA16())
  stage4.io.a := adda_reg(63, 48)
  stage4.io.b := addb_reg(63, 48)
  stage4.io.cin := stage3_cout_reg

  val stage4_sum_reg  = RegEnable(stage4.io.sum, 0.U(16.W), en_pipeline(3))
  val stage4_cout_reg = RegEnable(stage4.io.cout, false.B, en_pipeline(3))

  // <<< Task 3 end >>>

  //<<< Task 4 >>>
  // Result Aggregation Logic

  // Create concatenation register for final output
  io.result := Cat(stage4_cout_reg, stage4_sum_reg, stage3_sum_reg, stage2_sum_reg, stage1_sum_reg)
  // <<< Task 4 end >>>

  // Other Tasks omitted
}
```

#### Demand
Output Task `5` of Chisel code, warpped in `//<<< Task n //>>> Task n end`.
Other part of Tasks must be omitted using annote `// Other Tasks omitted`

#### Output
```scala
import chisel3._
import chisel3.util._

class AdderPipe64bit extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // Other Tasks omitted

  //<<< Task 5 >>>
  // Output Enable Generation

  // Connect `o_en` to the last stage of enable pipeline
  io.o_en := en_pipeline(3)

  // <<< Task 5 end >>>

  // Other Tasks omitted
}
```

### Final Output
``` scala
import chisel3._
import chisel3.util._

class AdderPipe64bit extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // <<< Task 1 >>>
  // Input Registering and Enable Pipeline

  // Create 64-bit registers for `adda` and `addb` using `RegEnable` triggered by `i_en`
  val adda_reg = RegEnable(io.adda, 0.U(64.W), io.i_en)
  val addb_reg = RegEnable(io.addb, 0.U(64.W), io.i_en)

  // Create a 4-stage enable shift register (`en_pipeline`) to track pipeline validity
  val en_pipeline = RegInit(VecInit(Seq.fill(4)(false.B)))

  // Connect `en_pipeline(0)` to `i_en` and shift values every clock cycle
  when(io.i_en) {
    en_pipeline(0) := true.B
  }
  .otherwise {
    en_pipeline(0) := false.B
  }

  for (i <- 1 until 4) {
    en_pipeline(i) := en_pipeline(i - 1)
  }
  // <<< Task 1 end >>>

  // <<< Task 2 >>>
  // 16-bit Ripple Carry Adder (RCA) Implementation

  // Design `RCA16` module
  class RCA16 extends Module {
    val io = IO(new Bundle {
      val a = Input(UInt(16.W))
      val b = Input(UInt(16.W))
      val cin = Input(Bool())
      val sum = Output(UInt(16.W))
      val cout = Output(Bool())
    })

    // Implement ripple carry logic using full-adder chaining
    val (sum, carry) = io.a.zip(io.b).foldLeft((0.U(16.W), io.cin)) {
      case ((s, c), (a, b)) =>
        val fullAdderSum = a ^ b ^ c
        val fullAdderCarry = (a & b) | (b & c) | (a & c)
        (Cat(fullAdderSum, s(15, 1)), fullAdderCarry)
    }
    io.sum := sum
    io.cout := carry
  }

  // <<< Task 2 end >>>

    //<<< Task 3 >>>
  // Pipeline Stage Implementation

  // Instantiate RCA16s for each 16-bit segment and register the outputs
  val stage1 = Module(new RCA16())
  stage1.io.a := adda_reg(15, 0)
  stage1.io.b := addb_reg(15, 0)
  stage1.io.cin := false.B

  val stage1_sum_reg  = RegEnable(stage1.io.sum, 0.U(16.W), en_pipeline(0))
  val stage1_cout_reg = RegEnable(stage1.io.cout, false.B, en_pipeline(0))

  val stage2 = Module(new RCA16())
  stage2.io.a := adda_reg(31, 16)
  stage2.io.b := addb_reg(31, 16)
  stage2.io.cin := stage1_cout_reg

  val stage2_sum_reg  = RegEnable(stage2.io.sum, 0.U(16.W), en_pipeline(1))
  val stage2_cout_reg = RegEnable(stage2.io.cout, false.B, en_pipeline(1))

  val stage3 = Module(new RCA16())
  stage3.io.a := adda_reg(47, 32)
  stage3.io.b := addb_reg(47, 32)
  stage3.io.cin := stage2_cout_reg

  val stage3_sum_reg  = RegEnable(stage3.io.sum, 0.U(16.W), en_pipeline(2))
  val stage3_cout_reg = RegEnable(stage3.io.cout, false.B, en_pipeline(2))

  val stage4 = Module(new RCA16())
  stage4.io.a := adda_reg(63, 48)
  stage4.io.b := addb_reg(63, 48)
  stage4.io.cin := stage3_cout_reg

  val stage4_sum_reg  = RegEnable(stage4.io.sum, 0.U(16.W), en_pipeline(3))
  val stage4_cout_reg = RegEnable(stage4.io.cout, false.B, en_pipeline(3))

  // <<< Task 3 end >>>

  //<<< Task 4 >>>
  // Result Aggregation Logic

  // Create concatenation register for final output
  io.result := Cat(stage4_cout_reg, stage4_sum_reg, stage3_sum_reg, stage2_sum_reg, stage1_sum_reg)
  // <<< Task 4 end >>>

  //<<< Task 5 >>>
  // Output Enable Generation

  // Connect `o_en` to the last stage of enable pipeline
  io.o_en := en_pipeline(3)

  // <<< Task 5 end >>>
}
```



