
### s1-temp.sh
    vcs仿真路径复制
编写一份shell脚本
定义当前路径为main_dir
定义 main_dir/.. 为all_dir

命名为s1-temp.sh
将main_dir/t-temp复制到all_dir/_test/_cache,一共复制10份，每一份命名为(t0,t1,t2,t3...,t9)

给出完整代码

### s2-dutfile.sh
编写一份shell脚本
定义当前路径为main_dir

在main_dir/dut内创建10个空白scala文件，命名为（dut0.scala,dut1.scala,dut2.scala,...,dut9.scala）

给出完整代码


### s4-copy.sh

编写一份shell脚本
定义当前路径为main_dir
定义gpt_dir为`/home/kai/ChiselProject/OpenAITemp/gpt-testcase`
读取gpt_dir/gpt_record-script.xlsx,如果不存在则发出提示并且退出
检查main_dir/dut目录是否存在，以及其内部的10个文件是否存在（dut0.scala,dut1.scala,dut2.scala,...,dut9.scala）
如果不存在，则打印“dut文件不存在，请执行s2-dutfile.sh”并且退出
如果存在：
从第2行第5列开始，依次增加列数，把每个表项内的内容依次复制到main_dir/dut的文件中，比如（2,5）坐标的内容复制到dut0.scala内，(2,6)复制到dut1.scala,(2,7)dut2,scala，以此类推


给出完整代码

### s5-annote.sh
编写一份shell脚本
定义当前路径为main_dir

在main_dir/dut内寻找10个scala文件，名称为（dut0.scala,dut1.scala,dut2.scala,...,dut9.scala）
分别对每个文件搜索代码内容
代码内容被包裹到了如下格式里：
```
代码内容
```
请删除代码内容之外的内容，包括```
如果没有发现```,请发出警告dutn.scala格式异常，并且跳过这个文件

给出完整代码


### s7-mov.sh
编写一份shell脚本
定义当前路径为main_dir
定义 main_dir/.. 为all_dir

在main_dir/dut内寻找10个scala文件，名称为（dut0.scala,dut1.scala,dut2.scala,...,dut9.scala）
将dut{x}.scala的内容复制到main_dir/chisel-version/t{x}/src/main/scala/dut.scala
比如dut5.scala对应的是t5

将main_dir/chisel-version复制到all_dir

给出完整代码

### s8-comp.sh
编写一份shell脚本
定义当前路径为main_dir
定义 main_dir/.. 为all_dir
进入每一个all_dir/chisel-version/t{x}（t{x}=t0,t1,t2...,t9）执行make doit
每当进入一个文件夹，就打开一个新的终端
给出完整代码

### s9-vcs.sh
编写一份shell脚本
定义当前路径为main_dir
定义 "$main_dir/.." 为all_dir
进入每一个all_dir/_test/_cache/t{x}（t{x}=t0,t1,t2...,t9）
执行make vcs
执行make sim
每当进入一个文件夹，就打开一个新的终端
给出完整代码