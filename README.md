# cfg

## Creating
```
# Create a 'bare' repository
git init --bare $HOME/.cfg

# Interact with the repo using this alias
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Apply it directly to the shell script
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.zshrc
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc

# Set the - local flag to the repo
config config --local status.showUntrackedFiles no
```

## Migrating
```
# first add the alias to .bashrc or .zshrc;
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Ignore the folder, in case of recursion
echo ".cfg" >> .gitignore

# Clone the repo
git clone --bare https://github.com/MarcusJones/cfg.git $HOME/.cfg

# Define the alias in the current shell scope:
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Checkout the contents into the home folder
config checkout
```
