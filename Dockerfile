FROM ubuntu:24.04 AS base

ARG VER=0.26.8
RUN apt-get update -y && \
    apt-get install -yqq \
        ca-certificates \
        wget \
        curl \
        telnet \
        gpg \
        apt-transport-https && \
        apt clean

#RUN curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
#  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
#    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
#    tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# Pull down the tar, unpack, rename folder, remove tar
RUN wget https://github.com/trexminer/T-Rex/releases/download/$VER/t-rex-$VER-linux.tar.gz && \
  mkdir trex-miner && \
  tar -xf t-rex-$VER-linux.tar.gz -C trex-miner && \
  rm t-rex-$VER-linux.tar.gz

RUN ln -s libnvidia-ml.so.1 /lib/x86_64-linux-gnu/libnvidia-ml.so

# Bring in the config.ini
#COPY config.ini /trex-miner
COPY startup.sh /trex-miner

WORKDIR trex-miner
RUN chmod +x startup.sh

# Add in start.up to read env variables
CMD ["./startup.sh"]
        
#https://github.com/trexminer/T-Rex/releases/download/0.26.8/t-rex-0.26.8-linux.tar.gz