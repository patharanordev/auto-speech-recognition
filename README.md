# **Auto-Speech Recognition (ASR) for Thai Language with Kaldi**

## **Requirement**

 - Docker daemon and docker-compose

## **Preparing Environment**

### **Setup Kaldi**

```bash
$ sh build-base-linux.sh
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

### **Preparing Data for Training**

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

Go to `/opt/kaldi/egs/YOUR_COMMON_VOICE_DIR` and run script `run.sh` :

```bash
$ bash run.sh
```

### **Evaluation**

```bash
$ cat /opt/kaldi/egs/YOUR_COMMON_VOICE_DIR/s5/RESULTS

#cv-corpus-6.1-2020-12-11_th
# monophone system
# monophone system (shortest 10k)
%WER 66.85 [ 10618 / 15883, 737 ins, 1987 del, 7894 sub ] exp/mono/decode_valid_dev/wer_9_0.0
# delta + delta-delta triphone system (20k)
%WER 59.46 [ 9444 / 15883, 674 ins, 1757 del, 7013 sub ] exp/tri1/decode_valid_dev/wer_17_0.0
# LDA+MLLT system (20k)
%WER 58.98 [ 9367 / 15883, 767 ins, 1588 del, 7012 sub ] exp/tri2b/decode_valid_dev/wer_17_0.5
# LDA+MLLT+SAT system (20k)
%WER 58.49 [ 9290 / 15883, 780 ins, 1609 del, 6901 sub ] exp/tri3b/decode_valid_dev/wer_17_0.5
%WER 59.20 [ 9403 / 15883, 1052 ins, 1198 del, 7153 sub ] exp/tri3b/decode_valid_dev.si/wer_17_0.0
# LDA+MLLT+SAT system trained on entire training set
%WER 63.87 [ 10144 / 15883, 897 ins, 1770 del, 7477 sub ] exp/tri4b/decode_valid_dev/wer_17_0.5
%WER 63.64 [ 10108 / 15883, 1022 ins, 1551 del, 7535 sub ] exp/tri4b/decode_valid_dev.si/wer_17_0.5

# chain tdnn system
%WER 48.25 [ 7663 / 15883, 696 ins, 1499 del, 5468 sub ] exp/chain/tdnn1a_sp/decode_valid_dev/wer_13_0.0
%WER 49.78 [ 9183 / 18448, 725 ins, 1904 del, 6554 sub ] exp/chain/tdnn1a_sp/decode_valid_test/wer_13_0.5

%WER 47.88 [ 7605 / 15883, 707 ins, 1436 del, 5462 sub ] exp/chain/tdnn1a_sp_online/decode_valid_dev/wer_13_0.0
%WER 49.05 [ 9048 / 18448, 753 ins, 1859 del, 6436 sub ] exp/chain/tdnn1a_sp_online/decode_valid_test/wer_15_0.0
```

## **Challenge**

Let's reduce `WER`, by training chain model in `/opt/kaldi/egs/YOUR_COMMON_VOICE_DIR/s5/local/chain/`.
### **Training Chain Model**

```bash
$ /opt/kaldi/egs/YOUR_COMMON_VOICE_DIR/s5/local/chain/run_tdnn.sh --stage 0
```

### **Evaluation**

```bash
$ cat slurm-xxx.out
```