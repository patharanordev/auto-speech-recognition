git clone https://github.com/kaldi-asr/kaldi.git /opt/kaldi --origin upstream && \
cd /opt/kaldi/tools && \
./extras/install_mkl.sh && \
make && \
cd /opt/kaldi/src && \
./configure --shared && \
make depend && \
make