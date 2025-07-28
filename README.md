## MYSQL 8.0.35 Arm64 Builder 

This repository provides fully reproducible build setup to compile and package MYSQL 8.0.35 for Arm64, matching the behavior and layout of Oracle's Amd64 .deb packages with full semisync plugin support and verified copmpatibility with Vitess CI on Arm.

### Key Features

Compiles MySQL 8.0.35 from source on Ubuntu 24.04(Arm64)
Uses system libraries (eg: libssl3,libncurses6) - no legacy bundling
Includes all required semi-sync plugins
Output layout and behavior matches official .deb packages on Amd64

### Build Environment 

Base OS: Ubuntu 24.04 Arm64
MySQL source: https://github.com/ranimandepudi/vitess/releases/tag/mysql-arm64-8.0.35 
Install Prefix: /usr/local/mysql


### Using the Dockerfile

docker build -t mysql-arm64-builder:8.0.35 .

This will build MySQL from source and install it to /usr/local/mysql.

### Repository Structure

mysql-8.0.35-arm64-builder/
├── ubuntu-24.04/
│   ├── Dockerfile         # Reproducible build setup
│   └── build.sh           # (Planned) Standalone local build script
├── mysql-boost-8.0.35-arm64-src.tar.gz
├── LICENSE
└── README.md

