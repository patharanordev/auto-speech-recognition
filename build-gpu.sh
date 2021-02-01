mkdir -p kaldi_data && \
docker-compose -f docker-compose.gpu.yml down -v && \
docker-compose -f docker-compose.gpu.yml up --build