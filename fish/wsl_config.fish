
if status is-interactive
    # remove message
    set -U fish_greeting ""

    # change ls highlight color
    set -x LS_COLORS "ow=01;36;40"

    alias gs='git status -sb'
    alias gc='git commit -m $2'
    alias gaa='git add --all'
    alias ga='git add $2'
    alias gps='git push $2'
    alias gpso='git push origin'
    alias gpl='git pull'
    alias gplo='git pull origin'
    alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
    alias gf='git fetch $2'
    alias gch='git checkout $2'
    alias gchb='git checkout -b $2'
    alias gb='git branch $2'
    alias grv='git remote -v $2'
    alias gra='git remote add $2'
    alias gm='git merge $2'
    alias gwt='git worktree $2'
    alias gwtl='git worktree list'
    alias gwta='git worktree add $2'
    alias gwtrm='git worktree remove $2'
    alias gd='git diff $2'
    alias gds='git diff --staged $2'
    alias gst='git stash $2'
    alias gstp='git stash $2'
    alias gstl='git stash list $2'
    alias gsts='git stash show -p $2'
    alias gstd='git stash drop $2'
    alias gstc='git stash clear'

    # python venv
    set -x VIRTUAL_ENV_DISABLE_PROMPT 1
    alias py=python3

    # z jump
    zoxide init fish | source

    # starship prompt
    starship init fish | source
    set -gx STARSHIP_LOG error

    # nvm
    nvm use latest > /dev/null

    # neovim
    function nvim_config -a config_name
        set -x NVIM_APPNAME $config_name
        set -e argv[1]
        if contains -- --nightly $argv
            set -l new_argv
            for arg in $argv
                if test "$arg" != "--nightly"
                    set new_argv $new_argv $arg
                end
            end
            nvin $new_argv
        else
            nvim $argv
        end
    end
    alias nv='nvim_config "nvch"'
    alias nvn='nvim_config "nvch" --nightly'

    # fzf git chekcout
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
