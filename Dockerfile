#Use ubuntu 22.04 as a base image
FROM ubuntu:22.04

# 必要なソフトウェアをインストールするために非対話モードを設定
ENV DEBIAN_FRONTEND=noninteractive

#Setting of timezone
ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#Installation of required packages
RUN apt-get update && \
    apt-get install -y \
    git \
    vim \
    curl \
    wget \
    zip \
    unzip \
    net-tools \
    dnsutils \
    iputils-ping \
    build-essential \
    software-properties-common \
    jq \
    g++ \
    libboost-all-dev \
    libbz2-dev \
    && rm -rf /var/lib/apt/lists/*

#Introduce MaSuRCA
WORKDIR /mashimashi
RUN wget https://github.com/alekseyzimin/masurca/releases/download/v4.1.0/MaSuRCA-4.1.0.tar.gz
RUN tar -zxvf MaSuRCA-4.1.0.tar.gz
COPY install.sh /mashimashi/MaSuRCA-4.1.0
WORKDIR /mashimashi/MaSuRCA-4.1.0
RUN bash ./install.sh

#Introduce Flye
WORKDIR /mashimashi
RUN git clone https://github.com/fenderglass/Flye
WORKDIR Flye
RUN make

#Introduce Canu
WORKDIR /mashimashi
RUN curl -L https://github.com/marbl/canu/releases/download/v2.2/canu-2.2.Linux-amd64.tar.xz --output canu-2.2.Linux.tar.xz
RUN tar -xJf canu-2.2.*.tar.xz
