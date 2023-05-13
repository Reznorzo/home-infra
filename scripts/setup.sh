#!/usr/bin/env bash

export BW_SESSION=$(bw unlock --raw)
export GITHUB_TOKEN=$(bw get password "ghToken")
export GITHUB_USER=Reznorzo

set -e

PATH=${PWD}/env/bin:${PATH}

set -x

python3 -m venv env

pip install -r ansible/dev-requirements.txt

cd ansible/ && ansible-galaxy install -r requirements.yml --force