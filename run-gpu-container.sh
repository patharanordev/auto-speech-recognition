mkdir -p kaldi_data && \
docker run -d -t \
-v ./kaldi_data:/opt/ \
--name="kaldi-tf-gpu" \
--restart=always \
patharanor/kaldi-tf-gpu:0.0.1