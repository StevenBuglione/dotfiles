# Microsoft.PowerShell_profile.ps1
# This profile is loaded every time you start a PowerShell session.
# It sets up aliases and functions to bring a Linux-like feel to PowerShell.

function hmu {
    chezmoi re-add C:\Users\steve\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json	
    chezmoi diff
    chezmoi apply
    winget import C:\Users\steve\.config\winget\package.json
    sudo choco install C:\Users\steve\.config\choco\package.config
    refreshenv
    . $PROFILE
}

function diff-config {
    chezmoi diff
}

function apply-config {
    chezmoi re-add C:\Users\steve\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json	
    chezmoi apply
}

function lazyg-config {
    chezmoi re-add C:\Users\steve\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
    chezmoi diff
    chezmoi apply
    chezmoi git -- add . 
    chezmoi git -- commit -m "Updating Config" 
    chezmoi git -- push 
}

function edit-starship {
    chezmoi edit C:\Users\steve\.config\starship.toml
}

function apply-starship {
    chezmoi re-add C:\Users\steve\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json	
    chezmoi apply
}

function source {
    refreshenv	
    . $PROFILE
}

function edit-profile {
    chezmoi edit C:\Users\steve\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
}

function apply-profile {
     chezmoi re-add C:\Users\steve\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json	
     chezmoi apply
     refreshenv
    . $PROFILE
}

# === Basic Aliases (many of these are built-in, but are here for clarity) ===
function edit-winget {
    chezmoi edit C:\Users\steve\.config\winget\package.json
}

function apply-winget {
    chezmoi re-add C:\Users\steve\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json	
    chezmoi apply 
    winget import C:\Users\steve\.config\winget\package.json
    refreshenv
}


function edit-choco {
    chezmoi edit C:\Users\steve\.config\choco\package.config
}

function apply-choco {
    chezmoi re-add C:\Users\steve\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
    chezmoi apply
    sudo choco install C:\Users\steve\.config\choco\package.config
    refreshenv
}

# A more detailed directory listing, similar to "ll"
function ll {
    param(
        [string]$Path = "."
    )
    Get-ChildItem -Force $Path | Format-List
}

# Display the first few lines of a file (head)
function head {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [int]$Count = 10
    )
    Get-Content $Path -TotalCount $Count
}

# Display the last few lines of a file (tail)
function tail {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [int]$Count = 10
    )
    Get-Content $Path -Tail $Count
}

# Recursively search for files matching a pattern (find)
function find {
    param(
        [string]$Path = ".",
        [string]$Pattern = "*"
    )
    Get-ChildItem -Path $Path -Recurse -Filter $Pattern
}

# === Optional: Load Additional Modules for a GNU-like Experience ===

# If you have modules like posh-git or oh-my-posh, you can import them here.
# Uncomment the lines below if you have these modules installed.
# Import-Module posh-git
# Import-Module oh-my-posh

# === Customize Your Prompt ===

# A simple prompt that shows the current directory.
# (If using posh-git, your prompt might be enhanced automatically.)
function prompt {
    "PS " + (Get-Location) + "> "
}

# === Welcome Message (Optional) ===
fastfetch
Invoke-Expression (& starship init powershell)

