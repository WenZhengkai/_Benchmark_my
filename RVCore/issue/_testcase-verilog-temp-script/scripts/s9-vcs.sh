#!/bin/bash

# 定义当前路径为 main_dir
main_dir=$(pwd)

# 定义 main_dir/.. 为 all_dir
all_dir="$main_dir/.."

# 循环进入 all_dir/chisel-version/t{x} (t{x}=t0,t1,t2...,t9)
for i in {0..9}
do
  # 定义目标路径
  target_dir="$all_dir/_test/_cache/t$i"
  
  # 检查目标路径是否存在
  if [ -d "$target_dir" ]; then
    # 在一个新的终端中执行 make doit
    # gnome-terminal 是一个常用终端模拟器，可以根据需要替换为您的系统上使用的终端
    gnome-terminal -- bash -c "cd '$target_dir' && make vcs && make sim; exec bash"
  else
    echo "Directory $target_dir does not exist."
  fi
done