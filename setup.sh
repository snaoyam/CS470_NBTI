#!/bin/bash
source ~/anaconda3/etc/profile.d/conda.sh
## setting conda env
conda env create -f word_env.yaml
pip install diffusers
pip install --upgrade torch torchvision

## download dataset
# will only work in KAIST internal network
wget http://143.248.235.11:5000/fontsdataset/dataset.zip
unzip dataset.zip -d ./code/data/

wget http://143.248.235.11:5000/env_file
mv env_file ./.env

## learn embedding loss
conda init bash
conda activate word
python ./code/letter_classifier.py 0 100

## copy best weight checkpoint
cp ./logs/0/max_val_acc_checkpoint.pt .code/max_val_acc_checkpoint.pt

## Fine tuning GPT-3.5
# uncomment below to do finetuning
# bash ./code/finetuning/finetunemodel.sh
