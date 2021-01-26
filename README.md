# **Auto-Speech Recognition (ASR) for Thai Language with Kaldi**

## **Requirement**

 - Docker daemon and docker-compose

## **Preparing Environment**

### Setup Kaldi

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

### Load Dataset

After setup `Kalbi`, it requires common voice from `Mozilla`, you need to download it and extract it into `./kaldi_data/kaldi/egs/YOUR_COMMON_VOICE_DIR`.

### Preparing Data for Training

This step, you need to access to the service via `docker` command :

```bash
$ docker exec -it kaldi /bin/sh
```

then go to `/opt/kaldi/egs/YOUR_COMMON_VOICE_DIR` and run script `run.sh` :

```bash
$ bash run.sh
```

Waiting for data preparation.

## **Train Model**

Coming soon...

> ### **Original Steps**
> 
> IT WILL BE UPDATE SOON...
> 
> git clone https://github.com/kaldi.git kaldi --origin upstream
> 
> @kaldi/egs/commonvoice/s5
> run บน TARA -> run  `sbatch job.cpu.sh`
> run บนเครื่อง -> run script `sh run.sh`
> output ดูได้จาก `slurm-xxx.out`
> 
> ต้องแก้ project id เป็นของตัวเองก่อนสั่ง run
> 
> แต่ถ้าจะใช้ singularity จะใช้อีก command นึง
> 
> convert any music file extent to `.wav`:
> 
>  - sampling rat : 16000
> 
> ```bash
> $ sox input.mp3 -r 16000 output.wav
> ```
> 
> 
> ต้องติดตั้ง SRILM ก่อนจึงจะ train model ได้ อยู่ใน `tools/install_srilm.sh`
> 
> 
> ## Command
> 
> Run on TARA:
> 
> ```bash
> $ singularity exec --nv kaldi_20.03-py3.sif bash run.sh
> ```
> 
> Word segmentation:
> 
> ```bash
> $ curl -v -X GET -H ""
> ```
> ...