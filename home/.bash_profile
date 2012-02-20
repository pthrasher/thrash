####
# Simple bash bootloader. Load all my shit from .bash_profile.d
####

shopt -s nullglob
for file in "$HOME/.bash_profile.d"/*; do
   source "$file"
done
shopt -u nullglob

