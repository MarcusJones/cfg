echo "In ~.zshrc"

# SETUP! #######################################
# Solve this error: WARNING! Your terminal supports less than 256 colors!
export TERM="xterm-256color"
export DISABLE_AUTO_TITLE='true'

# LINUX HISTORY NO LINE NUMBERS
HISTTIMEFORMAT="$(echo -e '\r\e[K')"

# COLORS 
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


### VI MODE ####################################
echo ${MAGENTA}vi mode enabled${RESET}
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



### PLATFORMIO ##################################
autoload bashcompinit && bashcompinit
eval "$(_PLATFORMIO_COMPLETE=source platformio)"
eval "$(_PIO_COMPLETE=source pio)"

### UI NOTES ####################################
echo ${BOLD_GREEN}"*** UI NOTES ***"${GREEN}
echo Guake shortcuts
echo 	Ctrl-Shift-H - Next tab
echo 	Ctrl-Shift-L - Prev tab
echo 	Ctrl-Shift-R - Rename tab


### ALIASES #####################################
alias mj="source mj.sh"
alias tc="truffle compile --reset"
alias tm="truffle migrate"
alias tcm="truffle compile --reset & truffle migrate"
alias tt="truffle test"
alias jlhome="jupyter-lab"
alias jl="jupyter-lab --notebook-dir=\"/home/batman/git/ref_DataScienceRetreat/DSR Lecture notebooks\""
alias act="source activate"
alias an="anaconda-navigator"
alias bcc="bitcoin-cli"
alias pio="platformio"
alias kk="kubectl"
echo "Added aliases: mj, act, jl, jlhome, an, bcc"

# DOTFILES ALIAS
alias config='/usr/bin/git --git-dir=/home/batman/.cfg/ --work-tree=/home/batman'
echo "config = git for dotfiles alias solved"


### ENVIRONEMENT #################################
echo ${BOLD_YELLOW}"*** ENVIRONMENT ***"
echo -n ${YELLOW}
echo "Add activate.sh from Anaconda, for autoenv"
#source $HOME/anaconda3/bin/activate.sh
#source $HOME/anaconda3/bin/activate

# AWS PROFILES 
export AWS_PROFILE=kubernetes
echo 'AWS_PROFILE='$AWS_PROFILE 
export AWS_KEY_PATH=~/keys/trilobite.pem
echo 'AWS_KEY_PATH='$AWS_KEY_PATH

export AIRFLOW_HOME=~/airflow
echo 'AIRFLOW_HOME='$AIRFLOW_HOME
echo Set Airflow environment! 
# KUBERNETES AUTO COMPLETE
source <(kubectl completion zsh)  # setup autocomplete in zsh into the current shell
# echo "if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi" >> ~/.zshrc # add autocomplete permanently to your zsh shell

# CUDA ENV 
# export PATH=/usr/local/cuda-9.0/bin:$PATH
# export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64:$LD_LIBRARY_PATH
export PATH=/usr/local/cuda-9.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
#export PATH=/usr/local/cuda-9.0/bin:$PATH
#export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64:$LD_LIBRARY_PATH
echo Set CUDA environment!

# NETWORK
#myextip(){   
#	this_ip="(host -t txt o-o.myaddr.l.google.com 8.8.8.8 | grep -oP 'client-subnet \K(\d{1,3}\.){3}\d{1,3}')"
#	return this_ip
#}

mylanip() {
	this_ip=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
	echo $this_ip
	#return $(this_ip)
}

# mylanip2() {
#ip4=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
#	return ip4
#}
#myextip
#echo EXTERNAL IP: $myextip
#mylanip
#mylanip2
echo LAN IP: $(mylanip)
echo -n ${RESET}

### PLUGIN MANAGER ##############################
source ~/antigen.zsh
antigen use oh-my-zsh
antigen bundle vi-mode
antigen bundle supercrabtree/k
antigen bundle iboyperson/zsh-pipenv 
# CUSTOM PLUGINS
#. ./.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
antigen bundle zsh-users/zsh-autosuggestions
# If you come from bash you might have to change your $PATH.

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

### THEME ######################################
#ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE='agnoster'
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(anaconda aws nodeenv virtualenv docker_machine dir vcs) # context 
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(virtualenv docker_machine dir vcs) # context 
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
COMPLETION_WAITING_DOTS="true"

echo ${BOLD_MAGENTA}"Theme set to" $ZSH_THEME ${RESET}

plugins=(
  git
  # autoenv
  zsh-autosuggestions
  vi-mode
  kubectl
)

source $ZSH/oh-my-zsh.sh
antigen apply

### PATH ####################################################
# added by Anaconda3 installer
export PATH="$HOME/anaconda3/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Add homebrew
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

echo ${BOLD_BLUE}"*** PATH ***"
echo -n ${BLUE} 
sed 's/:/\n/g' <<< "$PATH" 
echo -n ${RESET}

### FUNCTIONS #################################################
. ~/.zsh_mj_functions
