```bash
#!/usr/bin/env bash

function setupSystemDeps() {
  runner="apt"

  echo ">> Use $runner to install dependency"
  echo ">> Install pre-dependencies"

  echo ">> $runner install git tmux tree cmake gcc zsh"
  # see https://mirrors.tuna.tsinghua.edu.cn/help/kali/
  sudo sed -i 's/^deb/# deb/g' /etc/apt/sources.list
  sudo sed -i '$a\deb https://mirrors.tuna.tsinghua.edu.cn/kali kali-rolling main non-free contrib non-free-firmware' /etc/apt/sources.list
  sudo $runner update
  sudo $runner install git tmux tree cmake gcc zsh
}

function setupGitAccount() {
  echo ">> Avoid the github cannot be accessed, set a git proxy for accessing github"
  read -p ">> Please typing: " localURI
  if [[ -z "$localURI" ]]; then
    echo ">> Ignore the git proxy setting"
  else
    echo ">> Proxy setting: git config --global http.https://github.com http://$localURI"
    git config --global http.https://github.com.proxy http://$localURI
  fi
  echo ">> Done"

  echo ">> Git global setting"
  git config --global alias.st status
  git config --global alias.cmt commit
  git config --global alias.ck checkout
  git config --global credential.helper store

  echo ">> Typing your name used with git globally"
  read -p ">> Username: " username
  if [[ -z "$username" ]]; then
    echo ">> Ignore git username setting"
  else
    git config --global user.name "$username"
  fi
  read -p ">> User email: " email
  if [[ -z "$email" ]]; then
    echo ">> Ignore git user email setting"
  else
    git config --global user.email "$email"
  fi
  echo ">> Done"
}

function setupTmux() {
  echo ">> Install ohmytmux"
  git clone https://github.com/gpakosz/.tmux.git ~/.tmux
  ln -s -f .tmux/.tmux.conf ~/.tmux.conf
  echo
  echo ">> The script sudo systemd-tmpfiles --create will be helpful when error creating /run/tmux/1000 No such file or directory was catched under WSL"
  echo ">> Or just change add export TMUX_TMPDIR='/tmp' into .zshrc to change the default tmux tmp directory"
  echo ">> Done"
}

function setupZsh() {
  echo ">> Install ohmyzsh and plugins"
  git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
  cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
  chsh -s /bin/zsh

  git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH/plugins/zsh-autocomplete
  sed -i 's/plugins=(/plugins=(zsh-autocomplete /' ~/.zshrc
  sed -i 's/ZSH_THEME=".\+"/ZSH_THEME="bira"/' ~/.zshrc

  sed -i '$a\set -o vi' ~/.zshrc
  echo ">> Done"
}

function setupGitExtras() {
  echo ">> Install git-extras"
  mkdir -p ~/Project
  git clone https://github.com/tj/git-extras.git ~/Project/git-extras
  sed -i '$a\source ~/Project/git-extras/etc/git-extras-completion.zsh' ~/.zshrc
  echo ">> Done"
}

function setupNode() {
  echo ">> Install node version manager and node@20.10.0"
  curl https://get.volta.sh | bash
  volta install node@20.10.0
  echo ">> Done"
}

function setupVim() {
  echo ">> Initialize vimrc"
  curl -o ~/.vim/autoload/plug.vim --create-dirs https://gist.githubusercontent.com/vanpipy/5466dc623d6c9ec124f997ab7e6f2c70/raw/26229fb23962d66043af94e9c09a64ec1d934cd5/plug.vim
  curl -o ~/.vimrc https://gist.githubusercontent.com/vanpipy/0597d3ee27a55ecf8f1ad20cc044024e/raw/f1ef76e6788929f5fe80294b55306bdada48dfe2/vimrc
  echo ">> You would better to install the plugins by yourself"
  echo ">> 1. :PlugInstall"
  echo ">> 2. :CocInstall coc-tsserver coc-rome coc-eslint coc-prettier coc-json coc-git coc-cmake coc-snippets coc-jedi"
  echo ">> 3. Optional: zypper install vim-data when your openSUSE is a windows-subsystem"
  echo ">> Done"

  echo ">> Install neovim"
  mkdir -p ~/Download
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz -o ~/Download/nvim-linux.tar.gz
  cd ~/Download
  sudo rm -rf /opt/nvim
  sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
  cd -
  sudo rm /usr/bin/vi
  sudo ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim
  sudo ln -s /opt/nvim/bin/nvim /usr/bin/vi
  git clone https://github.com/vanpipy/lazible-neo.git ~/.config/nvim
  echo ">> Done"

  echo ">> Update default editor as /usr/bin/vim.basic"
  sudo update-alternatives --set editor /usr/bin/vim.basic
  echo ">> Once failed try \"sudo update-alternatives --config editor\""
}

function install() {
  setupSystemDeps
  setupGitAccount
  setupTmux
  setUpZsh
  setupGitExtras
  setupNode
  setupVim

  exit 0
}

install
```