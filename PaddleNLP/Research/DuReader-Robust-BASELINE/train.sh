#!/bin/bash
export PYTHONIOENCODING=utf-8

if [ -z "$CUDA_VISIBLE_DEVICES" ];then
    export CUDA_VISIBLE_DEVICES=0
fi

echo "CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES"


if [ -z "$MODEL_PATH" ];then
    MODEL_PATH="./pretrained_model"
fi
echo "MODEL_PATH=$MODEL_PATH"

python -u src/run_mrc.py --use_cuda true \
                --batch_size 4 \
                --checkpoints output \
                --init_pretraining_params ${MODEL_PATH}/params \
                --vocab_path ${MODEL_PATH}/vocab.txt \
                --ernie_config ${MODEL_PATH}/ernie_config.json \
                --save_steps 10000 \
                --warmup_proportion 0.1 \
                --weight_decay  0.01 \
                --epoch 2 \
                --max_seq_len 512 \
                --do_lower_case true \
                --doc_stride 128 \
                --learning_rate 3e-5 \
                --skip_steps 25 \
                --max_answer_length 30 \
                --do_train true \
                --do_predict true \
                $@

