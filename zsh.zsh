# Load colors
autoload -U colors && colors
autoload -U compinstall && compinstall

# Key bindings
# To see the key combo you want to use just do:
# cat > /dev/null
# And press it

bindkey "^U"      kill-whole-line                      # ctrl-k
bindkey "^R"      history-incremental-search-backward  # ctrl-r
bindkey "^A"      beginning-of-line                    # ctrl-a
bindkey "^E"      end-of-line                          # ctrl-e
bindkey "[B"      history-search-forward               # down arrow
bindkey "[A"      history-search-backward              # up arrow
bindkey "^D"      delete-char                          # ctrl-d
bindkey "^F"      forward-char                         # ctrl-f
bindkey "^B"      backward-char                        # ctrl-b

# Add a version control indicator
function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    echo '○'
}

ZSH_THEME_GIT_PROMPT_PREFIX="[git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="]$reset_color"
ZSH_THEME_GIT_PROMPT_DIRTY="$fg[red]"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg[green]"

function parse_git_dirty() {
    gitst="$(git status 2> /dev/null)"
    if [[ ${gitst} =~ 'nothing to commit' ]]; then
        echo $ZSH_THEME_GIT_PROMPT_CLEAN
    else
        echo $ZSH_THEME_GIT_PROMPT_DIRTY
    fi
}

function current_branch() {
    g br | grep -E '^\*.*' | sed 's/\* //g'
}

function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

PROMPT='
%{$fg[magenta]%}%n%{$reset_color%} in %{$fg[yellow]%}%m%{$reset_color%} at %{$fg[red]%}%~%{$reset_color%} on %D{%a, %b} %@ (%h)
$(git_prompt_info) %{$fg[green]%}$(prompt_char)%{$reset_color%} '
setopt promptsubst
