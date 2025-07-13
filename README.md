# MyDotfiles

before boot old pc, '~./wsl-inventory.sh'
then push wsl-backup and dotfiles
then boot the pc
then pull wsl-backup
run ./master-reinstall.sh
then clone dotfiles repo and run 'stow --adopt .'
then, 'cp -r ~/zedScript/ /mnt/c/zedScript/'
then, windows+r shell:startup, make new shortcut of them.
