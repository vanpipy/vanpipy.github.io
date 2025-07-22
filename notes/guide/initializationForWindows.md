# Initialization for Windows

1. Install [Chocolatey](https://chocolatey.org/install)
    * Install python via `choco install python`
        * `pip config set global.index-url https://mirrors.sustech.edu.cn/pypi/web/simple`
    * Install volta `choco install volta`
        * `volta install node`
    * Install Oh My Posh `choco install oh-my-posh`
        - [custom-prompt-setup](https://learn.microsoft.com/zh-cn/windows/terminal/tutorials/custom-prompt-setup)
    * Install PowerToys `winget install Microsoft.PowerToys`
    * Install [PSReadLine](https://github.com/PowerShell/PSReadLine)
2. Enable [WSL](https://learn.microsoft.com/en-us/windows/wsl/install-manual) and install [WSL](https://docs.microsoft.com/en-us/windows/wsl/install)
    * `wsl --install`
3. Install `wsl --install kali` and create the [environment](https://github.com/vanpipy/shellgun/blob/main/bin/createenv)