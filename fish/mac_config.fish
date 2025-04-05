if status is-interactive
    # remove welcome prompt
    set -U fish_greeting ""

    # homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"
    fish_add_path /opt/homebrew/bin

    # neovim
    function nvim_config -a config_name
        set -x NVIM_APPNAME $config_name
        set -e argv[1]
        nvim $argv
    end
    alias nv='nvim_config "nvch"'

    # intellij
    set -gx PATH /Applications/IntelliJ\ IDEA\ CE.app/Contents/MacOS $PATH
    # nvm
    set -gx NVM_DIR (brew --prefix nvm)

    # git
    alias gs='git status -sb'
    alias gc='git commit -m'
    alias gaa='git add --all'
    alias ga='git add'
    alias gps='git push'
    alias gpso='git push origin'
    alias gpl='git pull'
    alias gplo='git pull origin'
    alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
    alias gf='git fetch'
    alias gch='git checkout'
    alias gsw='git switch'
    alias gchb='git checkout -b'
    alias gb='git branch'
    alias grv='git remote -v'
    alias gra='git remote add'
    alias gm='git merge'
    alias gwt='git worktree'
    alias gwtl='git worktree list'
    alias gwta='git worktree add'
    alias gwtrm='git worktree remove'
    alias gd='git diff'
    alias gds='git diff --staged'
    alias gst='git stash'
    alias gstp='git stash pop'
    alias gstl='git stash list'
    alias gsts='git stash show -p'
    alias gstd='git stash drop'
    alias gstc='git stash clear'

    function gch
        # Check if any arguments were provided
        if set -q argv[1]
            # If arguments are provided, pass them directly to git checkout
            git checkout $argv
        else
            # No arguments provided, use fzf to select a branch
            set branch (git branch -a | fzf --height 40% --layout=reverse --border --prompt='Select branch: ' | string trim)

            if test -n "$branch"
                # Process the selected branch
                # Strip out the asterisk and remote prefixes from the branch name
                set clean_branch (string replace -r '^\* ' '' $branch)
                set clean_branch (string replace -r '^remotes/[^/]+/' '' $clean_branch)
                
                # Confirm the branch to switch to
                echo "Switching to branch: $clean_branch"
                
                # Checkout the selected branch
                git checkout $clean_branch
            else
                echo "No branch selected."
            end
        end
    end
end
