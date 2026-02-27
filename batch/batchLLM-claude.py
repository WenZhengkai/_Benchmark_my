import os
import re
import subprocess
import pandas as pd
import time
from pathlib import Path
from typing import List, Dict, Tuple

import importlib.util
import sys
from typing import Optional

# ================== 配置参数 ==================
class Config:
    def __init__(self):
        # 可配置参数 (用户可修改)
        self.llm_repeat = 10  # LLM重复输出数量
        self.prompt_pos = "## Base Method"  # Prompt位置
        self.llm_path = "/home/kai/ChiselProject/Benchmarks/_Benchmark_my/batch/gpt-thread-batch-claude.py"  # LLM调用脚本路径
        self.result_path = "results-base-claude.xlsx"  # 结果存储路径
        self.base_dir = "/home/kai/ChiselProject/Benchmarks/_Benchmark_my"  # 项目基础目录
        self.timeout = 360  # 超时时间(秒)
        
        # 固定参数
        self.test_list_path = "TestList.txt"
        self.exception_report = "exception_report.txt"
        self.target_file = "SPEC/Methods-NoT.md"
        self.temp_prompt_dir = "temp_prompts_claude"  # 临时存放prompt的目录

# ================== 核心函数 ==================
def read_test_list(config: Config) -> List[str]:
    """读取测试列表文件"""
    try:
        with open(config.test_list_path, 'r') as f:
            return [line.strip() for line in f if line.strip()]
    except FileNotFoundError:
        print(f"错误：测试列表文件 {config.test_list_path} 不存在")
        return []

def initialize_exception_report(config: Config):
    """初始化异常报告文件"""
    with open(config.exception_report, 'w') as f:
        f.write("项目名称\t异常原因\n")

def log_exception(config: Config, project: str, reason: str):
    """记录异常到报告文件"""
    with open(config.exception_report, 'a') as f:
        f.write(f"{project}\t{reason}\n")

def find_project_directory(config: Config, project: str) -> str:
    """查找项目目录路径（在base_dir及其子文件夹中搜索名为project的文件夹）"""
    for root, dirs, _ in os.walk(config.base_dir):
        if project in dirs:
            project_dir = os.path.join(root, project)
            # 验证目标文件是否存在
            target_path = os.path.join(project_dir, config.target_file)
            if os.path.exists(target_path):
                return project_dir
    return ""

# def extract_prompt_from_md(file_path: str, section_header: str) -> str:
#     """从Markdown文件中提取指定章节内容"""
#     try:
#         with open(file_path, 'r', encoding='utf-8') as f:
#             content = f.read()
        
#         # 使用正则表达式匹配指定章节
#         pattern = re.compile(
#             rf"^{re.escape(section_header)}\s*$\n(.*?)(?=^#|\Z)",
#             re.DOTALL | re.MULTILINE
#         )
        
#         match = pattern.search(content)
#         return match.group(1).strip() if match else ""
#     except Exception as e:
#         print(f"读取文件出错: {file_path}, {str(e)}")
#         return ""
def extract_prompt_from_md(file_path: str, section_header: str) -> str:
    """改进版本：使用状态机精确解析Markdown"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        
        found_section = False
        in_code_block = False
        result_lines = []
        
        for line in lines:
            stripped_line = line.strip()
            
            # 检测代码块开始/结束
            if stripped_line.startswith('```'):
                in_code_block = not in_code_block
                if found_section:
                    result_lines.append(line)
                continue
            
            # 检测章节标题
            if not in_code_block and stripped_line.startswith('##'):
                # 检查是否是我们要找的章节
                if stripped_line == section_header.strip():
                    found_section = True
                    continue
                elif found_section:
                    # 如果已经找到目标章节，又遇到新的章节标题，则结束
                    break
            
            # 如果在目标章节中，添加内容
            if found_section:
                result_lines.append(line)
        
        return ''.join(result_lines).strip()
    
    except Exception as e:
        print(f"读取文件出错: {file_path}, {str(e)}")
        return ""

def call_llm_script(config: Config, prompt: str, project: str) -> List[str]:
    """调用LLM脚本并获取结果"""
    # 准备输入文件
    input_file = "user_content.txt"
    with open(input_file, 'w', encoding='utf-8') as f:
        f.write(prompt)  
    
    # 构建命令
    cmd = ["python3", config.llm_path, str(config.llm_repeat), config.result_path, project]
    
    try:
        # 执行LLM调用
        process = subprocess.Popen(
            cmd,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )
        print(f"准备执行命令: {' '.join(cmd)}")  # 打印完整命令
        print(f"工作目录: {os.getcwd()}")  # 打印当前工作目录
        stdout, stderr = process.communicate(timeout=config.timeout)
        #print(f"标准输出: {stdout.decode('utf-8')}")
        print(f"标准错误: {stderr.decode('utf-8')}")
        
        # 等待完成或超时
        try:
            _, stderr = process.communicate(timeout=config.timeout)
            if process.returncode != 0:
                raise Exception(f"LLM脚本错误: {stderr.decode('utf-8')}")
        except subprocess.TimeoutExpired:
            process.kill()
            raise TimeoutError("LLM调用超时")
    except Exception as e:
        raise e




def prompt_collect(config: Config, test_list: List[str]) -> Tuple[Dict[str, str], int]:
    """收集所有项目的prompt并返回成功收集的prompt字典和异常计数"""
    print("\n=== 第一阶段：收集Prompt ===")
    exception_count = 0
    prompt_dict = {}  # 存储成功提取的prompt {project: prompt}
    for project in test_list:
        try:
            # 1. 查找项目目录
            project_dir = find_project_directory(config, project)
            if not project_dir:
                raise FileNotFoundError(f"未找到项目目录: {project}")
            
            # 2. 定位Markdown文件
            md_path = os.path.join(project_dir, config.target_file)
            if not os.path.exists(md_path):
                raise FileNotFoundError(f"未找到文件: {config.target_file}")
            
            # 3. 提取Prompt
            prompt = extract_prompt_from_md(md_path, config.prompt_pos)
            if not prompt:
                raise ValueError(f"未找到指定章节: {config.prompt_pos}")
            
            # 保存prompt到临时文件
            prompt_file = os.path.join(config.temp_prompt_dir, f"{project}_prompt.txt")
            with open(prompt_file, 'w', encoding='utf-8') as f:
                f.write(prompt)
            
            prompt_dict[project] = prompt_file
            print(f"项目 {project} Prompt收集成功")
            
        except Exception as e:
            exception_count += 1
            log_exception(config, project, str(e))
            print(f"项目 {project} 处理失败: {str(e)}")
    
    # 第一阶段报告
    print(f"\nPrompt收集完成, 成功收集 {len(prompt_dict)} 个, 异常个数: {exception_count}, 详情请见 {config.exception_report}")
    return (prompt_dict, exception_count)

def call_all_llm(config: Config, prompt_dict: Dict[str, str]) -> int:
    """调用LLM处理所有收集到的prompt并返回异常计数"""
    print("\n=== 第二阶段：LLM调用 ===")
    results = {}
    llm_exception_count = 0
    
    for project, prompt_file in prompt_dict.items():
        try:
            # 读取保存的prompt
            with open(prompt_file, 'r', encoding='utf-8') as f:
                prompt = f.read()
            
            # 调用LLM
            call_llm_script(config, prompt, project)

            print(f"项目 {project} LLM调用完成")
            
        except Exception as e:
            llm_exception_count += 1
            log_exception(config, project, f"LLM调用失败: {str(e)}")
            print(f"项目 {project} LLM调用失败: {str(e)}")
    
    return llm_exception_count


def top(config: Config):
    """批量LLM处理主函数"""
    # 初始化
    test_list = read_test_list(config)
    initialize_exception_report(config)
    
    prompt_dict = {}  # 存储成功提取的prompt {project: prompt}

    
    # 创建临时目录
    os.makedirs(config.temp_prompt_dir, exist_ok=True)
    
    print(f"开始处理 {len(test_list)} 个项目...")
    
    # 第一阶段：遍历所有项目，收集prompt并报告异常
    (prompt_dict, exception_count) = prompt_collect(config, test_list)

    # 第二阶段：统一逐个调用LLM
    llm_exception_count = call_all_llm(config, prompt_dict)

    
    # 保存结果
    print(f"\n结果已保存到 {config.result_path}")
    
    # 最终报告
    total_exceptions = exception_count + llm_exception_count
    print(f"\n处理完成, 总异常个数: {total_exceptions} (收集阶段: {exception_count}, LLM阶段: {llm_exception_count})")
    print(f"详情请见 {config.exception_report}")


# ================== 主程序 ==================
if __name__ == "__main__":
    # 初始化配置
    config = Config()
    
    # 确保基础目录存在
    Path(config.base_dir).mkdir(parents=True, exist_ok=True)
    
    # 执行批量处理
    start_time = time.time()
    #batch_llm_processing(config)
    top(config)
    print(f"总耗时: {time.time() - start_time:.2f}秒")