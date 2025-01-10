# testcase-chisel-temp

testcase生成chisel版本进行测试

## 模板组成
包含两个模板子文件
- `t-temp`: 用于vcs仿真
- `chisel-version`: 用于chisel编译

## 修改步骤

人工-复制文件夹testcase-chisel-temp到工作文件夹下

人工-修改`t-temp`，导入对应的`testbench.v` `SPEC` `golden`
人工-修改`testbench.v`中的`例化模块名称`与`端口`和chisel生成的rtl一致

### s1-temp.sh

脚本`_test`路径下创建`_cache`文件夹
脚本-按照名称复制`t-temp`（t0,t1,t2,t3...t9）

创建`SPEC-chisel.md`
脚本-`SPEC-chisel.md`送给LLM接口进行若干次生成，存于文件夹`testcase-chisel-temp/dut-origin`（dut1.scala,dut2.scala...）

### s2-dutfile.sh
在main_dir/dut内创建10个空白scala文件，命名为（dut0.scala,dut1.scala,dut2.scala,...,dut9.scala）

### s3-gpt.sh
脚本-进入文件夹`/home/kai/ChiselProject/OpenAITemp/gpt-testcase`,输入SPEC-chisel.md到user_content.txt,执行python3 gpt.py 10
### s4-copy.sh
读取gpt-testcase/gpt_record-script.xlsx内容，复制于`testcase-chisel-temp/dut`（dut0.scala,dut1.scala,dut2.scala...）

### s5-annote.sh
脚本-只保留代码内容

人工-修改模块名称为dut

### s7-mov.sh
脚本-`dut`文件夹下每个文件根据引索(dut1,dut2)将代码放入相应路径的`dut.scala`文件中（t1,t2...）
脚本-从testcase-chisel-temp复制chisel-version到上一级文件夹

//打开`dirver.scala`文件，修改对应的目标路径(t1,t2,t3...)
### s8-comp.sh
脚本-进入到chisel-version中的每一个子文件夹（t0,t1,t2...,t9）执行make doit

### s9-vcs.sh
脚本-进入_test/_cache中的每一个子文件夹(t1,t2...,tx)执行make vcs，make sim
人工-统计结果

完成测试后修改_test/cache名称


See the `Makefile` for the hardware and test targets.
