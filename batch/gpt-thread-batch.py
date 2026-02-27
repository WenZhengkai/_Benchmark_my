import openai
import os
import logging
import pandas as pd
from datetime import datetime
from openai import OpenAI
import sys

from concurrent.futures import ThreadPoolExecutor

# Configuration
LOG_FILEPATH = ''
LOGGING_LEVEL = logging.INFO

# Log setting
logging.basicConfig(level=LOGGING_LEVEL, filemode='w',
                    format='%(name)s - %(levelname)s - %(message)s')

gpt_logger = logging.getLogger('gpt_logger')
file_handler = logging.FileHandler('gpt_logger.txt', mode='w')
file_handler.setFormatter(logging.Formatter('%(levelname)s - %(message)s'))
gpt_logger.addHandler(file_handler)

def initialize_client(api_key, base_url):
    """Initialize OpenAI client."""
    return OpenAI(api_key=api_key, base_url=base_url)

def read_file(file_path):
    """Read content from a file and return stripped content."""
    with open(file_path, 'r') as file:
        return file.read().strip()

def call_openai_api(client, system_content, user_content, model_name):
    """Call OpenAI API and return the response."""
    chat_completion = client.chat.completions.create(
        model=model_name,
        messages=[
            {
                "role": "system",
                "content": system_content,
            },
            {
                "role": "user",
                "content": user_content,
            }
        ],
    )
    return chat_completion.choices[0].message.content

def save_to_excel(excel_file, TestName, model_name, system_content, user_content, gpt_responses):
    """Save the conversation data to an Excel file."""
    # 如果Excel文件不存在，创建一个新的DataFrame并保存
    if not os.path.exists(excel_file):
        df = pd.DataFrame(columns=['TestName', 'Model Name', 'System Content', 'User Content'] + [f'Resp {i+1}' for i in range(len(gpt_responses))])
        df.to_excel(excel_file, index=False)

    # 读取现有Excel文件
    df = pd.read_excel(excel_file)

    # 创建新数据字典，添加多个GPT响应
    new_data = {
        'TestName': TestName,
        'Model Name': model_name,
        'System Content': system_content,
        'User Content': user_content
    }

    # 为每个响应创建新的列
    for i, response in enumerate(gpt_responses):
        new_data[f'Resp {i+1}'] = response

    df = df._append(new_data, ignore_index=True)

    # 将更新后的DataFrame写回Excel文件
    df.to_excel(excel_file, index=False)

def call_openai_api_concurrently(client, system_content, user_content, model_name, num_calls):
    gpt_responses = []
    
    # 定义一个用于调用API的包装函数
    def api_call():
        response = call_openai_api(client, system_content, user_content, model_name)
        print(response)  # 打印响应
        return response

    # 使用ThreadPoolExecutor执行并发任务
    with ThreadPoolExecutor() as executor:
        # 提交多个任务到线程池
        futures = [executor.submit(api_call) for _ in range(num_calls)]
        
        # 收集所有任务的执行结果
        for future in futures:
            gpt_responses.append(future.result())
    
    return gpt_responses


# 定义所有可用的配置组
MODEL_CONFIGS = {
    "gpt-4o": {
        "api_key": os.getenv('OpenAiKey'),
        "base_url": "https://a.fe8.cn/v1",
        "model_name": "gpt-4o"
    },
    "deepseek-v3": {
        "api_key": "d61217e7-8ff3-4937-83ed-3dd2bebf72ad",
        "base_url": "https://ark.cn-beijing.volces.com/api/v3",
        "model_name": "deepseek-v3-241226"
    },
    "gpt-4.1": {
        "api_key": os.getenv('OpenAiKey'),
        "base_url": "https://a.fe8.cn/v1",
        "model_name": "gpt-4.1"
    },
    "gpt-5.2": {
        "api_key": os.getenv('OpenAiKey2602'),
        "base_url": "https://api.agicto.cn/v1",
        "model_name": "gpt-5.2"
    },
    "claude-sonnet-4-5-20250929": {
        "api_key": os.getenv('OpenAiKey2602'),
        "base_url": "https://api.agicto.cn/v1",
        "model_name": "claude-sonnet-4-5-20250929"
    },
    "claude-3-7": {
        "api_key": os.getenv('OpenAiKey'),
        "base_url": "https://a.fe8.cn/v1",
        "model_name": "claude-3-7-sonnet-20250219"
    }
}

def check_model_list(client):
    try:
        # 获取模型列表
        models = client.models.list()

        # 提取可用的模型ID
        available_models = [model.id for model in models.data]

        print("可用的模型有:")
        for model in available_models:
            print(model)

    except Exception as e:
        print(f"获取模型列表时出错: {e}")


def main():
    try:
        # 获取命令行参数 Num
        if len(sys.argv) != 4:
            print("Usage: python script.py <Num> <excel_file> <TestName>")
            return
        num_calls = int(sys.argv[1])
        # Save to Excel
        #excel_file = 'gpt_record-script.xlsx'
        excel_file = sys.argv[2]
        TestName = sys.argv[3]

    

        # 默认使用的配置名称
        # SELECTED_MODEL = "gpt-4o"
        # SELECTED_MODEL = "deepseek-v3"
        SELECTED_MODEL = "gpt-5.2"  
        # SELECTED_MODEL = "claude-sonnet-4-5-20250929" # 用户可以修改这个变量来选择不同的配置


        # 获取当前配置
        current_config = MODEL_CONFIGS[SELECTED_MODEL]

        # 使用配置
        api_key = current_config["api_key"]
        base_url = current_config["base_url"]
        model_name = current_config["model_name"]


        print("llm_call begin: ", model_name)

        if not api_key:
            raise ValueError("not set OpenAiKey env value")
        
        client = initialize_client(api_key, base_url)

        #check_model_list(client)


        # Read system and user content
        #system_content = read_file('system_content.txt')
        system_content = ""
        user_content = read_file('user_content.txt')

        

        gpt_responses = []

        # 依次调用API Num 次
        gpt_responses = call_openai_api_concurrently(client, system_content, user_content, model_name, num_calls)


        #current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        
        save_to_excel(excel_file, TestName, model_name, system_content, user_content, gpt_responses)

    except Exception as e:
        gpt_logger.exception("Get exception: %s", e)

if __name__ == "__main__":
    shell_command = "unset all_proxy unset ALL_PROXY" # to recover the network
    os.system(shell_command)
    main()
