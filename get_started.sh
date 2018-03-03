#!/usr/bin/env bash

# Get directory containing this script
HEAD_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CODE_DIR=$HEAD_DIR/code
DATA_DIR=$HEAD_DIR/data
EXP_DIR=$HEAD_DIR/experiments

mkdir -p $EXP_DIR

# Creates the environment
conda create -n squad python=3

# Activates the environment
source activate squad

# pip install into environment
pip install -r requirements.txt

# download punkt and perluniprops
python3 -m nltk.downloader punkt
python3 -m nltk.downloader perluniprops

# Download and preprocess SQuAD data and save in data/
mkdir -p "$DATA_DIR"
rm -rf "$DATA_DIR"
python3 "$CODE_DIR/preprocessing/squad_preprocess.py" --data_dir "$DATA_DIR"

# Download GloVe vectors to data/
python3 "$CODE_DIR/preprocessing/download_wordvecs.py" --download_dir "$DATA_DIR"
