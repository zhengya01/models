#!/bin/bash
# Download dataset and model parameters
set -e

echo "Download ERNIE 1.0"
mkdir pretrained_model
cd pretrained_model
wget --no-check-certificate https://ernie.bj.bcebos.com/ERNIE_1.0_max-len-512.tar.gz
tar -zxvf ERNIE_1.0_max-len-512.tar.gz
rm ERNIE_1.0_max-len-512.tar.gz
cd ..

echo "Download DuReader-robust dataset"
# echo "Oppos, the DuReader-robust dataset will be realesed soon"
wget --no-check-certificate yq01-rp-nlp-rd1.yq01.baidu.com:/home/disk1/dqa/lihongyu04/2020_dureader/baseline/dureader_robust-basic.data.tar.gz 
tar -zxvf dureader_robust-basic.data.tar.gz
mv dureader_robust-basic data
rm dureader_robust-basic.data.tar.gz

echo "Download fine-tuned parameters"
wget --no-check-certificate yq01-rp-nlp-rd1.yq01.baidu.com:/home/disk1/dqa/lihongyu04/2020_dureader/baseline/dureader_robust-baseline-finetuned.tar.gz
tar -zxvf dureader_robust-baseline-finetuned.tar.gz
rm dureader_robust-baseline-finetuned.tar.gz
