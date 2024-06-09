FROM debian:stable-slim
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    bash \
    bc \
    binutils \
    bzip2 \
    cpio \
    file \
    g++ \
    gcc \
    gettext \
    git \
    gzip \
    locales \
    libncurses5-dev \
    libdevmapper-dev \
    libsystemd-dev \
    make \
    mercurial \
    whois \
    patch \
    perl \
    python3 \
    rsync \
    sed \
    tar \
    texinfo \
    vim \
    unzip \
    wget \
    bison \
    flex \
    libssl-dev \
    libfdt-dev

RUN locale-gen en_US.utf8

WORKDIR /root/
RUN git clone --depth 1 --branch 2023.08.3 https://github.com/buildroot/buildroot.git
COPY zc706_qemu_webserver_defconfig buildroot/configs/
WORKDIR /root/buildroot
RUN make zc706_qemu_webserver_defconfig
RUN make -j$(($(nproc)-1))

ENV PATH="${PATH}:output/host/bin/"

RUN qemu-img resize output/images/sdcard.img 128M
COPY run-qemu.sh ./
ENTRYPOINT ["/bin/bash", "run-qemu.sh"]
