#!/bin/bash
set -e

# Install ruby
apt update
apt install -y ruby-full
apt install -y ruby-bundler
apt install -y build-essential
