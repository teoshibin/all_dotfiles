
## Theme ##

oh-my-posh init pwsh --config ~/neeon.omp.json | Invoke-Expression
$Env:VIRTUAL_ENV_DISABLE_PROMPT = 1 # disable python env prompt

## PS Modules ##

if (-not (Get-Module -ListAvailable -Name Terminal-Icons)) {
    Install-Module -Name Terminal-Icons -Force -AllowClobber -SkipPublisherCheck
} 
if (-not (Get-Module -ListAvailable -Name z)) {
    Install-Module -Name z -Force -AllowClobber -SkipPublisherCheck
} 
if (-not (Get-Module -ListAvailable -Name CompletionPredictor)) {
    Install-Module -Name CompletionPredictor -Force -AllowClobber -SkipPublisherCheck
} 
if (-not (Get-Module -ListAvailable -Name PSReadLine)) {
    Install-Module -Name PSReadLine -Force -AllowClobber -SkipPublisherCheck
} 
Import-Module -Name Terminal-Icons      # icon
Import-Module -Name z                   # z jump
Import-Module -Name CompletionPredictor # intelisense plugin
Import-Module -Name PSReadLine          # display history

### PSReadLine ###

# See more example
# https://github.com/PowerShell/PSReadLine/blob/master/PSReadLine/SamplePSReadLineProfile.ps1
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Key ctrl+p -Function PreviousHistory 
Set-PSReadLineKeyHandler -Key ctrl+n -Function NextHistory 

## Neovim ##

function Get-Nvim-Config {
    param(
        [string]$ConfigName,
        [string]$NvimCommand = "nvim",
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$RemainingArgs
    )
    $env:NVIM_APPNAME = $ConfigName
    & $NvimCommand @RemainingArgs
    Remove-Item Env:\NVIM_APPNAME
}

function Get-Nvim-Chad { 
    Get-Nvim-Config -ConfigName "nvch" -NvimCommand "nvim" @args 
}

function Get-Nvim-Chad-Nightly { 
    Get-Nvim-Config -ConfigName "nvch-nightly" -NvimCommand "nvin" @args 
}

New-Alias -Name nv -Value Get-Nvim-Chad -Force -Option AllScope
New-Alias -Name nvn -Value Get-Nvim-Chad-Nightly -Force -Option AllScope

## Custom applications ##

Set-Alias -Name mg -Value mangal
$profileDirectory = Split-Path -Path $PROFILE
$scriptName = "mangal.ps1"
$scriptPath = Join-Path -Path $profileDirectory -ChildPath "Scripts\$scriptName"
if (Test-Path -Path $scriptPath) {
    . $scriptPath
} else {
    Write-Host "Script $scriptName not found in $profileDirectory\Scripts."
}

## Git Aliases ##

# git (status, log, diff)
function Get-GitStatus { & git status -sb $args } 
function Get-GitLog { & git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit } 
function Get-GitDiff { & git diff -- $args } 
function Get-GitStagedDiff { & git diff --staged $args }
New-Alias -Name gs -Value Get-GitStatus -Force -Option AllScope 
New-Alias -Name gl -Value Get-GitLog -Force -Option AllScope
New-Alias -Name gd -Value Get-GitDiff -Force -Option AllScope 
New-Alias -Name gds -Value Get-GitStagedDiff -Force -Option AllScope 

# git (add or stage, commit)
function Get-GitAdd { & git add -- $args } 
function Get-GitCommit { & git commit -m $args } 
function Get-GitAddAll { & git add --all $args } 
function Get-GitCommitAmend { & git commit --amend $args } 
New-Alias -Name ga -Value Get-GitAdd -Force -Option AllScope 
New-Alias -Name gaa -Value Get-GitAddAll -Force -Option AllScope 
New-Alias -Name gc -Value Get-GitCommit -Force -Option AllScope 
New-Alias -Name gca -Value Get-GitCommitAmend -Force -Option AllScope 

# git (fetch, pull, push, merge)
function Get-GitFetch { & git fetch $args } 
function Get-GitPull { & git pull $args } 
function Get-GitPullOrigin { & git pull origin $args } 
function Get-GitPush { & git push $args } 
function Get-GitPushOrigin { & git push origin $args } 
function Get-GitMerge { & git merge $args } 
New-Alias -Name gf -Value Get-GitFetch -Force -Option AllScope 
New-Alias -Name gpl -Value Get-GitPull -Force -Option AllScope 
New-Alias -Name gplo -Value Get-GitPullOrigin -Force -Option AllScope 
New-Alias -Name gps -Value Get-GitPush -Force -Option AllScope 
New-Alias -Name gpso -Value Get-GitPushOrigin -Force -Option AllScope 
New-Alias -Name gm -Value Get-GitMerge -Force -Option AllScope 

# git checkout and branch
function Get-GitCheckout { & git checkout $args } 
function Get-GitCheckoutBranch { & git checkout -b $args } 
function Get-GitBranch { & git branch $args } 
New-Alias -Name gb -Value Get-GitBranch -Force -Option AllScope 
New-Alias -Name gch -Value Get-GitCheckout -Force -Option AllScope 
New-Alias -Name gchb -Value Get-GitCheckoutBranch -Force -Option AllScope 

# git remote (add, view, open url)
function Get-GitRemoteView { & git remote -v $args } 
function Get-GitRemoteAdd { & git remote add $args } 
function Get-GitRemoteOpen {
    $RemoteURL = git config --get remote.origin.url
    if (-not $RemoteURL) {
        Write-Error "No remote URL found."
        return
    }
    switch -Regex ($RemoteURL) {
        "github.com[:/](.+)/(.+?)(\.git)?$" { 
            $RemoteURL = "https://github.com/$($Matches[1])/$($Matches[2])"
        }
        "bitbucket.org[:/](.+)/(.+?)(\.git)?$" {
            $RemoteURL = "https://bitbucket.org/$($Matches[1])/$($Matches[2])"
        }
        "gitlab.com[:/](.+)/(.+?)(\.git)?$" {
            $RemoteURL = "https://gitlab.com/$($Matches[1])/$($Matches[2])"
        }
        default {
            Write-Error "Unknown Remote Service, please add it to the profile script."
            return
        }
    }
    Write-Output "Opening $RemoteURL"
    Start-Process $RemoteURL
}
New-Alias -Name gra -Value Get-GitRemoteAdd -Force -Option AllScope
New-Alias -Name grv -Value Get-GitRemoteView -Force -Option AllScope
New-Alias -Name gro -Value Get-GitRemoteOpen -Force -Option AllScope

# git worktree (list, add, delete)
function Get-GitWorkTree { & git worktree $args }
function Get-GitWorkTreeList { & git worktree list $args }
function Get-GitWorkTreeAdd { & git worktree add $args }
function Get-GitWorkTreeDelete { & git worktree remove $args }
New-Alias -Name gwt -Value Get-GitWorkTree -Force -Option AllScope
New-Alias -Name gwtl -Value Get-GitWorkTreeList -Force -Option AllScope
New-Alias -Name gwta -Value Get-GitWorkTreeAdd -Force -Option AllScope
New-Alias -Name gwtd -Value Get-GitWorkTreeDelete -Force -Option AllScope

# git stash (list, show, drop, clear, pop)
function Get-GitStash { & git stash $args }
function Get-GitStashList { & git stash list $args }
function Get-GitStashShow { & git stash show -p $args }
function Get-GitStashDrop { & git stash drop $args }
function Get-GitStashClear { & git stash clear $args }
function Get-GitStashPop { & git stash pop $args }
New-Alias -Name gst -Value Get-GitStash -Force -Option AllScope
New-Alias -Name gstl -Value Get-GitStashList -Force -Option AllScope
New-Alias -Name gsts -Value Get-GitStashShow -Force -Option AllScope
New-Alias -Name gstd -Value Get-GitStashDrop -Force -Option AllScope
New-Alias -Name gstc -Value Get-GitStashClear -Force -Option AllScope
New-Alias -Name gstp -Value Get-GitStashPop -Force -Option AllScope

# function Get-GitCherryPick { & git cherry-pick $args } 
# function Get-GitCommitEdit { & git commit -ev $args } 
# function Get-GitPullRebase { & git pull --rebase $args } 
# function Get-GitTree { & git log --graph --oneline --decorate $args } 
# New-Alias -Name gcp -Value Get-GitCherryPick -Force -Option AllScope
# New-Alias -Name gce -Value Get-GitCommitEdit -Force -Option AllScope 
# New-Alias -Name gpr -Value Get-GitPullRebase -Force -Option AllScope 
# New-Alias -Name gt -Value Get-GitTree -Force -Option AllScope 

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
