
## Base Method-verilog
Please act as a professional verilog designer. Give me the complete verilog code.

Give me the complete verilog code.

## Base Method
Please act as a professional Chisel designer. Give me the complete Chisel code.

```
## Module ScoreBoard(used for ISU)
**ScoreBoard module:**
Parameter (maxScore: Int), the maximum score that can be recorded on the scoreboard
Implemented with a normal class, inheriting HasNPCParameter
1. Create a register group `busy` to track the usage status of each register, corresponding to `NR_GPR` registers
Each busy register has a counter function. The counter value of 0 indicates that the corresponding general register is not occupied and can be read
2. Provide functions, implemented with functions:
- `isBusy(idx: UInt) : Bool`: Check whether the register with the specified number idx is occupied. The counter value of 0 indicates that the corresponding general register is not occupied and can be read
- `mask(idx: UInt) : UInt`: Generate a register bit mask based on the register number idx, and the return value bit width is NR_GPR. For example, when idx is 2, the return value counts from right to left, 0, 1, 2..., the second position is 1, and the rest are 0.
- `update(setMask: UInt, clearMask: UInt)`: Update the scoreboard status according to the set/clear mask. The bit width of both parameters is NR_GPR. Their meanings are as defined in mask(). setMask means that the specified register busy scoreboard is increased by 1, and clearMask means that the specified register scoreboard is decreased by 1.
- Set the update logic for the above NR_GPR busy registers (scoreboards). For busy(0), it is always kept at 0.U. The remaining scoreboards are updated as follows according to the two parameters of the function:
- Keep the original value when setting and clearing at the same time
- Set the mask to increase the count value (not exceeding maxScore)
- Clear the mask to reduce the count value (not less than 0)
- Keep the original value by default
```
Give me the complete Chisel code.


## NoT Method s1-Spec Slicer
Please act as a professional Chisel designer. Slice the `Internal logic` into several coding tasks

````
## Module ScoreBoard(used for ISU)
**ScoreBoard module:**
Parameter (maxScore: Int), the maximum score that can be recorded on the scoreboard
Implemented with a normal class, inheriting HasNPCParameter
1. Create a register group `busy` to track the usage status of each register, corresponding to `NR_GPR` registers
Each busy register has a counter function. The counter value of 0 indicates that the corresponding general register is not occupied and can be read
2. Provide functions, implemented with functions:
- `isBusy(idx: UInt) : Bool`: Check whether the register with the specified number idx is occupied. The counter value of 0 indicates that the corresponding general register is not occupied and can be read
- `mask(idx: UInt) : UInt`: Generate a register bit mask based on the register number idx, and the return value bit width is NR_GPR. For example, when idx is 2, the return value counts from right to left, 0, 1, 2..., the second position is 1, and the rest are 0.
- `update(setMask: UInt, clearMask: UInt)`: Update the scoreboard status according to the set/clear mask. The bit width of both parameters is NR_GPR. Their meanings are as defined in mask(). setMask means that the specified register busy scoreboard is increased by 1, and clearMask means that the specified register scoreboard is decreased by 1.
- Set the update logic for the above NR_GPR busy registers (scoreboards). For busy(0), it is always kept at 0.U. The remaining scoreboards are updated as follows according to the two parameters of the function:
- Keep the original value when setting and clearing at the same time
- Set the mask to increase the count value (not exceeding maxScore)
- Clear the mask to reduce the count value (not less than 0)
- Keep the original value by default
````
Slice the `Internal logic` into several coding tasks.
### Task n: 
**Objective:**
**Step:**


## NOT Method s2-Modern HDL Gen

Please act as a professional Chisel designer. Give me the complete Chisel code.


```

```

Give me the complete Chisel code.


## NOT Method s2-Modern HDL Gen

Please act as a professional Chisel designer. Give me the complete Chisel code.
Notice the relation of tasks.



Give me the complete Chisel code.


## NOT-TAG Method s2-Modern HDL Gen

Please act as a professional Chisel designer. Give me the complete Chisel code.
Notice the relation of tasks.



Give me the complete Chisel code.



## Think Process

