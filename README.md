# MyDotfiles

before boot old pc, '~./wsl-inventory.sh'
then push wsl-backup and dotfiles
then boot the pc
then pull wsl-backup
run ./master-reinstall.sh
then clone dotfiles repo and run 'stow --adopt .'
