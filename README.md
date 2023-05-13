# 🖥 reznorzo/home-infra

IaC - Infrastructure For Homelab

Ansible for spinning up and provisioning VMs and LXCs

Docker for the services on the various LXCs

![](https://img.shields.io/github/actions/workflow/status/Reznorzo/home-infra/ci.yml)
![Ansible](https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white) ![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)	![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)

## 🤖 Naming Conventions

["Evil Computers"](https://www.rollingstone.com/feature/rage-against-the-machine-a-brief-history-of-evil-movie-computers-245099/)

* **Skynet** - Primary Proxmox Node
* **Shodan** - Home Automation
* **Proteus** - Misc. Media
* **HAL** - Ansible primary host
* **GLaDOS** - Media distribution/collection
* **Borg** - DMZ/Primary Pi-Hole/Wireguard
* **TBD** - Databases
* **TBD** - Backup Pi-Hole
  
## ✅ First Deploy instructions:

`just install` - Installs a github hook to prevent uploading an unencrypted Ansible vault file, adds the Ansible Galaxy roles, and sets up the Ansible vault password

`just proxmox` - Creates all LXCs, sets up disks on Proxmox host
`just proxomx -t infra` - Just creates LXCs

Start LXCs

`just boostrap_lxc` - Sets up the hosts with a main user and an ansible user that can run sudo without a password

`just run {{host name}} {{TAGS}}` - Sets up the various machines (host_name is a variable for the hostname), {{TAGS}} for specific parts of playbook e.g. docker compose generation

### 🔒 Ansible Vault

Ansible [integrates](https://theorangeone.net/posts/ansible-vault-bitwarden/) with Bitwarden through its [CLI](https://bitwarden.com/help/article/cli/).

`just vault encrypt` - Encrypts the Ansible vault
`just vault decrypt` - Decrypts the Ansible vault

### ⚙ Git

`just git` - Runs the gitupdate script

### 🔁 Updates

`just update` - Runs apt update and apt upgrade on the servers, and pushes an updated docker-compose.yml file
`just docker` - Runs docker-compose pull {{ containers }} and docker-compose up -d {{ container }} on host and containers specified