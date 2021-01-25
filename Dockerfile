FROM ubuntu:18.04
LABEL maintainer="PatharaNor"

WORKDIR /opt/kaldi

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        g++ \
        make \
        automake \
        autoconf \
        bzip2 \
        unzip \
        wget \
        sox \
        libtool \
        git \
        subversion \
        python2.7 \
        python3 \
        zlib1g-dev \
        ca-certificates \
        gfortran \
        patch \
        ffmpeg \
	vim && \
    rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3 /usr/bin/python

RUN git clone https://github.com/kaldi-asr/kaldi.git /opt/kaldi

RUN cd /opt/kaldi/tools && \
    ./extras/install_mkl.sh && \
    make

RUN cd /opt/kaldi/src && \
    ./configure --shared && \
    make depend && \
    make
    #     && \
    #    find /opt/kaldi -type f \( -name "*.o" -o -name "*.la" -o -name "*.a" \) -exec rm {} \; && \
    #    find /opt/intel -type f -name "*.a" -exec rm {} \; && \
    #    find /opt/intel -type f -regex '.*\(_mc.?\|_mic\|_thread\|_ilp64\)\.so' -exec rm {} \; && \
    #    rm -rf /opt/kaldi/.git