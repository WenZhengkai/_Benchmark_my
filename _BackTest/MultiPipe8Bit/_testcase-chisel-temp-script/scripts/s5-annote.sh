#!/bin/bash

# 定义当前路径为main_dir
main_dir=$(pwd)

# 寻找10个scala文件并处理
for i in {0..9}; do
    file="$main_dir/dut/dut$i.scala"
    
    # 判断文件是否存在
    if [ ! -f "$file" ]; then
        echo "警告：文件 $file 不存在，跳过。"
        continue
    fi
    
    # 使用awk工具来处理文件内容
    awk '
    BEGIN { inCodeBlock = 0 }
    /```/ {
        inCodeBlock = !inCodeBlock
        if (!inCodeBlock) exit
        next
    }
    {
        if (inCodeBlock) print
    }
    END {
        if (inCodeBlock) print "警告：'"dut$i.scala"'格式异常"
    }
    ' "$file" > "$main_dir/dut/temp_dut$i.scala"

    # 使用重命名临时文件覆盖原始文件
    mv "$main_dir/dut/temp_dut$i.scala" "$file"
done

echo "s5.sh:代码内容筛选完毕,请注意修改类名dut以及删除无效对象"