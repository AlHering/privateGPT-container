# -*- coding: utf-8 -*-
"""
****************************************************
*              privateGPT-container                 
*            (c) 2023 Alexander Hering             *
****************************************************
"""
import sys
import os
import json


model = os.environ.get("MODEL_TO_USE", "eachadea_ggml-vicuna-13b-1.1/ggml-vicuna-13b-1.1-q4_3.bin")
shared_model_folder = "/privateGPT-container/machine_learning_models/MODELS"
local_model_target = "/privateGPT-container/privateGPT/models"
env_path = "/privateGPT-container/privateGPT/.env"


if not os.path.exists(local_model_target):
    os.system(f"ln -sf {shared_model_folder} {local_model_target}")


data_path = os.path.join(shared_model_folder, "data.json")
if os.path.exists(data_path):
    model_data = json.load(open(, 'r', encoding='utf-8'))[model]
else:
    model_data = {"type": "LlamaCpp"}

env_file_content = f"""PERSIST_DIRECTORY=db
MODEL_TYPE={model_data['type']}
MODEL_PATH=models/{model}
EMBEDDINGS_MODEL_NAME=all-MiniLM-L6-v2
MODEL_N_CTX=1000
"""

if os.path.exists(env_path):
    os.remove(env_path)
open(env_path, "w", encoding='utf-8').write(env_file_content)

