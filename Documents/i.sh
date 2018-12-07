#!/bin/bash

#!!!Script must be run as sudo, not root!!!
#help how to use:

#chmod +x i.sh
#sudo ./i.sh

# mkinitcpio -p linux

curl -s 'https://www.archlinux.org/mirrorlist/?country=UA&protocol=https&use_mirror_status=on' | sed -e 's/^#Server/Server/' > /etc/pacman.d/mirrorlist
cat /etc/pacman.d/mirrorlist

# Upgrade System
# pacman -Syuu --noconfirm #generated new mirrorlist
pacman -Syuw --noconfirm #generated new mirrorlist

#pacman-key --populate archlinux #импортировать ключи
# pacman -Syyuu; pacman -Suu

# pacs archlinux-keyring

pacman -S base-devel --needed --noconfirm

# Add AUR repo
echo -e '\n[archlinuxfr]\nSigLevel = Never\nServer = http://repo.archlinux.fr/$arch' >> /etc/pacman.conf
# echo -e '[archlinuxcn]\nSigLevel = Never\nServer = https://cdn.repo.archlinuxcn.org/$arch' >> /etc/pacman.conf

pacman -Sy yaourt --noconfirm

# Install Apps
# pulseaudio pavucontrol / alsa-firmware  alsa-oss
# gst-plugins-ugly 
# pacman -S  htop xf86-video-ati alsa-utils lxappearance wget gsimplecal dmenu mc dconf-editor conky --noconfirm

pacman -S lxdm avahi fish i3-gaps i3status chromium git reflector file-roller nitrogen geany dunst qt5ct xorg-xprop xclip xxkb ttf-droid ttf-dejavu ttf-liberation faenza-icon-theme mpg123 gnome-calculator python-pip xdiskusage meld gnome-screenshot smplayer qbittorrent filezilla xnviewmp --noconfirm
#conky-manager inkscape pinta gthumb ppsspp  
#inxi dmidecode gnome-disk-utility neofetch woeusb-git

yaourt -S tilix-bin py3status spacefm-git downgrade unclutter-xfixes-git qt5-styleplugins ttf-ms-fonts ttf-font-awesome visual-studio-code-bin deadbeef-git qownnotes telegram-desktop-bin --noconfirm
#epson-inkjet-printer-escpr flashplayer-standalone megasync simplescreenrecorder

# coredump OFF
echo -e 'Storage=none' >> /etc/systemd/coredump.conf

# Autologin from lxdm ON
systemctl enable lxdm.service
# echo -e "autologin="${USER} >> /etc/lxdm/lxdm.conf
echo -e "autologin=art" >> /etc/lxdm/lxdm.conf

# clear DM
# rm /usr/share/xsessions/openbox-kde.desktop

echo -e 'Section "InputClass"
    Identifier          "keyboard-layout"
    MatchIsKeyboard     "on"
    Option "XkbLayout"  "us,ru"
    Option "XkbOptions" "grp:caps_toggle"
EndSection' >> /etc/X11/xorg.conf.d/20-keyboard-layout.conf

# move tmp in memory
echo -e '
tmpfs    /home/art/.cache           tmpfs    defaults,nosuid,noatime,nodev,mode=1777  0 0
tmpfs    /var/cache/pacman/pkg      tmpfs    defaults,nosuid,noatime,nodev,mode=1777  0 0
tmpfs    /var/cache/debtap          tmpfs    defaults,nosuid,noatime,nodev,mode=1777  0 0
tmpfs    /var/tmp                   tmpfs    defaults,nosuid,noatime,nodev,mode=1777  0 0
tmpfs    /var/log                   tmpfs    defaults,nosuid,noatime,nodev,mode=1777  0 0
tmpfs    /tmp                       tmpfs    defaults,nosuid,noatime,nodev,mode=1777,size=4G  0 0' >> /etc/fstab

# access run wvdial
groupadd dialout
# gpasswd -a user dialout
chgrp dialout /usr/bin/wvdial
chmod u+s /usr/bin/wvdial

# set fish default shell
# chsh -s /usr/bin/fish

reflector --country UA --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# chmod 4755 /bin/ping

# from GTK 3
# mkdir -p ~/.config/gtk-3.0
# echo -e "[Settings]\ngtk-recent-files-max-age=0\ngtk-recent-files-limit=0" > ~/.config/gtk-3.0/settings.ini
# from GTK 2
# echo 'gtk-recent-files-max-age=0' >> ~/.gtkrc-2.0

# allow spacefm mount partitions without USERS
echo -e 'allowed_internal_devices = *' >> /etc/udevil/udevil.conf

# limit systemd journald
echo -e 'SystemMaxUse=50\nMaxFileSec=1week' >> /etc/udevil/udevil.conf

# OFF analytics
echo -e '127.0.0.1	ssl.google-analytics.com' >> /etc/hosts

# OFF swap
systemctl disable swap.target

# Отключение и удаление служб, созданных archiso
systemctl disable pacman-init.service choose-mirror.service
rm -r /etc/systemd/system/{choose-mirror.service,pacman-init.service,etc-pacman.d-gnupg.mount,getty@tty1.service.d}
# Удаление особых скриптов Live среды
rm -r /etc/initcpio

# pacman -S grub
# grub-install /dev/sda
sed -i.bak 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/g' /boot/grub/grub.cfg
# sed -i.bak 's/timeout=5/timeout=1/g' /boot/grub/grub.cfg
grub-mkconfig -o /boot/grub/grub.cfg

#reboot
