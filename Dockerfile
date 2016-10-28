FROM ubuntu:14.04

RUN \
  DEBIAN_FRONTEND=noninteractive apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \ 
    git \
    curl \
    cmake pkg-config \
    libprotoc-dev \
    libprotobuf8 \
    protobuf-compiler \
    libprotobuf-dev \
    libosmpbf-dev \
    libpng12-dev \
    libtbb-dev \
    libbz2-dev \
    libstxxl-dev \
    libstxxl-doc \
    libstxxl1 \
    libxml2-dev \
    libzip-dev \
    libboost-all-dev \
    lua5.1 \
    liblua5.1-0-dev \
    libluabind-dev \
    libluajit-5.1-dev \
    wget

WORKDIR /src

RUN \
  wget "https://github.com/Project-OSRM/osrm-backend/archive/v4.7.1.tar.gz" && \
  tar zxvf v4.7.1.tar.gz && \
  mkdir -p /build && \
  cd /build && \
  cmake /src/osrm-backend-4.7.1 && make && \
  mv /src/osrm-backend-4.7.1/profiles/bicycle.lua profile.lua && \
  mv /src/osrm-backend-4.7.1/profiles/lib/ lib && \
  echo "disk=/tmp/stxxl,25000,syscall" > /build/.stxxl && \
  rm -rf /src

WORKDIR /build
ADD run.sh run.sh
EXPOSE 5000
