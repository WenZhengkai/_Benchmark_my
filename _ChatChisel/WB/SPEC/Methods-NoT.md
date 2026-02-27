
## Base Method
Please act as a professional Chisel designer. Give me the complete Chisel code.

```

```
Give me the complete Chisel code.


## NoT Method s1-Spec Slicer
Please act as a professional Chisel designer. Slice the `Internal logic` into several coding tasks

```
Module name: Writeback

I/O ports:
  val io = IO(new Bundle {
    val csr_read_data_in = Input(UInt(32.W))
    val wb_reg_pc = Input(UInt(32.W))
    val wb_readdata = Input(UInt(32.W))
    val wb_aluresult = Input(UInt(32.W))
    val wb_memtoreg = Input(UInt(2.W))
    val writedata = Output(UInt(32.W))
  })

Internal Logic: 
In the RISC-V processor, The Writebacck stage Implements the following functions:
1. generate the data to regfile `writedata` based on the following table

| wb_memtoreg | writedata |
| ---- | ---- |
| 00 | wb_reg_pc |
| 01 | wb_readdata |
| 10 | wb_aluresult |
| 11 | csr_read_data_in |


```
Slice the `Internal logic` into several coding tasks.
### Task n: 
**Objective:**
**Step:**


## NOT Method s2-Modern HDL Gen

Please act as a professional Chisel designer. Give me the complete Chisel code.


```

```

Give me the complete Chisel code.


## NOT-TAG Method s2-Modern HDL Gen

Please act as a professional Chisel designer. Give me the complete Chisel code.


````
Module name: DUT

I/O ports:
  val io = IO(new Bundle {
    val csr_read_data_in = Input(UInt(32.W))
    val wb_reg_pc = Input(UInt(32.W))
    val wb_readdata = Input(UInt(32.W))
    val wb_aluresult = Input(UInt(32.W))
    val wb_memtoreg = Input(UInt(2.W))
    val writedata = Output(UInt(32.W))
  })

Internal Logic: 
In the RISC-V processor, The Writebacck stage Implements the following functions:
1. generate the data to regfile `writedata` based on the following table

| wb_memtoreg | writedata |
| ---- | ---- |
| 00 | wb_reg_pc |
| 01 | wb_readdata |
| 10 | wb_aluresult |
| 11 | csr_read_data_in |


 Task 1: Implement the writeback data multiplexer
**Objective:** Create a multiplexer to select the correct data source for `writedata` based on the `wb_memtoreg` control signal.  
**Step:**  
1. Use a `switch` statement with `io.wb_memtoreg` as the selector
2. Implement four cases matching the selection table:
   - `0.U` ➔ `io.wb_reg_pc`
   - `1.U` ➔ `io.wb_readdata`
   - `2.U` ➔ `io.wb_aluresult`
   - `3.U` ➔ `io.csr_read_data_in`
3. Directly assign the selected value to `io.writedata`

```scala
// Implementation code for the multiplexer
switch(io.wb_memtoreg) {
  is(0.U) { io.writedata := io.wb_reg_pc }
  is(1.U) { io.writedata := io.wb_readdata }
  is(2.U) { io.writedata := io.wb_aluresult }
  is(3.U) { io.writedata := io.csr_read_data_in }
}
```
````


Give me the complete Chisel code.



## Think Process
Thinking...
> 
> We are given a module named "Writeback" with several input ports and one output port.
>  The internal logic: 
>    The output `writedata` is selected from one of four inputs based on the value of `wb_memtoreg` (a 2-bit signal).
> 
>  According to the table:
>    wb_memtoreg = 00 -> writedata = wb_reg_pc
>    wb_memtoreg = 01 -> writedata = wb_readdata
>    wb_memtoreg = 10 -> writedata = wb_aluresult
>    wb_memtoreg = 11 -> writedata = csr_read_data_in
> 
>  We can implement this with a multiplexer (MuxCase or a when/elsewhen chain).
> 
>  Since the problem is straightforward, we can break it into one or two tasks.
> 
>  However, to be thorough, let's break it into:
> 
>  Task 1: Define the module and its I/O.
>  Task 2: Implement the multiplexer logic for `writedata`.
> 
>  But note: the I/O is already given, so we assume that the module definition is already done.
> 
>  However, the problem says: "Slice the Internal logic into several coding tasks", so we focus on the internal logic.
> 
>  Since the internal logic is a single multiplexer, we can write it as one task.
> 
>  But to show the steps, we can break it into:
> 
>  Task 1: Implement the selection logic for `writedata` using a multiplexer.
> 
>  Alternatively, we can write:
> 
>    Task 1: Declare the output `writedata` as a wire.
>    Task 2: Use a switch statement (or MuxCase) to assign `writedata` based on `wb_memtoreg`.
> 
>  However, in Chisel, we can do it in one assignment.
> 
>  Let's write the tasks accordingly.
> 
>  Since the problem is small, we can do:
> 
>    Task 1: Create a multiplexer to select the appropriate data for `writedata`.
> 
>  But note: the table has four cases and we have a 2-bit signal, so we can use a switch or a when/elsewhen chain.
> 
>  We are going to use a switch on `wb_memtoreg` and assign `writedata` accordingly.
> 
>  Alternatively, we can use a Chisel `MuxLookup` or `MuxCase`.
> 
>  Let me choose a switch because it is clear and matches the table.
> 
>  Proposed code for the internal logic:
> 
>    io.writedata := 0.U   // default assignment to avoid latches, but we cover all cases so it's safe to have a default?
>    Since wb_memtoreg is 2 bits and we have 4 cases, we can cover all.
> 
>    switch(io.wb_memtoreg) {
>      is(0.U) { io.writedata := io.wb_reg_pc }
>      is(1.U) { io.writedata := io.wb_readdata }
>      is(2.U) { io.writedata := io.wb_aluresult }
>      is(3.U) { io.writedata := io.csr_read_data_in }
>    }
> 
>  But note: the table uses 00, 01, 10, 11 which are 0,1,2,3 in decimal.
> 
>  Alternatively, we can use a MuxCase:
> 
>    io.writedata := MuxCase(0.U, Array(
>      (io.wb_memtoreg === 0.U) -> io.wb_reg_pc,
>      (io.wb_memtoreg === 1.U) -> io.wb_readdata,
>      (io.wb_memtoreg === 2.U) -> io.wb_aluresult,
>      (io.wb_memtoreg === 3.U) -> io.csr_read_data_in
>    ))
> 
>  However, the problem says to break into tasks, but the entire logic is one multiplexer.
> 
>  So, we can write:
> 
>    Task 1: Implement the multiplexer for the writeback data.
> 
>    Steps:
>      1. Use a switch statement on `io.wb_memtoreg` to assign `io.writedata` with the corresponding input.
> 
>  Since the problem is very small, we only have one task.
> 
>  But let's assume we break it into two tasks for clarity:
> 
>    Task 1: Initialize the output to a default value (to avoid inferred latches, though we cover all cases, but good practice).
>    Task 2: Use a switch statement to override the default value based on `wb_memtoreg`.
> 
>  However, in Chisel, we can do:
> 
>    io.writedata := MuxLookup(io.wb_memtoreg, 0.U, Seq(
>      0.U -> io.wb_reg_pc,
>      1.U -> io.wb_readdata,
>      2.U -> io.wb_aluresult,
>      3.U -> io.csr_read_data_in
>    ))
> 
>  But note: the table says 00, 01, 10, 11, which are 0,1,2,3.
> 
>  So, we can write one task:
> 
>    Task 1: Assign `io.writedata` by selecting from the four inputs based on the 2-bit control signal `io.wb_memtoreg`.
> 
>  Considering the above, I propose:
> 
>    We have one task.
> 
>    Task 1: Implement the multiplexer for `io.writedata`.
> 
>    Steps:
>      - Use a switch statement (with is) to cover the four cases.
> 
>  However, the problem says "several", but one is also acceptable.
> 
>  But to be safe, let's break it into two:
> 
>    Task 1: Declare a temporary register or wire for the writedata? 
>             Actually, we don't need a temporary because we are assigning directly to the output.
> 
>    Alternatively, we can break by the cases:
> 
>    Task 1: Handle the case when wb_memtoreg is 0.
>    Task 2: Handle the case when wb_memtoreg is 1.
>    Task 3: Handle the case when wb_memtoreg is 2.
>    Task 4: Handle the case when wb_memtoreg is 3.
> 
>    But that would be overkill and not efficient in code.
> 
>    So, we stick to one task.
> 
>  However, the problem says "several", so let's do two:
> 
>    Task 1: Initialize the output to zero (or a safe default) at the beginning.
>    Task 2: Override the output in a switch statement.
> 
>  But note: in Chisel, we can assign multiple times and the last assignment wins? 
>             Actually, we use conditional assignments that are mutually exclusive.
> 
>    Alternatively, we can do:
> 
>       io.writedata := io.wb_reg_pc   // for 0
>       when (io.wb_memtoreg === 1.U) {
>           io.writedata := io.wb_readdata
>       }.elsewhen (io.wb_memtoreg === 2.U) {
>           io.writedata := io.wb_aluresult
>       }.elsewhen (io.wb_memtoreg === 3.U) {
>           io.writedata := io.csr_read_data_in
>       }
> 
>    This is equivalent and we can break:
> 
>       Task 1: Assign the default (which is the case for 0) to `io.writedata`.
>       Task 2: Use when conditions to reassign for the other cases.
> 
>    This would be two tasks.
> 
>    However, note that the table does not specify a priority, and the cases are mutually exclusive by the 2-bit signal.
> 
>    So, we can do:
> 
>    Step 1: Assign the output for the case 0 (which is wb_reg_pc) as the default.
>    Step 2: Use a when statement to check for 1, then 2, then 3.
> 
>    But note: the when conditions are checked in order, but since the control is one-hot? Actually, it's a 2-bit signal so only one condition matches.
> 
>    Alternatively, we can use a switch which is more efficient and clear.
> 
>    Given the above, I think the best is to have one task.
> 
>    However, to follow the problem's request for "several", we can break it into two tasks:
> 
>    Task 1: Create a switch statement that covers the four cases for `io.wb_memtoreg_mux` and assigns a temporary value.
>    Task 2: Assign the temporary value to `io.writedata`.
> 
>    But that is artificial.
> 
>    Alternatively, we can do:
> 
>    Task 1: Define a temporary wire `writeDataTemp` of UInt(32.W).
>    Task 2: Assign `writeDataTemp` using the multiplexer logic (switch or MuxLookup).
>    Task 3: Connect `writeDataTemp` to `io.writedata`.
> 
>    That would be three tasks.
> 
>    But that is also artificial.
> 
>    I think the problem expects a breakdown of the logic steps, even if they are in one assignment.
> 
>    So, I propose:
> 
>    Task 1: Implement the multiplexer for the writeback data.
> 
>    Steps:
>      1. Use a switch statement on `io.wb_memtoreg` to set `io.writedata` to the appropriate input.
> 
>    That's one task.
> 
>    But the problem says "several", so let me think of two:
> 
>    Task 1: Map the control signal to the data sources.
>    Task 2: Assign the output based on the mapping.
> 
>    That's two.
> 
>    How about:
> 
>    Task 1: Create a mapping from the control signal values to the corresponding data inputs.
>    Task 2: Use this mapping to drive the output.
> 
>    In code, we can do:
> 
>       val muxMapping = Seq(
>           0.U -> io.wb_reg_pc,
>           1.U -> io.wb_readdata,
>           2.U -> io.wb_aluresult,
>           3.U -> io.csr_read_data_in
>       )
>       io.writedata := MuxLookup(io.wb_memtoreg, 0.U, muxMapping)
> 
>    Then we break:
> 
>       Task 1: Define the mapping as a sequence of tuples (control value, data source).
>       Task 2: Assign the output using MuxLookup with the mapping.
> 
>    This is two tasks.
> 
>    Alternatively, without a temporary:
> 
>       Task 1: Assign the output using a MuxLookup with an inline mapping.
> 
>    But that would be one task.
> 
>    Given the above, I will break it into two tasks:
> 
>    Task 1: Create the mapping for the multiplexer.
>       Objective: Create a sequence that maps each possible value of `wb_memtoreg` to the corresponding data source.
> 
>    Task 2: Assign the output using the mapping.
>       Objective: Use the mapping to set `io.writedata` with a multiplexer.
> 
>    But note: the MuxLookup requires a default, which we set to 0.U. However, we cover all cases (0 to 3) so the default will never be used.
> 
>    Alternatively, we can use MuxCase which does not require a default but the order matters? Actually, MuxCase takes a list of condition->result and the first condition that is true is selected. But we want to match by equality, and we have four mutually exclusive conditions? Actually, they are not conditions but the control value comparisons, and they are mutually exclusive.
> 
>    However, we can also do:
> 
>         io.writedata := MuxCase(0.U, muxMapping)
> 
>    But that is not the same. MuxCase expects a list of (condition, value) and we have conditions that are not boolean? Actually, our mapping is (control value, data) and we have to convert to condition.
> 
>    Actually, MuxLookup is the one that takes a key and a mapping of key->value.
> 
>    So, we stick to MuxLookup.
> 
>    Alternatively, we can use a switch, which is also clear.
> 
>    Since the problem does not specify the style, I will use the switch for simplicity and clarity.
> 
>    But the problem says to break into tasks, so I will choose the switch style and break it into:
> 
>    Task 1: Implement the writeback data multiplexer using a switch statement.
> 
>    Steps:
>      1. Use a switch on `io.wb_memtoreg`.
>      2. For each case (0, 1, 2, 3), assign `io.writedata` to the respective input.
> 
>    That's one task.
> 
>    Given the ambiguity, I'll break it into two tasks:
> 
>    Task 1: Initialize the output to a safe value (0) to avoid latch inference (though we cover all cases).
>    Task 2: Override the output in a switch statement.
> 
>    But in Chisel, we can do:
> 
>         io.writedata := 0.U
>         switch(io.wb_memtoreg) {
>           ...
>         }
> 
>    However, note that the switch does not override in the same way as Verilog. The switch is just a conditional assignment.
> 
>    Actually, we can do:
> 
>         val writeDataTemp = WireInit(0.U(32.W))
>         switch(io.wb_memtoreg) {
>           is (0.U) { writeDataTemp := io.wb_reg_pc }
>           is (1.U) { writeDataTemp := io.wb_readdata }
>           is (2.U) { writeDataTemp := io.wb_aluresult }
>           is (3.U) { writeDataTemp := io.csr_read_data_in }
>         }
>         io.writedata := writeDataTemp
> 
>    Then we break:
> 
>       Task 1: Create a temporary wire `writeDataTemp` and initialize it to 0.
>       Task 2: Use a switch on `io.wb_memtoreg` to assign `writeDataTemp` appropriately.
>       Task 3: Connect `writeDataTemp` to `io.writedata`.
> 
>    That's three tasks.
> 
>    But the problem says "several", so three is acceptable.
> 
>    However, I think it's more straightforward to assign directly to `io.writedata` without a temporary.
> 
>    So, I propose:
> 
>       Task 1: Assign a default value to `io.writedata` (0).
>       Task 2: Override the value of `io.writedata` in a switch statement.
> 
>    In code:
> 
>         io.writedata := 0.U
>         switch(io.wb_memtoreg) {
>           is (0.U) { io.writedata := io.wb_reg_pc }
>           is (1.U) { io.writedata := io.wb_readdata }
>           is (2.U) { io.writedata := io.wb_aluresult }
>           is (3.U) { io.writedata := io.csr_read_data_in }
>         }
> 
>    This is two assignments to `io.writedata`, but the last one in the switch will take effect for the given case.
> 
>    However, note that in Chisel, the order of assignments is the order in the code. The switch will conditionally assign and override the default.
> 
>    This is acceptable and common.
> 
>    Therefore, we break into:
> 
>      Task 1: Set a default value for the output.
>      Task 2: Conditionally override the output based on the control signal.
> 
>    Two tasks.
> 
>    Alternatively, we can do one task with the switch and without the default assignment? But then we must cover all cases, which we do. So we can also do:
> 
>         switch(io.wb_memtoreg) {
>           is (0.U) { io.writedata := io.wb_reg_pc }
>           is (1.U) { io.writedata := io.wb_readdata }
>           is (2.U) { io.writedata := io.wb_aluresult }
>           is (3.U) { io.writedata := io.csr_read_data_in }
>         }
> 
>    And we don't need the default assignment because the switch covers all cases. But Chisel might require a default assignment to avoid combinatorial loop? Actually, no, because the switch covers all cases (0,1,2,3) for a 2-bit signal.
> 
>    So, we can do one task.
> 
>    After reconsideration, I think the problem expects one task because the internal logic is a single multiplexer.
> 
>    But the problem says "several", so let's do two tasks for the sake of the exercise.
> 
>    Final breakdown:
> 
>    Task 1: Initialize the output to zero.
>    Task 2: Override the output for each case of `wb_memtoreg` using a switch.
> 
>    However, note that in the switch we are assigning conditionally, and the zero is just a placeholder.
> 
>    Alternatively, we can break the switch into four tasks? That would be:
> 
>       Task 1: If wb_memtoreg is 0, then assign writedata to wb_reg_pc.
>       Task 2: Else, if wb_memtoreg is 1, then assign writedata to wb_readdata.
>       Task 3: Else, if wb_memtoreg is 2, then assign writedata to wb_aluresult.
>       Task 4: Else, assign writedata to csr_read_data_in.
> 
>    (with the understanding that the last else covers only 3, because it's 2 bits)
> 
>    This is four tasks.
> 
>    But note: we can write:
> 
>         when (io.wb_memtoreg === 0.U) {
>             io.writedata := io.wb_reg_pc
>         } .elsewhen (io.wb_memtoreg === 1.U) {
>             io.writedata := io.wb_readdata
>         } .elsewhen (io.wb_memtoreg === 2.U) {
>             io.writedata := io.wb_aluresult
>         } .otherwise {
>             io.writedata := io.csr_read_data_in
>         }
> 
>    Then we break:
> 
>       Task 1: Handle the case when wb_memtoreg is 0.
>       Task 2: Handle the case when wb_memtoreg is 1.
>       Task 3: Handle the case when wb_memtoreg is 2.
>       Task 4: Handle the case when wb_memtoreg is 3 (otherwise).
> 
>    That's four tasks.
> 
>    Given the problem's table has four rows, this breakdown matches the table.
> 
>    So, I choose this breakdown.
> 
>    Tasks:
> 
>    Task 1: Assign `io.writedata` to `io.wb_reg_pc` when `io.wb_memtoreg` is 0.
>    Task 2: Else, assign to `io.wb_readdata` when `io.wb_memtoreg` is 1.
>    Task 3: Else, assign to `io.wb_aluresult` when `io.wb_memtoreg` is 2.
>    Task 4: Else, assign to `io.csr_read_data_in` (when `io.wb_memtoreg` is 3).
> 
>    This is straightforward and matches the table exactly.
> 
>    Therefore, we break into four tasks.
> 
>    Let's write the tasks accordingly.
> 

Based on the internal logic description, the Writeback module can be implemented with a single multiplexer that selects between four data sources. Here's the task breakdown:



**Rationale for single task:**  
The internal logic is a pure combinational multiplexer with:
- One control signal (`wb_memtoreg`)
- Four data sources
- One output (`writedata`)
- No sequential logic or additional sub-modules  
This constitutes a single cohesive functionality that doesn't benefit from further decomposition. The `switch` statement cleanly implements the specified truth table in a readable and maintainable way.