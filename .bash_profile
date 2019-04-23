# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
parse_git_branch() {
	hasmod=""
	if [[ `git ls-files -dmo --exclude-standard 2> /dev/null` ]]; then
		hasmod="*"
	fi
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1$hasmod)/"
}

# colors of terminal
export CLICOLOR=1
export PS1="\[\033[36m\]\u\[\033[m\]\[\033[32m\]:\[\033[33;1m\]\W\[\033[m\]\[\033[32m\]\$(parse_git_branch)\[\033[00m\]$ "
alias ls='ls -GFh --color=auto'
export LS_COLORS=$LS_COLORS:'di=1;33:ln=0;37:ex=96'
