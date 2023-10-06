#!/bin/bash

#!!!Script must be run as sudo, not root!!!
#chmod +x i.sh
#sudo ./i.sh

curl -s 'https://archlinux.org/mirrorlist/?country=UA&protocol=https&use_mirror_status=on' | sed -e 's/^#Server/Server/' > /etc/pacman.d/mirrorlist

# Upgrade System
pacman -Syuw --noconfirm #generated new mirrorlist

# Add AUR repo
echo -e '\n[archlinuxfr]\nSigLevel = Never\nServer = http://repo.archlinux.fr/$arch' >> /etc/pacman.conf

# Install Apps
#pacman -S telegram-desktop pavucontrol reflector lxappearance qt5ct qt5-styleplugins python-pip xdiskusage fzf python-pip xdiskusage earlyoom qbittorrent pinta xnviewmp gnome-screenshot blueman --noconfirm
# xboxdrv smartmontools
# gnome-screenshot-3.36.0-1

pacman -S i3-wm chromium xf86-video-amdgpu amdvlk htop xorg-xprop xorg-xkill alsa-utils usbutils git openssh fish tilix bash-completion geany rsync dmenu sox dunst xclip xxkb nitrogen gsimplecal ttf-droid ttf-dejavu ttf-font-awesome ttf-liberation noto-fonts-emoji faenza-icon-theme file-roller filezilla smplayer gthumb meld gparted udevil ntfs-3g unrar gst-plugins-good xdg-desktop-portal xdg-desktop-portal-gtk
# qt5-tools avahi

cd /tmp
# yay
pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
# paru
# pacman -S --needed git base-devel && git clone https://aur.archlinux.org/paru-bin.git && cd paru-bin && makepkg -si

# yay -Sa linux-ck-uksm linux-ck-uksm-headers
yay -Sa linux linux-headers

yay -S spacefm polybar vertex-themes radeon-profile-daemon-git unclutter-xfixes-git ttf-ms-fonts ttf-unifont goodvibes downgrade --noconfirm
# yay -S visual-studio-code-bin ventoy-bin flashplayer-standalone megasync-bin gnome-boxes qownnotes notepadnext
# amdvlk - add vulcan

# blueman
# sudo systemctl enable --now bluetooth.service

# build radeon-profile-daemon-git
# yrs qt5-charts; git clone https://github.com/Oxalin/radeon-profile.git && cd radeon-profile/radeon-profile qmake && make
# yrs qt5-charts; git clone https://github.com/Oxalin/radeon-profile-daemon.git && cd radeon-profile-daemon/radeon-profile-daemon qmake && make
# sudo cp radeon-profile-daemon.service /etc/systemd/system/
# systemctl enable radeon-profile-daemon.service && systemctl start radeon-profile-daemon.service

# build spacefm
# git clone git@github.com:thermitegod/spacefm.git
# cd spacefm && mkdir build && cd build
# pacman -S exo ffmpegthumbnailer
# meson ..
# ninja

# epson-inkjet-printer-escpr simplescreenrecorder multibootusb-git deadbeef mpg123 earlyoom --noconfirm

# goodvibes => gst-plugins-good, gst-plugins-base-libs, gst-plugins-bad, qt5-tools
# spacefm => ntfs-3g, unrar
# multibootusb-git => udisks2
# lsusb => usbutils
# polybar(goodvibes) => xclip
# dmenu(audio) => sox
# yuzu => libibus qt5-multimedia pulseaudio pavucontrol
# wmctrl => viber (close window)
# xdg-desktop-portal => appimage (promt file)

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

# limit systemd journald
echo -e 'SystemMaxUse=50\nMaxFileSec=1week' >> /etc/udevil/udevil.conf

# allow SpaceFM mount partitions without USERS
echo -e 'allowed_internal_devices = *' >> /etc/udevil/udevil.conf

# allow SpaceFM power-off-drive
echo -e 'polkit.addRule(function(action, subject) {
  var YES = polkit.Result.YES;
  var permission = {
    "org.freedesktop.udisks2.power-off-drive-other-seat": YES
  };
  if (subject.isInGroup("users")) {
    return permission[action.id];
  }
});' >> /etc/polkit-1/rules.d/50-udisks.rules

echo -e 'Section "Device"
    Identifier           "AMD"
    Driver               "amdgpu"
    Option "DRI"         "3"
    Option "TearFree"    "true"
EndSection' >> /etc/X11/xorg.conf.d/20-amdgpu.conf

# OFF analytics
echo -e '127.0.0.1	ssl.google-analytics.com' >> /etc/hosts

# OFF swap
systemctl disable swap.target

# OFF Realteck Audio
# echo -e 'blacklist snd_hda_intel' >> /etc/modprobe.d/blacklist.conf

# sync time ON
echo -e '
NTP=0.arch.pool.ntp.org 1.arch.pool.ntp.org 2.arch.pool.ntp.org 3.arch.pool.ntp.org
FallbackNTP=0.pool.ntp.org 1.pool.ntp.org 0.fr.pool.ntp.org' >> /etc/systemd/timesyncd.conf
timedatectl set-ntp true

# sed -i.bak 's/timeout=5/timeout=1/g' /boot/grub/grub.cfg
# grub-mkconfig -o /boot/grub/grub.cfg
# save manual select kenter
# echo -e 'GRUB_SAVEDEFAULT=true
# GRUB_DEFAULT=saved' >> /etc/default/grub
# add after "linux	/boot/vmlinuz"
# noibrs noibpb nopti nospectre_v2 nospectre_v1 l1tf=off nospec_store_bypass_disable no_stf_barrier mds=off tsx=on tsx_async_abort=off mitigations=off

# earlyoom
# systemctl enable earlyoom.service
## systemctl start earlyoom.service
# echo -e '
# EARLYOOM_ARGS="-M 488281"' >> /etc/default/earlyoom
# systemctl restart earlyoom

# disable thumbnails cache
dconf write /org/gnome/desktop/thumbnailers/disable "['application/pdf','image/jpeg','video/mp4']"

# read -p "pause 1- sec" -t 10
#reboot
