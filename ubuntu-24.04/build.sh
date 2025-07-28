#!/bin/bash
set -euo pipefail

# MySQL version and install path
MYSQL_VERSION="8.0.35"
INSTALL_PREFIX="/usr/local/mysql"

# Step 1: Install build dependencies
sudo apt-get update
sudo apt-get install -y \
  build-essential cmake bison pkg-config \
  libssl-dev libncurses-dev libaio-dev \
  git libevent-dev libz-dev \
  libtirpc-dev libreadline-dev \
  liblz4-dev libedit-dev

# Step 2: Extract source tarball
tar -xzf mysql-boost-${MYSQL_VERSION}-arm64-src.tar.gz
cd mysql-${MYSQL_VERSION}

# Step 3: Configure CMake build
mkdir build && cd build
cmake .. \
  -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} \
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

# Step 4: Build and install
make -j$(nproc)
sudo make install

# Step 5: Verify
echo "Installed MySQL version:"
${INSTALL_PREFIX}/bin/mysqld --version
echo "Installed semisync plugins:"
ls ${INSTALL_PREFIX}/lib/plugin/semisync_*.so
