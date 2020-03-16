# Quick aliases
alias ls='ls -hFvbA --color=always --group-directories-first'
alias grep='grep --color=auto'
alias du='du -h'
alias umount='sudo umount'
alias mkdir='mkdir -p'
alias rm='sudo rm -rv --preserve-root'
alias mv='rsync -rvP --remove-source-files'
alias cp='rsync -rv --progress'
# alias mv='mv -iv'
# alias cp='sudo cp -iv'
alias ln='ln -iv'
alias df='df -Th'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

alias pacman='sudo pacman'
alias pac='pacman'
alias pacs='pacman -Sy'
# alias pacst='pacman -S --asdeps'
alias pacsy='pacman -S --noconfirm'
alias pacss='pacman -Ss'
alias pacqs='pacman -Qs'
alias pacu='pacman -U'
alias paci='pacman -Si'
alias pacr='pacman -Rnsc'
alias pacclear='pacman -Rnsc (pacman -Qtdq); yr -Qdt'
alias pacfix='sudo rm -f /var/lib/pacman/db.lck ;and pacman -Syyuu'
alias yr='yay'
alias yrs='yr -S'
alias yrsy='yr -S --noconfirm'

alias upmiror="sudo curl -s 'https://www.archlinux.org/mirrorlist/?country=UA&protocol=https&use_mirror_status=on' | sed -e 's/^#Server/Server/' > sudo /etc/pacman.d/mirrorlist ; cat /etc/pacman.d/mirrorlist"
alias up='pacman -Syu; yr -Syua ;and pacman -Sc'
alias upy='pacman -Syu; yr -Syua --noconfirm ;and pacman -Sc --noconfirm'
alias upi='pacman -Qu'

alias fishr='source ~/.config/fish/config.fish'
alias dunstr='killall dunst; notify-send "dunst restart" "test critical" -u critical & notify-send "dunst" "test normal" -u normal & notify-send "dunst" "test low" -u low'

alias xprop='xprop | grep -E "^(WM_CLASS|_NET_WM_NAME|WM_NAME)"'
alias off='shutdown -P now'
alias x='exit'

alias ed='sudo geany'
alias myip='curl ipinfo.io/ip ;or curl icanhazip.com'
alias steam='env LD_PRELOAD="/usr/$LIB/libstdc++.so.6 /usr/$LIB/libgcc_s.so.1 /usr/$LIB/libxcb.so.1 /usr/$LIB/libgpg-error.so" STEAM_RUNTIME=1 steam'
