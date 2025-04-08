#!/bin/bash

# 定义当前路径为main_dir
main_dir=$(pwd)

# 定义要创建文件的目录路径
dut_dir="$main_dir/dut"

rm -rf "$dut_dir"

# 创建dut目录，如果它不存在
mkdir -p "$dut_dir"

# 在dut目录中创建10个空白的.v文件
for i in {0..9}; do
  touch "$dut_dir/dut$i.v"
done

echo "10个.v文件已在 $dut_dir 中创建"