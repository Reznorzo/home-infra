#!/usr/bin/env bash

set -e

PATH=${PWD}/env/bin:${PATH}

set -x

python3 -m venv env

pip install -r ansible/dev-requirements.txt

cd ansible/ && ansible-galaxy install -r requirements.yml --force