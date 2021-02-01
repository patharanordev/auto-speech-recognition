mkdir -p kaldi_data && \
docker run -d -t \
-v ./kaldi_data:/opt/ \
--name="kaldi-cpu" \
--restart=always \
patharanor/kaldi-cpu:0.0.1