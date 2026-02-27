#!/bin/bash

# 定义当前路径为 main_dir
main_dir=$(pwd)

# 定义工作路径
dut_dir="$main_dir/dut"

# 确认文件夹是否存在
if [ ! -d "$dut_dir" ]; then
  echo "Error: $dut_dir 文件夹不存在！"
  exit 1
fi

# 循环处理 dut0.scala 到 dut9.scala
for i in {0..9}; do
  file="$dut_dir/dut${i}.scala"

  # 检查文件是否存在
  if [ ! -f "$file" ]; then
    echo "Error: $file 文件不存在！"
    continue
  fi

  # 1. 搜索并注释 package xxx 行
  sed -i 's/^\(package .*\)$/\/\/ \1/' "$file"

  # 2. 搜索并注释 object XXX extends App { ... }
  awk '
    BEGIN { in_object = 0 }
    /object [A-Za-z0-9_]+ extends App {/ { 
      if (in_object == 0) {
        in_object = 1; 
        print "/*"
        print $0
      } else {
        print $0
      }
      next
    }
    in_object == 1 { 
      print $0
      if ($0 ~ /^\}/) {
        print "*/"; 
        in_object = 0 
      }
      next 
    }
    { print $0 }
  ' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"


  # 3. 如果有命令行参数则进行替换
  if [[ $# -eq 1 ]]; then
    FixName=$1

    # 查找所有大小写变体并替换为FixName
    while IFS= read -r line; do
      OriginalName=$(echo "$line" | grep -E -o -m 1 "$FixName" -i)
      if [ -n "$OriginalName" ] && [ "$OriginalName" != "$FixName" ]; then
        sed -i "s/$OriginalName/$FixName/g" "$file"
      fi
    done < <(grep -i "$FixName" "$file")
  fi
done

echo "脚本执行完毕！"