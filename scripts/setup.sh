#!/bin/bash

DRIVE=${DRIVE:-/dev/vda}
set -e

# Configuración básica de Arch
echo ">>>> SETUP: Configuring owlArch..."
echo ">>>> SETUP: Configuring clock..."
timedatectl set-ntp true
ln -sf /usr/share/zoneinfo/UTC /etc/localtime
hwclock --systohc

# Particionar disco
echo ">>>> SETUP: Partitioning drive ${DRIVE}..."
parted ${DRIVE} --script mklabel gpt
parted ${DRIVE} --script mkpart primary ext4 1MiB 8191MiB
parted ${DRIVE} --script print
parted ${DRIVE} --script set 1 boot on

echo ">>>> SETUP: Formatting the partitions..."
mkfs.ext4 /dev/vda1

echo ">>>> SETUP: Mounting the filesystems..."
mount /dev/vda1 /mnt


# Instalación mínima
echo ">>>> SETUP: Basic install..."
echo ">>>> SETUP: Installing basic firmware..."
pacstrap /mnt base linux linux-firmware
pacstrap /mnt wpa_supplicant networkmanager

pacstrap /mnt grub-bios os-prober ntfs-3g

echo ">>>> SETUP: Generating fstabs..."
genfstab -U /mnt >> /mnt/etc/fstab
echo ">>>> SETUP: Accessing /mnt as root..."
arch-chroot /mnt <<EOFCHROOT

echo ">>>> SETUP: Generating locales and configuring clock..."
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc

echo ">>>> SETUP: Configuring locales"
sed -i '/^#.*es_ES.UTF-8/s/^#//' /etc/locale.gen &&  sed -i '/^#.*en_US.UTF-8/s/^#//' /etc/locale.gen
locale-gen
echo "LANG=es_ES.UTF-8" | tee /etc/locale.conf
echo "KEYMAP=es" |  tee /etc/vconsole.conf

echo ">>>> SETUP: Configuring hosts file..."
echo "owlArch" > /etc/hostname
cat <<EOF > /etc/hosts
127.0.0.1   localhost
::1         localhost
127.0.1.1   owlArch
EOF

echo ">>>> SETUP: Configuring OwlArch user..."
useradd -m -s /bin/bash owlArch
echo "owlArch:owlArch" | chpasswd
 usermod -aG wheel owlArch
echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/ers

echo ">>>> SETUP: Updating pacman repos and db..."
pacman -Syu --noconfirm

#echo ">>>> SETUP: Downloading Grub..."
#pacman -S --noconfirm grub efibootmgr
#ls /boot
#grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
#grub-mkconfig -o /boot/grub/grub.cfg


echo ">>>> SETUP: Installing Qemu Guest Additions and NFS utilities..."
pacman -Sy --noconfirm qemu-guest-agent nfs-utils

echo ">>>> SETUP: Enabling RPC Bind service..."
systemctl enable rpcbind.service

echo ">>>> SETUP: Enabling Qemu Guest service..."
systemctl enable qemu-guest-agent.service

echo ">>>> SETUP: Downloading gnome and its dependencies..."
pacman -S --noconfirm xorg xorg-server gnome gdm

echo ">>>> gnome.sh: Adding gdm to the OS startup..."
systemctl enable gdm
systemctl start gdm

EOFCHROOT
#mount /dev/vda1 /boot
#grub-install --target=x86_64-efi efi-directory=/boot --bootloader-id=GRUB
#grub-mkconfig -o /boot/grub/grub.cfg
set -euxo pipefail
