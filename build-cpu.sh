mkdir -p kaldi_data && \
docker-compose -f docker-compose.cpu.yml down -v && \
docker-compose -f docker-compose.cpu.yml up --build