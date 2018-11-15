echo "In ~.zshrc"

# Solve this error: WARNING! Your terminal supports less than 256 colors!
export TERM="xterm-256color"

### COLORS ###
autoload colors
if [[ "$terminfo[colors]" -gt 8 ]]; then
    colors
fi
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
    eval $COLOR='$fg_no_bold[${(L)COLOR}]'
    eval BOLD_$COLOR='$fg_bold[${(L)COLOR}]'
done
eval RESET='$reset_color'

# echo ${BOLD_RED}BOLD_RED${RESET}
# echo ${RED}RED${RESET}

### NOTES! ###
echo Guake shortcuts
echo Ctrl-Shift-H - Next tab
echo Ctrl-Shift-L - Prev tab
echo Ctrl-Shift-R - Rename tab

### PLUGIN MANAGER ###
source ~/antigen.zsh
antigen bundle vi-mode

### SET VI MODE ###
echo vi mode enabled
bindkey -v
export KEYTIMEOUT=20 # Faster mode switching
# Better searching in command mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward
# Remap esc
bindkey -M viins 'jj' vi-cmd-mode
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins 'kj' vi-cmd-mode
bindkey '^j' vi-cmd-mode
bindkey "jj" vi-cmd-mode
bindkey "jk" vi-cmd-mode
bindkey "kj" vi-cmd-mode


### LINUX HISTORY NO LINE NOS ###
HISTTIMEFORMAT="$(echo -e '\r\e[K')"

### ALIASES ###
alias mj="source mj.sh"
alias jlhome="jupyter-lab"
alias jl="jupyter-lab --notebook-dir=\"/home/batman/git/ref_DataScienceRetreat/DSR Lecture notebooks\""
alias act="source activate"
alias an="anaconda-navigator"
alias bcc="bitcoin-cli"
echo "Added aliases mj, act, jl, jlhome, an, bcc"

### AWS PROFILES ###
export AWS_PROFILE=kubernetes
echo ${BOLD_YELLOW}'AWS_PROFILE=' $AWS_PROFILE${RESET}

### KUBERNETES AUTO COMPLETE ###
source <(kubectl completion zsh)  # setup autocomplete in zsh into the current shell
# echo "if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi" >> ~/.zshrc # add autocomplete permanently to your zsh shell

### CUDA ENV ###
export PATH=/usr/local/cuda-9.0/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64:$LD_LIBRARY_PATH
echo Set CUDA environment!

### CUSTOM PLUGINS ###
. ./.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

### THEME ###
# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE='agnoster'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(anaconda docker_machine dir vcs) # context 
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time vi_mode)
POWERLEVEL9K_PYTHON_ICON='\U1F40D'
POWERLEVEL9K_ANACONDA_LEFT_DELIMITER=""
POWERLEVEL9K_ANACONDA_RIGHT_DELIMITER=""	
POWERLEVEL9K_ANACONDA_BACKGROUND=035
POWERLEVEL9K_ANACONDA_FOREGROUND="white"
POWERLEVEL9K_VIRTUALENV_BACKGROUND="black"
POWERLEVEL9K_VIRTUALENV_FOREGROUND="249"
# Advanced `vcs` color customization
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='blue'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='black'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='black'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='red'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='black'

#ZSH_THEME="agnoster"
#ZSH_THEME="refined"
echo "Theme set to" $ZSH_THEME

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
  git
  # autoenv
  zsh-autosuggestions
  vi-mode
  kubectl
)

source $ZSH/oh-my-zsh.sh

# added by Anaconda3 installer
export PATH="$HOME/anaconda3/bin:$PATH"

echo ${BOLD_BLUE}"*** PATH ***"
echo -n ${BLUE} 
sed 's/:/\n/g' <<< "$PATH" 
echo -n ${RESET}

echo "Add activate.sh from Anaconda, for autoenv"
source $HOME/anaconda3/bin/activate.sh
source $HOME/anaconda3/bin/activate

### DOTFILES CONFIG ###
alias config='/usr/bin/git --git-dir=/home/batman/.cfg/ --work-tree=/home/batman'
echo "config = git for dotfiles alias solved"

### FUNCTIONS ###
function hello() {
   echo "Hello, $1!"
}


condainstall() {
	REQ_FILE=$1
	while read req; do 
		echo "Requirement: $req" 
		echo "conda install --yes $req"
		conda install --yes $req
	done <$REQ_FILE
}
echo "Added function condainstall(requirements.txt)"


condarem() {
# Iterate over the list of environment names
# Conda remove them without prompting
	for var in "$@"
	do
		echo "Force removing environment $var"
		conda-env remove --y --n "$var"
	done
}
echo "Added function condarem(<list env names>)"


clonethis() {
    # Given a github repo name (target, reponame)
    # Clone it to the DIR
	TARGET=$1
	THIS_REPO=$2

	if [ "$TARGET" = "ocn" ]
	then
		ORGANIZATION="oceanprotocol"
		THIS_DIR="ocn"
	elif [ "$TARGET" = "mj" ]
	then
		ORGANIZATION="MarcusJones"
		THIS_DIR="git"
	else
		exit 1
	fi

	echo "Cloning repo $ORGANIZATION/$THIS_REPO into $THIS_DIR"
	git clone https://github.com/$ORGANIZATION/$THIS_REPO.git ~/$THIS_DIR/$THIS_REPO
	# pip install --upgrade --force-reinstall git+https://github.com/$THIS_ORG/$THIS_REPO.git@$THIS_BRANCH
}

echo "Added function clonethis(org, repo, target_dir)"

dockerclean() {
	docker rmi -f $(docker images -q) # Remove all images
	docker rm $(docker ps -a -q) # Remove all 
}

echo "Added function dockerclean()"


install_branch() {
    # Given a github path (organization, repo, branch)
    # pip install the repo
	THIS_ORG=$1
	THIS_REPO=$2
	THIS_BRANCH=$3
	echo 
	echo "Force-installing package from $THIS_BRANCH branch of $THIS_ORG/$THIS_REPO"
	echo
	pip install --upgrade --force-reinstall git+https://github.com/$THIS_ORG/$THIS_REPO.git@$THIS_BRANCH
}

echo "Added function install_branch(organization, repo, branch)"
