#!/bin/bash

# 定义当前路径为main_dir
main_dir=$(pwd)

# 定义gpt_dir
gpt_dir="/home/kai/ChiselProject/OpenAITemp/gpt-testcase"

# 定义Excel文件路径
excel_file="$gpt_dir/gpt_record-script.xlsx"

# 检查Excel文件是否存在
if [ ! -f "$excel_file" ]; then
  echo "Excel文件不存在，请检查路径：$excel_file"
  exit 1
fi

# 检查dut目录是否存在
dut_dir="$main_dir/dut"
if [ ! -d "$dut_dir" ]; then
  echo "dut目录不存在，请执行s2-dutfile.sh"
  exit 1
fi

# 检查dut目录下的10个文件是否存在
for i in {0..9}; do
  dut_file="$dut_dir/dut$i.scala"
  if [ ! -f "$dut_file" ]; then
    echo "dut文件不存在：$dut_file，请执行s2-dutfile.sh"
    exit 1
  fi
done

# 使用Python的pandas库读取Excel文件并写入dut文件
python3 <<EOF
import pandas as pd


# 读取Excel文件
df = pd.read_excel("$excel_file", header=None)

# 从第二行第五列开始读取
row_index = len(df) - 1  # 索引从0开始，第二行对应的索引为1
col_start_index = 4  # 第五列索引为4

# 循环写入到dut文件中
for i in range(10):
    content = df.iloc[row_index, col_start_index + i]
    with open(f"$dut_dir/dut{i}.scala", "w") as dut_file:
        dut_file.write(str(content))

EOF

echo "s4-copy.sh:内容已成功写入dut文件，请进行s5-annote.sh筛选代码内容"