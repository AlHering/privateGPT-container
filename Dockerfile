FROM ubuntu:22.04
ENV PYTHONUNBUFFERED 1

# Setting up basic repo 
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Setting up working directory
ADD ./ privateGPT-container/
WORKDIR /privateGPT-container
ENV RUNNING_IN_DOCKER True
ENV MODEL_TO_USE="eachadea_ggml-vicuna-13b-1.1/ggml-vicuna-13b-1.1-q4_3.bin"
COPY . .

# Install prerequisits
RUN apt-get update && apt-get install -y apt-utils \
        software-properties-common \
        build-essential wget curl git nano ffmpeg libsm6 libxext6 \
        p7zip-full p7zip-rar \
        python3-pip python3-venv

# Create venv
RUN if [ ! -d "venv" ]; \
then \
    python3 -m venv venv; \
fi

# Handle models 
RUN ln -sf /privateGPT-container/machine_learning_models/MODELS /privateGPT-container/privateGPT/models && python3 /privateGPT-container/set_model.py

# Link document folder
RUN ln -sf /privateGPT-container/documents /privateGPT-container/privateGPT/source_documents

# Setting up privateGPT environment
RUN . /privateGPT-container/venv/bin/activate && python3 -m pip install -r /privateGPT-container/privateGPT/requirements.txt

# Start privateGPT
CMD ["/bin/bash", "run_privateGPT.sh"]

