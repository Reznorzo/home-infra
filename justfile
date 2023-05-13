#!/usr/bin/env -S just --justfile
# ^ A shebang isn't required, but allows a justfile to be executed
#   like a script, with `./justfile test`, for example.

ansible_dir := "ansible"
scripts_dir := "scripts"

bt := '0'

export RUST_BACKTRACE := bt

log := "warn"

export JUST_LOG := log

# Setup
install:
  export BW_SESSION=$(bw unlock --raw)
  export GITHUB_TOKEN=$(bw get password "ghToken")
  export GITHUB_USER=Reznorzo
  cd {{ ansible_dir }}; ansible-galaxy role install -r requirements.yml
  cd {{ ansible_dir }};  ansible-galaxy collection install -r requirements.yml
  cd {{ ansible_dir }};  ansible-galaxy collection install community.general
  @echo "Ansible Galaxy collections installed"
  cd {{ scripts_dir }}; ./git-init.sh
  @echo "Ansible vault git pre-commit hook installed"

proxmox *TAGS:
	cd {{ ansible_dir }}; ansible-playbook -u root -b playbooks/run.yml --ask-pass --limit skynet {{TAGS}}

bootstrap_lxc:
	cd {{ ansible_dir }}; ansible-playbook -b playbooks/bootstrap.yml --limit lxc

# Run/Builds
run HOST *TAGS:
	cd {{ ansible_dir }}; ansible-playbook -b playbooks/run.yml --limit {{HOST}} {{TAGS}}

# Git commits and pushes
git:
	cd {{scripts_dir }}; ./github.sh

# Just vault (encrypt/decrypt/edit)
vault ACTION VAULT="vars/vault.yml":
  cd {{ansible_dir}}; ansible-vault {{ACTION}} {{VAULT}}

# Updates
update:
  cd {{ ansible_dir }}; ansible-playbook playbooks/update.yml

docker:
  cd {{ ansible_dir }}; ansible-playbook playbooks/docker.yml