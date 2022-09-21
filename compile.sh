#!/bin/sh
cd build
make
cd ..
rm tfs
ln -s build/tfs tfs