#!/bin/bash

#!!!Script must be run as sudo, not root!!!
#chmod +x i.sh
#sudo ./i.sh

curl -s 'https://www.archlinux.org/mirrorlist/?country=UA&protocol=https&use_mirror_status=on' | sed -e 's/^#Server/Server/' > /etc/pacman.d/mirrorlist

# Upgrade System
pacman -Syuw --noconfirm #generated new mirrorlist

# Add AUR repo
echo -e '\n[archlinuxfr]\nSigLevel = Never\nServer = http://repo.archlinux.fr/$arch' >> /etc/pacman.conf

# Install Apps
#pacman -S xf86-video-ati pavucontrol avahi reflector lxdm qt5ct xorg-xprop lxappearance qt5ct qt5-styleplugins python-pip xdiskusage python-pip xdiskusage qbittorrent pinta xnviewmp gnome-screenshot --noconfirm
# gnome-screenshot-3.36.0-1

pacman -S xf86-video-amdgpu usbutils chromium htop alsa-utils git openssh i3-wm bash-completion fish tilix geany rsync dmenu udevil file-roller nitrogen gsimplecal sox dunst xclip xxkb ttf-droid ttf-dejavu ttf-font-awesome ttf-liberation faenza-icon-theme gnome-calculator telegram-desktop filezilla smplayer gthumb fzf meld gparted ntfs-3g unrar gst-plugins-good qt5-tools

# yay
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay -S amdgpu-pro-libgl vulkan-amdgpu-pro opencl-amdgpu-pro-orca polybar spacefm vertex-themes unclutter-xfixes-git ttf-ms-fonts visual-studio-code-bin goodvibes downgrade --noconfirm

# epson-inkjet-printer-escpr flashplayer-standalone megasync simplescreenrecorder multibootusb-git deadbeef mpg123 earlyoom --noconfirm

# goodvibes => gst-plugins-good, gst-plugins-base-libs, gst-plugins-bad, qt5-tools
# spacefm => ntfs-3g, unrar
# qownnotes => from official site
# multibootusb-git => udisks2

# coredump OFF
echo -e 'Storage=none' >> /etc/systemd/coredump.conf

# Autologin from lxdm ON
# systemctl enable lxdm.service
# echo -e "autologin="${USER} >> /etc/lxdm/lxdm.conf
# echo -e "autologin=art" >> /etc/lxdm/lxdm.conf

# clear DM
rm /usr/share/xsessions/i3-with-shmlog.desktop

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

set fish default shell
chsh -s /usr/bin/fish

# from GTK 3
# mkdir -p ~/.config/gtk-3.0
echo -e "[Settings]\ngtk-recent-files-max-age=0\ngtk-recent-files-limit=0" > ~/.config/gtk-3.0/settings.ini
# from GTK 2
echo 'gtk-recent-files-max-age=0' >> ~/.gtkrc-2.0

# allow spacefm mount partitions without USERS
echo -e 'allowed_internal_devices = *' >> /etc/udevil/udevil.conf

# limit systemd journald
echo -e 'SystemMaxUse=50\nMaxFileSec=1week' >> /etc/udevil/udevil.conf

# OFF analytics
echo -e '127.0.0.1	ssl.google-analytics.com' >> /etc/hosts

# OFF swap
systemctl disable swap.target

# sync time ON
echo -e '
NTP=0.arch.pool.ntp.org 1.arch.pool.ntp.org 2.arch.pool.ntp.org 3.arch.pool.ntp.org
FallbackNTP=0.pool.ntp.org 1.pool.ntp.org 0.fr.pool.ntp.org' >> /etc/systemd/timesyncd.conf
timedatectl set-ntp true

sed -i.bak 's/timeout=5/timeout=1/g' /boot/grub/grub.cfg
grub-mkconfig -o /boot/grub/grub.cfg

cp earlyoom.service /etc/systemd/system/
systemctl daemon-reload

# echo -e '
# EARLYOOM_ARGS="-M 488281"' >> /etc/default/earlyoom
# systemctl restart earlyoom

# read -p "pause 1- sec" -t 10
#reboot
