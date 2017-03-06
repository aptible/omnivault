#!/bin/sh

cd /tmp
git clone https://github.com/sstephenson/bats.git
cd bats/
./install.sh /usr/local
cd ..
rm -rf bats/
