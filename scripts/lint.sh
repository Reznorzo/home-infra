#!/usr/bin/env bash

set -e

PATH=${PWD}/env/bin:${PATH}

yamllint -sc yamllint.yml ./ansible

cd ansible/playbooks

ansible-playbook playbooks/run.yml --syntax-check