#!/bin/bash

# Update apt
sudo apt update

# Upgrade all packages
sudo apt upgrade -y

# Install docker
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
| y | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Install zsh & oh-my-zsh
sudo apt install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s $(which zsh)

# Install powerlevel10k
powerlevel10k_dir=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
if [[ -d "$powerlevel10k_dir" && -n "$(ls -A "$powerlevel10k_dir")" ]]; then
  echo "Updating Powerlevel10k..."
  (cd "$powerlevel10k_dir" && git pull && cd ~)
else
  echo "Cloning Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$powerlevel10k_dir"
fi
cp ~/.zshrc ~/.zshrc.bak
new_theme="powerlevel10k/powerlevel10k"
sed -i "s|ZSH_THEME=.*|ZSH_THEME=\"$new_theme\"|" ~/.zshrc
source ~/.zshrc

echo "Environment initated successfully! Run 'p10k configure' to configure powerlevel10k."