# Intro
该文件夹为项目`AgileHDL`代码生成的`testcase`
testcase收集自各个开源项目，并且进行分类
- _RTLLM:
- _XiangShan
- _BooM
- _IP-contribution

## 文件组成
- _test：用于存储待测试的RTL以及测试脚本，按照t1,t2...分为LLM的不同次生成结果
    - `dut.v` 用于放置待测RTL
    - makefile中编写了测试命令，修改TEST_DESIGN为dut
- chisel-version：用于编译chisel的环境，放置了SPEC以及对应的chisel-HDL