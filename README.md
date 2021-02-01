# **Auto-Speech Recognition (ASR) for Thai Language with Kaldi**

## **Requirement**

 - Docker daemon and docker-compose

## **Preparing Environment**

### **Run Kaldi**

**Docker container**

```bash
# For CPU
$ sh run-cpu-container.sh

# For GPU
$ sh run-gpu-container.sh
```

**Docker Compose**

```bash
$ mkdir -p kaldi_data

# CPU
$ docker-compose -f docker-compose.cpu.yml down -v && \
docker-compose -f docker-compose.cpu.yml up

# GPU
$ docker-compose -f docker-compose.gpu.yml down -v && \
docker-compose -f docker-compose.gpu.yml up
```

Let's check our service :

```bash
$ docker ps -a

# Now you should see output like this :

CONTAINER ID   IMAGE                           COMMAND                  CREATED             STATUS             PORTS                                            NAMES
6beaca75112b   auto-speech-recognition_kaldi   "sh entrypoint.sh"       About an hour ago   Up About an hour                                                    kaldi
```

### **Load Dataset**

> **IMPORTANT** : Please don't forget change `YOUR_COMMON_VOICE_DIR` to your directory name.

After setup `Kalbi`, it requires common voice from `Mozilla`, you need to download it and extract it into `./kaldi_data/kaldi/egs/YOUR_COMMON_VOICE_DIR`.

### **Access to the container**

This step, you need to access to the service via `docker` command :

```bash
$ docker exec -it kaldi /bin/sh
```

### **[Optional] Data Preparation**


 - [Optional] Data preparation (pass this item if you already have `.wav`) :
   
   Convert `mp3` to `wav` file format by `sox` command based on specific sampling rate (option `-r`, in this case, sampleing rate is 16000) : 

   ```bash
   $ sox input.mp3 -r 16000 ouput.wav
   ```
 - Word segmentation. For Thai language, you can use `TLex+` (in `Developer > Basic NLP > TLex++`) in [`AI for Thai`'s API](https://aiforthai.in.th/) to split the word.
 - Convert `word list` to `Grapheme to Phoneme(G2P)` to `Dictionary`. For Thai language, you can use `G2P` (in `Developer > Basic NLP > G2P`) in [`AI for Thai`'s API](https://aiforthai.in.th/) to convert it.
 - After that, you dict should be in `/opt/kaldi/egs/YOUR_COMMON_VOICE_DIR/s5/data/local/dict/*.dict`
 
### **Run all in one with CPU**

 - Training data preparation
 - Language model preparation
 - Feature extraction
 - Accoustic model training
   - monophone
   - tri1
   - tri2b
   - tri3b
   - tri4b

Go to `/opt/kaldi/egs/YOUR_COMMON_VOICE_DIR/s5` and run script `run.sh` :

```bash
$ cd /opt/kaldi/egs/YOUR_COMMON_VOICE_DIR/s5 && bash run.sh
```

### **Evaluation**

[optional] Create shell script to print result out to `RESULT_{number}`:

```sh
# Ex. result.sh

rm -rf "RESULT_$1"

for x in exp/*/decode*; do [ -d $x ] && grep WER $x/wer_* | utils/best_wer.sh >> "RESULT_$1" ; done
for x in exp/chain/*/decode*; do [ -d $x ] && grep WER $x/wer_* | utils/best_wer.sh >> "RESULT_$1" ; done
```

Run script :

```bash
$ bash result.sh 1

# Output in RESULT_1 file:
%WER 66.73 [ 10598 / 15883, 750 ins, 2025 del, 7823 sub ] exp/mono/decode_valid_dev/wer_9_0.0
%WER 59.52 [ 9453 / 15883, 787 ins, 1569 del, 7097 sub ] exp/tri1/decode_valid_dev/wer_15_0.0
%WER 59.40 [ 9434 / 15883, 985 ins, 1319 del, 7130 sub ] exp/tri2b/decode_valid_dev/wer_17_0.0
%WER 59.23 [ 9407 / 15883, 836 ins, 1529 del, 7042 sub ] exp/tri3b/decode_valid_dev/wer_17_0.5
%WER 59.76 [ 9492 / 15883, 1084 ins, 1181 del, 7227 sub ] exp/tri3b/decode_valid_dev.si/wer_17_0.0
%WER 58.96 [ 9364 / 15883, 796 ins, 1560 del, 7008 sub ] exp/tri4b/decode_valid_dev/wer_17_0.5
%WER 59.10 [ 9387 / 15883, 1000 ins, 1215 del, 7172 sub ] exp/tri4b/decode_valid_dev.si/wer_17_0.0
```

### **Training Chain Model (CPU)**

```bash
$ /opt/kaldi/egs/YOUR_COMMON_VOICE_DIR/s5/local/chain/run_tdnn_cpu.sh
```

## **Challenge**

Let's reduce `WER`, by training chain model in `/opt/kaldi/egs/YOUR_COMMON_VOICE_DIR/s5/local/chain/`.

### **GPU Base**

**Training Chain Model**

```bash
$ /opt/kaldi/egs/YOUR_COMMON_VOICE_DIR/s5/local/chain/run_tdnn.sh --stage 0
```

**Evaluation**

```bash
$ cat slurm-xxx.out
```

## **Contributing**

**GPU**

```bash
$ docker build -f Dockerfile.gpu -t patharanor/kaldi-tf-gpu:0.0.1 .
```