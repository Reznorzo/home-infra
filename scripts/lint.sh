#!/usr/bin/env bash

set -e

PATH=${PWD}/env/bin:${PATH}

yamllint -sc yamllint.yml ./ansible

cd ansible/playbooks

ansible-lint -p

ansible-playbook run.yml --syntax-check