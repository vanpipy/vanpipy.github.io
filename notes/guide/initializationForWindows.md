# Initialization for Windows

1. Install [Chocolatey](https://chocolatey.org/install)
    * Install python via `choco install python@3.12.7`
    * Install volta `choco install volta`
    * Install node `volta install node`
    * Install Oh My Posh `choco install oh-my-posh`
        - [custom-prompt-setup](https://learn.microsoft.com/zh-cn/windows/terminal/tutorials/custom-prompt-setup)
    * Install PowerToys `winget install Microsoft.PowerToys`
    * Enable PSReadLine `Install-Module -Name PSReadLine -Scope CurrentUser`
2. Enable [WSL](https://learn.microsoft.com/en-us/windows/wsl/install-manual) and install [WSL](https://docs.microsoft.com/en-us/windows/wsl/install)
3. Initialize [Kali](https://apps.microsoft.com/detail/9pkr34tncv07?hl=en-US&gl=US) and [environment](https://github.com/vanpipy/shellgun/blob/main/bin/createenv)