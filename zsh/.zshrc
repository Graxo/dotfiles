# Use bash-style aliases/functions
setopt aliasfuncdef

# Enable completion
autoload -Uz compinit && compinit

# Set PATH or other ENV vars
export PATH="$HOME/bin:$PATH"

# Load user aliases
[ -f ~/.aliases ] && source ~/.aliases

# Load modular Zsh configs
for file in ~/.zshrc.d/*.zsh; do
  [ -r "$file" ] && source "$file"
done

# Enable colors and nice prompt
autoload -Uz colors && colors
PROMPT='%F{green}%n@%m%f:%F{blue}%~%f %# '
