

git clone https://github.com/kaldi.git kaldi --origin upstream




@kaldi/egs/commonvoice/s5
run บน TARA -> run  `sbatch job.cpu.sh`
run บนเครื่อง -> run script `sh run.sh`
output ดูได้จาก `slurm-xxx.out`

ต้องแก้ project id เป็นของตัวเองก่อนสั่ง run

แต่ถ้าจะใช้ singularity จะใช้อีก command นึง

convert any music file extent to `.wav`:

 - sampling rat : 16000

```bash
$ sox input.mp3 -r 16000 output.wav
```


ต้องติดตั้ง SRILM ก่อนจึงจะ train model ได้ อยู่ใน `tools/install_srilm.sh`


## Command

Run on TARA:

```bash
$ singularity exec --nv kaldi_20.03-py3.sif bash run.sh
```

Word segmentation:

```bash
$ curl -v -X GET -H ""
```