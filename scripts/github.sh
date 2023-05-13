#!/bin/bash
green=$'\e[0;32m'
red=$'\e[0;31m'
reset=$'\e[0m'

export BW_SESSION=$(bw unlock --raw)
export GITHUB_TOKEN=$(bw get password "ghToken")
export GITHUB_USER=Reznorzo

if ( cat $HOME/home-infra/ansible/vars/vault.yml | grep -q "\$ANSIBLE_VAULT;" ); then
echo "${green}Vault Encrypted. Safe to commit.${reset}"
else
echo "${red}Vault not encrypted! Run 'just vault encrypt' and try again.${reset}"
exit 1
fi
read -p "Commit description: " desc
git add -A && \
git commit -m "$desc" && \
git push -u origin main