---Creating filesystem
cfdisk /dev/sda

# pacman -Sy f2fs-tools
# mkfs.fat -F32 -n "BOOT_FS" /dev/sda1
mkfs.f2fs -L "ROOT_FS"  /dev/sda2
mkfs.f2fs -L "HOME_FS" /dev/sda5

mount -L ROOT_FS /mnt
mkdir /mnt/{boot,home}
# mount -L BOOT_FS /mnt/boot
mount -L HOME_FS /mnt/home

timedatectl set-ntp true && \
timedatectl status

--Installation
pacstrap /mnt base base-devel linux linux-firmware nano linux-headers
genfstab -U -p /mnt >> /mnt/etc/fstab

--Setting Timezone
# ls /usr/share/zoneinfo
ln -sf /usr/share/zoneinfo/Europe/Kiev/etc/localtime
hwclock --systohc --localtime
# timedatectl set-local-rtc 1 --adjust-system-clock

--Setting up Locale
localectl list-locales
localectl set-locale LANG=en_GB.UTF-8
------ or
echo -e "en_GB.UTF-8 UTF-8  
en_GB ISO-8859-1" > /etc/locale.gen
locale-gen
echo LANG=en_GB.UTF-8 > /etc/locale.conf
export LANG=en_GB.UTF-8
--
arch-chroot /mnt
hostnamectl status
hostnamectl set-hostname "pc"
---
nano /etc/systemd/network/20-wired.network
[Match]
Name=en*
# Name=enp3s0f0

[Network]
DHCP=ipv4
--
# cat /etc/systemd/resolved.conf
# [Resolve]
# DNS=8.8.8.8 8.8.4.4
--
systemctl enable systemd-networkd
systemctl enable systemd-resolved
systemctl disable dhcpcd
ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
# ls -la /etc/resolv.conf
resolvectl status
---
passwd
useradd -g users -G wheel,storage,power,autologin,audio art
passwd art
# chage -d 0 art
--
# pacman -S sudo
echo "%wheel ALL=(ALL) ALL" > /etc/sudoers
--
pacman -Syyuu
--
# pacman -S grub efibootmgr dosfstools os-prober mtools
# check is install in base? - dosfstools mtools
pacman -S os-prober grub
grub-install --recheck /dev/sda
mkinitcpio -p linux
grub-mkconfig -o /boot/grub/grub.cfg
--
pacman -S lxdm
systemctl enable lxdm.service
# fix slow running for Load/Save Random Seed
pacman -S haveged
systemctl enable haveged
--
umount -a
telinit 6

