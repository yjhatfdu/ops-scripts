#!/bin/bash
if [ -z $PYTHON_VERSION ]; then
	PYTHON_VERSION=3.5.1
fi
apt-get build-dep -y python3
apt-get install -y libsqlite3-dev libssl-dev liblzma-dev libbz2-dev zlib1g-dev libreadline-dev libgdbm-dev libncurses5-dev
wget https://www.python.org/ftp/python/3.5.1/Python-$PYTHON_VERSION.tar.xz
tar xf Python-$PYTHON_VERSION.tar.xz
cd Python-$PYTHON_VERSION
./configure
make -j4 install
python3 -m pip install --upgrade setuptools pip virtualenv virtualenvwrapper

