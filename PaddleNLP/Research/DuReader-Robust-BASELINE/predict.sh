#!/bin/bash
export PYTHONIOENCODING=utf-8

if [ -z "$CUDA_VISIBLE_DEVICES" ];then
    export CUDA_VISIBLE_DEVICES=0
fi

echo "CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES"


if [ -z "$MODEL_PATH" ];then
    MODEL_PATH="./finetuned_model"
fi
echo "MODEL_PATH=$MODEL_PATH"

python -u src/run_mrc.py --use_cuda true \
                --batch_size 24 \
                --checkpoints output \
                --init_checkpoint ${MODEL_PATH}/params \
                --vocab_path ${MODEL_PATH}/vocab.txt \
                --ernie_config ${MODEL_PATH}/ernie_config.json \
                --max_seq_len 512 \
                --do_lower_case true \
                --doc_stride 128 \
                --max_answer_length 30 \
                --do_train false \
                --do_predict true \
                $@


