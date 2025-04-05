
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# eval "$('/c/Users/user/anaconda3/Scripts/conda.exe' 'shell.bash' 'hook')"
# <<< conda initialize <<<

# eval "$(oh-my-posh init bash --config ~/emodipt-extend.omp.json)"
# PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND "}'printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"'
# clear

#My aliases
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


# alias ls='ls -F --color=auto --show-control-chars'
# alias ll='ls -l'
# alias rm='rm -iv'
