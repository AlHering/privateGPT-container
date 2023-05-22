#!/bin/bash
source /privateGPT-container/venv/bin/activate && python3 set_model.py && cd /privateGPT-container/privateGPT/ && python3 ingest.py && python3 privateGPT.py
