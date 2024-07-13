#!/bin/bash

## Prerequisites
sudo apt-get update 
sudo apt-get autoremove -y
sudo apt-get upgrade --with-new-pkgs -y
sudo apt install -y tmux
echo ":colorscheme desert" | sudo tee -a /etc/vim/vimrc.local
cat <<EOF>> ~/.bashrc
# Immediatly save bash history
export PROMPT_COMMAND="history -a; history -c; history -r; \$PROMPT_COMMAND"

# Start tmux and append session if exists
if command -v tmux &> /dev/null && [ -n "\$PS1" ] && [[ ! "\$TERM" =~ screen ]] && [[ ! "\$TERM" =~ tmux ]] && [ -z "\$TMUX" ] && [ ! -f ~/.no_tmux ]; then
  exec tmux new-session -A -s main
fi
EOF

cat <<EOF>> ~/.tmux.conf
set -g mouse on
setw -g alternate-screen on
set-option -g history-limit 10000
EOF

sudo apt install -y git wget curl gpg 

git config --global init.defaultBranch main
git config --global core.editor "vim"
git config --global credential.helper 'cache --timeout=3600' # 1 hour

read -t 5 -p "About to reboot. Press CTRL-C to stop, or ENTER to continue immediately." reply 
reply=${reply:-Y}
if [[ ${reply^} = Y ]]; then
  sudo reboot
fi


