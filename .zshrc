echo "In ~.zshrc"

# Solve this error: WARNING! Your terminal supports less than 256 colors!
export TERM="xterm-256color"

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



### ALIASES ###
alias mj="source mj.sh"
alias jlhome="jupyter-lab"
alias jl="jupyter-lab --notebook-dir=\"/home/batman/git/ref_DataScienceRetreat/DSR Lecture notebooks\""
alias act="source activate"
alias an="anaconda-navigator"
alias bcc="bitcoin-cli"
echo "Added aliases mj, act, jl, jlhome, an, bcc"



### Kubernetes auto complete ###
source <(kubectl completion bash)

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
#ZSH_THEME="agnoster"
#ZSH_THEME="refined"
echo "Theme set to" $ZSH_THEME

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  autoenv
  zsh-autosuggestions
  vi-mode
  kubectl
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# added by Anaconda3 installer
export PATH="$HOME/anaconda3/bin:$PATH"



echo "*** PATH ***"
sed 's/:/\n/g' <<< "$PATH"

echo "Add activate.sh from Anaconda, for autoenv"
source $HOME/anaconda3/bin/activate.sh

alias config='/usr/bin/git --git-dir=/home/batman/.cfg/ --work-tree=/home/batman'

function hello() {
   echo "Hello, $1!"
}


condarem() {
# Iterate over the list of environment names
# Conda remove them without prompting
	for var in "$@"
	do
		echo "Force removing environment $var"
		conda-env remove --y --n "$var"
	done
}



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
