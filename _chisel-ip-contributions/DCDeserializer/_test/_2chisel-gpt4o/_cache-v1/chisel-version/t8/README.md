# testcase-chisel-temp

testcase生成chisel版本进行测试

## 模板组成
包含两个模板子文件
- `t-temp`: 用于vcs仿真
- `chisel-version`: 用于chisel编译

## 修改步骤
修改`t-temp`，导入对应的`testbench.v` SPEC golden
修改`testbench.v`中的`例化模块名称`与`端口`和chisel生成的rtl一致
`_test`路径下按照名称复制`t-temp`（t1,t2,t3...）

`SPEC-chisel.md`中放入chisel版本的SPEC
`dut.scala`文件中放入dut代码，修改类名为`dut`
打开`dirver.scala`文件，修改对应的目标路径(t1,t2,t3...)


See the `Makefile` for the hardware and test targets.
