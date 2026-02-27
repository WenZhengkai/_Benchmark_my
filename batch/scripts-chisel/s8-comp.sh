#!/bin/bash

# 定义当前路径为 main_dir
main_dir=$(pwd)

# 定义 main_dir/.. 为 all_dir
all_dir="$main_dir/.."

# 函数用于执行一组任务
execute_tasks() {
  local start=$1
  local end=$2
  local pids=()

  # 启动指定范围内的任务
  for ((i=start; i<=end; i++))
  do
    target_dir="$all_dir/chisel-version/t$i"
    
    if [ -d "$target_dir" ]; then
      gnome-terminal -- bash -c "cd '$target_dir' && make doit; exec bash" &
      pids+=($!)
    else
      echo "Directory $target_dir does not exist."
    fi
  done

  # 等待所有后台进程完成
  for pid in "${pids[@]}"; do
    wait "$pid"
  done
}

# 先执行前5个任务 (t0-t4)
execute_tasks 0 4

# 强制等待20秒
echo "等待20秒后再执行后5个任务..."
sleep 20

# 然后执行后5个任务 (t5-t9)
execute_tasks 5 9

# # 强制等待20秒
# echo "等待20秒后再执行文件复制..."
# sleep 35
# 等待用户输入 y
while true; do
    read -p "是否继续？(y/n): " choice
    case "$choice" in 
        y|Y ) 
            echo "继续执行..."
            break
            ;;
        n|N )
            echo "操作取消"
            exit 1
            ;;
        * )
            echo "请输入 y 或 n"
            ;;
    esac
done


# 检查并复制目录
test_cache_dir="$all_dir/_test/_cache"
chisel_version_dir="$all_dir/chisel-version"

echo "正在检查目录并执行复制操作..."

# 检查目标目录是否存在
if [ ! -d "$test_cache_dir" ]; then
    echo "创建目录: $test_cache_dir"
    mkdir -p "$test_cache_dir"
fi

# 检查源目录是否存在
if [ -d "$chisel_version_dir" ]; then
    echo "正在将 $chisel_version_dir 复制到 $test_cache_dir ..."
    # 使用rsync保持权限并覆盖已存在内容
    rsync -a --delete "$chisel_version_dir/" "$test_cache_dir/chisel-version/"
    echo "复制完成!"
else
    echo "警告: 源目录 $chisel_version_dir 不存在，跳过复制操作"
fi