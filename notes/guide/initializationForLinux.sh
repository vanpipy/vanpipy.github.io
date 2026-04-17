#!/bin/bash
#
# =============================================================================
# initializationForLinux.sh - Linux Development Environment Setup Script
# =============================================================================
#
# Description:
#   Automated setup script for Linux development environment including git, tmux,
#   zsh, neovim, volta (Node.js), and pyenv (Python). Supports both Ubuntu and
#   Kali Linux distributions.
#
# Usage:
#   ./initializationForLinux.sh [OPTIONS]
#
# Options:
#   --dry-run          Show commands without executing
#   --help             Show this help message
#   --git-user NAME    Set git user name
#   --git-email EMAIL  Set git user email
#   --git-proxy PROXY  Set git proxy (e.g., localhost:7890)
#
# Requirements:
#   - Ubuntu or Kali Linux
#   - Root/sudo access for system package installation
#   - Internet connection for cloning repositories
#
# =============================================================================
#

set -euo pipefail

##------------------------------------------------------------------------------
## Global Variables
##------------------------------------------------------------------------------

# Global variables for CLI options
GIT_USER=""
GIT_EMAIL=""
GIT_PROXY=""
IS_DRY_RUN=false

##------------------------------------------------------------------------------
## CLI Functions
##------------------------------------------------------------------------------

# Display usage information
usage() {
  cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Options:
  --dry-run          Show commands without executing
  --help             Show this help message
  --git-user NAME    Set git user name
  --git-email EMAIL  Set git user email
  --git-proxy PROXY  Set git proxy (e.g., localhost:7890)

EOF
}

# Parse CLI arguments
parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --dry-run)
        IS_DRY_RUN=true
        shift
        ;;
      --help)
        usage
        exit 0
        ;;
      --git-user)
        GIT_USER="$2"
        shift 2
        ;;
      --git-email)
        GIT_EMAIL="$2"
        shift 2
        ;;
      --git-proxy)
        GIT_PROXY="$2"
        shift 2
        ;;
      *)
        echo "Unknown option: $1"
        usage
        exit 1
        ;;
    esac
  done
}

##------------------------------------------------------------------------------
## Helper Functions
##------------------------------------------------------------------------------

# Run command in dry-run mode or execute normally
run() {
  if [[ "${IS_DRY_RUN:-false}" == "true" ]]; then
    echo "[DRY-RUN] $*"
    return 0
  fi
  "$@"
}

# Check if running in WSL environment
is_wsl() {
  grep -qiE 'microsoft|wsl' /proc/version 2>/dev/null
}

# Create backup of a file before modification
backup_file() {
  local file="$1"
  local backup="${file}.backup-$(date +%Y%m%d%H%M%S%N)"
  [[ -f "$file" ]] && cp "$file" "$backup"
}

# Backup /etc/apt/sources.list
backup_sources_list() {
  local backup="/etc/apt/sources.list.backup-$(date +%Y%m%d%H%M%S%N)"
  sudo cp /etc/apt/sources.list "$backup"
}

##------------------------------------------------------------------------------
## Setup Functions
##------------------------------------------------------------------------------

# Setup system dependencies (package manager and base packages)
setup_system_deps() {
  # Detect distribution
  if grep -qi kali /etc/os-release 2>/dev/null; then
    DISTRO="kali"
  else
    DISTRO="ubuntu"
  fi
  echo "==> Detected distribution: $DISTRO"

  runner="apt"

  echo "==> Use $runner to install dependency"
  echo "==> Install pre-dependencies"

  echo "==> $runner install git tmux tree cmake gcc zsh python3-pip"

  # Configure Kali Linux mirror if needed
  # see https://mirrors.tuna.tsinghua.edu.cn/help/kali/
  if [[ "$DISTRO" == "kali" ]]; then
    backup_sources_list
    sudo sed -i 's/^deb/# deb/g' /etc/apt/sources.list || { echo "Failed to modify sources.list"; exit 1; }
    sudo sed -i '$a\deb https://mirrors.tuna.tsinghua.edu.cn/kali kali-rolling main non-free contrib non-free-firmware' /etc/apt/sources.list || { echo "Failed to add sources.list entry"; exit 1; }
  fi

  sudo $runner update || { echo "Failed to update apt"; exit 1; }
  sudo $runner install git tmux tree cmake gcc zsh python3-pip || { echo "Failed to install dependencies"; exit 1; }
}

# Setup git configuration and proxy
setup_git_account() {
  echo "==> Avoid the github cannot be accessed, set a git proxy for accessing github"
  if [[ -n "$GIT_PROXY" ]]; then
    echo "==> Proxy setting: git config --global http.https://github.com http://$GIT_PROXY"
    git config --global http.https://github.com.proxy http://$GIT_PROXY
  else
    echo "==> Ignore the git proxy setting"
  fi
  echo "==> Done"

  echo "==> Git global setting"
  git config --global alias.st status
  git config --global alias.cmt commit
  git config --global alias.ck checkout
  git config --global credential.helper store

  if [[ -n "$GIT_USER" ]]; then
    git config --global user.name "$GIT_USER"
  else
    echo "==> Ignore git username setting"
  fi
  if [[ -n "$GIT_EMAIL" ]]; then
    git config --global user.email "$GIT_EMAIL"
  else
    echo "==> Ignore git user email setting"
  fi
  echo "==> Done"
}

# Setup tmux with ohmytmux configuration
setup_tmux() {
  echo "==> Install ohmytmux"
  git clone --depth 1 https://github.com/gpakosz/.tmux.git ~/.tmux
  ln -s -f .tmux/.tmux.conf ~/.tmux.conf
  echo

  if is_wsl; then
    echo "==> The script sudo systemd-tmpfiles --create will be helpful when error creating /run/tmux/1000 No such file or directory was catched under WSL"
    echo "==> Or just change add export TMUX_TMPDIR='/tmp' into .zshrc to change the default tmux tmp directory"
  fi
  echo "==> Done"
}

# Setup zsh with ohmyzsh and plugins
setup_zsh() {
  echo "==> Install ohmyzsh and plugins"
  git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
  cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
  chsh -s /bin/zsh

  sed -i 's/ZSH_THEME=".\+"/ZSH_THEME="bira"/' ~/.zshrc

  sed -i '$a\set -o vi' ~/.zshrc
  echo "==> Done"
}

# Setup git-extras for additional git commands
setup_git_extras() {
  echo "==> Install git-extras"
  mkdir -p ~/Project
  [[ -d ~/Project/git-extras ]] || git clone --depth 1 https://github.com/tj/git-extras.git ~/Project/git-extras || { echo "Failed to clone git-extras"; exit 1; }
  sed -i '$a\source ~/Project/git-extras/etc/git-extras-completion.zsh' ~/.zshrc
  echo "==> Done"
}

# Setup volta (Node.js version manager) and package managers
setup_volta() {
  echo "==> Install node version manager (Volta) and package managers"
  curl https://get.volta.sh | bash
  export VOLTA_HOME="$HOME/.volta"
  [[ ":$PATH:" == *":$VOLTA_HOME/bin:"* ]] || export PATH="$VOLTA_HOME/bin:$PATH"

  volta install node || { echo "Failed to install node"; exit 1; }
  volta install pnpm || { echo "Failed to install pnpm"; exit 1; }
  volta install bun || { echo "Failed to install bun"; exit 1; }
  echo "==> Done"
}

# Setup vim and neovim configuration
setup_vim() {
  echo "==> Initialize vimrc"
  curl --max-time 60 -o ~/.vim/autoload/plug.vim --create-dirs https://gist.githubusercontent.com/vanpipy/5466dc623d6c9ec124f997ab7e6f2c70/raw/26229fb23962d66043af94e9c09a64ec1d934cd5/plug.vim
  curl --max-time 60 -o ~/.vimrc https://gist.githubusercontent.com/vanpipy/0597d3ee27a55ecf8f1ad20cc044024e/raw/f1ef76e6788929f5fe80294b55306bdada48dfe2/vimrc
  echo "==> You would better to install the plugins by yourself"
  echo "==> 1. :PlugInstall"
  echo "==> 2. :CocInstall coc-tsserver coc-rome coc-eslint coc-prettier coc-json coc-git coc-cmake coc-snippets coc-jedi"
  echo "==> 3. Optional: zypper install vim-data when your openSUSE is a windows-subsystem"
  echo "==> Done"

  echo "==> Install neovim"
  # Architecture check for neovim
  if [[ $(uname -m) != "x86_64" ]]; then
    echo "Unsupported architecture: $(uname -m). Neovim x86_64 binary required."
    echo "Please download manually from https://github.com/neovim/neovim/releases"
    exit 1
  fi

  mkdir -p ~/Download
  cd ~/Download
  wget --max-time 60 https://github.com/neovim/neovim/releases/download/v0.11.6/nvim-linux-x86_64.tar.gz
  sudo rm -rf /opt/nvim
  tar -xzf nvim-linux-x86_64.tar.gz
  sudo mv nvim-linux-x86_64 /opt/nvim
  cd -
  sudo rm /usr/bin/vi
  sudo ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim
  sudo ln -s /opt/nvim/bin/nvim /usr/bin/vi
  git clone --depth 1 https://github.com/vanpipy/lazible-neo.git ~/.config/nvim
  echo "==> Done"

  echo "==> Update default editor as /usr/bin/vim.basic"
  sudo update-alternatives --set editor /usr/bin/vim.basic
  echo "==> Once failed try \"sudo update-alternatives --config editor\""
}

# Setup pyenv (Python version manager) and Python tools
setup_pyenv() {
  # Install pyenv for Python version management
  # see https://github.com/pyenv/pyenv
  curl --max-time 60 -fsSL https://pyenv.run | bash || { echo "Failed to install pyenv"; exit 1; }
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
  echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
  echo 'eval "$(pyenv init - zsh)"' >> ~/.zshrc

  # Install pipx and uv (requires python3-pip from Task 3)
  python3 -m pip install --upgrade pip || { echo "Failed to upgrade pip"; exit 1; }
  python3 -m pip install --user pipx || { echo "Failed to install pipx"; exit 1; }
  pipx install uv || { echo "Failed to install uv via pipx"; exit 1; }
}

##------------------------------------------------------------------------------
## Main Entry Point
##------------------------------------------------------------------------------

# Run all setup functions
install() {
  setup_system_deps
  setup_git_account
  setup_tmux
  setup_zsh
  setup_git_extras
  setup_volta
  setup_vim
  setup_pyenv

  exit 0
}

# Parse CLI arguments first
parse_args "$@"

# Run installation
install