#!/usr/bin/env bash

set -e

PATH=${PWD}/env/bin:${PATH}

yamllint . -sc yamllint.yml

cd ansible/

ansible-lint -p

ansible-playbook main.yml --syntax-check