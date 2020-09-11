#!/bin/sh

set -ex

pip install --upgrade pip
pip install pipenv

pipenv --python 3.6

pipenv install tensorflow==1.4.1

# PIP_NO_BINARY=1 PIP_NO_CACHE_DIR=off pipenv install pandas

PY_DIR='/build/python/lib/python3.6/site-packages'

mkdir -p $PY_DIR                                              #Create temporary build directory

pipenv lock -r > requirements.txt                             #Generate requirements file

pip install -r requirements.txt --no-deps -t $PY_DIR

# remove non-standard enum34
rm -rf /build/python/lib/python3.6/site-packages/enum34-1.1.10.dist-info
rm -rf /build/python/lib/python3.6/site-packages/enum