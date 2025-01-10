#!/bin/bash

# 定义当前路径为main_dir
main_dir=$(pwd)

# 定义../main_dir为all_dir
all_dir=$main_dir/..

# 目标目录
target_dir="$all_dir/_test/_cache"

rm -rf "$target_dir"

# 检查目标目录是否存在，如果不存在则创建
mkdir -p "$target_dir"

# 源文件路径
source_file="$main_dir/t-temp"

# 检查源文件是否存在
if [[ ! -e "$source_file" ]]; then
  echo "源文件 $source_file 不存在。"
  exit 1
fi

# 复制文件，并按要求命名
for i in {0..9}; do
  cp -r "$source_file" "$target_dir/t$i"
done


echo "文件复制完成。"