# Dureader$_{\rm robust}$ Dataset
$\rm Dureader_{\rm robust}$ is a real-word and human sourced Chinese MRC dataset. It aims to evaluate the robustness of MRC models, which focuses on the oversensitivity, overstablility and generalization challenges. The advantages of $\rm Dureader_{\rm robust}$ over existing datasets are concluded as follows:

- Real passages and questions
- Various challenges encountered in the real applications
- Well designed adversary samples by NLP experts
 
For more details about the dataset, please refer to this [paper](None).

# Dureader$_{\rm robust}$ Baseline System
In this repository, we release the baseline system for Dureader$_{\rm robust}$ dataset. The baseline system is based on [Ernie 1.0](https://arxiv.org/abs/1904.09223), and is implemented with [PaddlePaddle](https://www.paddlepaddle.org.cn/) framework. To run the baseline system, please follow the instructions below.

## Environment Requirements
The baseline system has been tested on

 - CentOS 6.3
 - PaddlePaddle 1.6.1 
 - Python 2.7.13 & Python 3.7.3
 - Cuda 9.0
 - CuDnn 7.0
 
To install PaddlePaddle, please see the [PaddlePaddle Homepage](http://paddlepaddle.org/) for more information.


## Download
Before run the baseline system, please download the $\rm Dureader_{\rm robust}$ dataset and the pretrained model parameters (ERNIE 1.0 base):

```
sh download.sh
```
The dataset will be saved into `data/dureader_robust-basic/`, the pretrained and fine-tuned model parameters will be saved into `pretrained_model/` and `finetuned_model`, respectively.

## Run Baseline

### Training
To fine-tune a model (on the demo dataset), please run the following command:

```
sh train.sh --train_file data/demo/demo_train.json --predict_file data/demo/demo_dev.json 
```
This will start the training process on the demo dataset. At the end of training, model parameters and predictions will be saved into `output/`. 

To train the model with user specified arguments (e.g. multi-GPUs, more epochs and larger batch size):

```
CUDA_VISIBLE_DEVICES=0,1,2,3 sh train.sh --epoch 5 --batch_size 8 --train_file data/demo/demo_train.json --predict_file data/demo/demo_dev.json 
```
One can also directly modify the arguments in `train.sh`. More arguments can be found in `src/run_mrc.py`.

### Prediction
To predict with fine-tuned parameters, (e.g. on the devlopment set), please run the following command:

```
MODEL_PATH=<your_model_dir> sh predict.sh --predict_file data/dureader_robust-basic/basic.dev.json
```
The model under `your_model_dir` (e.g. `finetuned_model` as we have provided) will be loaded for prediction. The predicted answers will be saved into `output/`.

## Evaluateion
F1-score and exact match (EM) are used as evaluation metrics. Here we provide a script `evaluate-DR-robust.py` for evaluation.

To evluate, run

```
python evaluate-DR-robust.py <reference_file> <prediction_file>
```
Where `<reference_file>` is the dataset file (e.g. `data/dureader_robust-basic/basic.dev.json`), `<prediction_file>` is the model prediction (e.g. `output/basic.dev_predictions.json`), which must be a valid JSON file of (qid, answer) pairs, for example:

```
{
    "question_id_1" : "answer for question 1",
    ...
    "question_id_N": "answer for question N"
}
```

After runing the evaluation script, one will get an output similar with this:

```
{"F1": "80.842", "EM": "69.019", "TOTAL": 1417, "SKIP": 0}
```

## Baseline Performance
The performance of our baseline model (i.e. the fine-tuned model we provided above) are shown below:

| Dataset | F1 | EM |
| --- | --- | --- |
| basic dev | 80.84 | 69.02 |



## Copyright and License
Copyright 2020 Baidu.com, Inc. All Rights Reserved

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.