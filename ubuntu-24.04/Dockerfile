FROM ubuntu:24.04

LABEL maintainer="Rani Chowdary Mandepudi"
LABEL description="Build MySQL 8.0.35 for Arm64 on Ubuntu 24.04 using system libraries"

ENV DEBIAN_FRONTEND=noninteractive

# Install required build dependencies
RUN apt-get update && apt-get install -y \
    build-essential cmake bison pkg-config \
    libssl-dev libncurses-dev libaio-dev \
    git libevent-dev libz-dev \
    libtirpc-dev libreadline-dev \
    liblz4-dev libedit-dev curl ca-certificates unzip \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /build

ADD https://github.com/ranimandepudi/mysql-8.0.35-arm64-builder/releases/download/mysql-arm64-8.0.35/mysql-boost-8.0.35-arm64-src.tar.gz.zip .
RUN unzip mysql-boost-8.0.35-arm64-src.tar.gz.zip && tar -xzf mysql-boost-8.0.35-arm64-src.tar.gz
# Extract source
RUN tar -xzf mysql-boost-8.0.35-arm64-src.tar.gz

WORKDIR /build/mysql-8.0.35

# Create build directory
RUN mkdir build

WORKDIR /build/mysql-8.0.35/build

# Configure build with required flags
RUN cmake .. \
  -DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
  -DWITH_BOOST=../boost \
  -DWITH_SSL=system \
  -DWITH_ZLIB=system \
  -DWITH_EDITLINE=system \
  -DWITH_LZ4=system \
  -DWITH_INNODB_MEMCACHED=OFF \
  -DWITH_MYSQLX=OFF \
  -DWITH_LTO=OFF \
  -DCMAKE_C_FLAGS="-fno-lto" \
  -DCMAKE_CXX_FLAGS="-fno-lto" \
  -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=OFF

# Compile and install
RUN make -j$(nproc) && make package
RUN find . -name "*.deb" -exec cp {} /usr/local/mysql.deb \;
RUN rm -rf /build/mysql-8.0.35*

CMD ["/usr/local/mysql/bin/mysqld", "--version"]
