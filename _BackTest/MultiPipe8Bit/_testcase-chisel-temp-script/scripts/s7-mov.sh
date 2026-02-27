#!/bin/bash

# 定义路径
main_dir="$(pwd)"
all_dir="$main_dir/.."

# 创建目标目录和复制文件的函数
copy_scala_files() {
  # 确保目标目录存在，如果不存在则创建它
  for i in {0..9}; do
    target_dir="$main_dir/chisel-version/t${i}/src/main/scala"
    mkdir -p "$target_dir"
    
    # 定义源文件
    src_file="$main_dir/dut/dut${i}.scala"
    
    # 定义目标文件
    target_file="$target_dir/dut.scala"
    
    # 检查源文件是否存在
    if [ -f "$src_file" ]; then
      # 复制文件
      cp "$src_file" "$target_file"
      echo "Copied $src_file to $target_file"
    else
      echo "File $src_file does not exist"
    fi
  done
}

# 执行复制文件的操作
copy_scala_files

# 将main_dir/chisel-version复制到all_dir
cp -r "$main_dir/chisel-version" "$all_dir"

echo "Copied $main_dir/chisel-version to $all_dir"

echo "s7-mov.sh 完成，请进行s8-comp.sh 编译chisel"