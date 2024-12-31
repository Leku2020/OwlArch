#!/bin/bash
set -e

# Configuración básica de Arch
echo "Configuring OwlArch..."
timedatectl set-ntp true
ln -sf /usr/share/zoneinfo/UTC /etc/localtime
hwclock --systohc

# Idioma y teclado
echo "LANG=ee_ES.UTF-8" > /etc/locale.conf
echo "KEYMAP=es" > /etc/vconsole.conf
locale-gen

# Nombre del host
echo "owlArch" > /etc/hostname
cat <<EOF > /etc/hosts
127.0.0.1   localhost
::1         localhost
127.0.1.1   owlArch
EOF

# Instalación mínima
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt <<EOFCHROOT
pacman -Syu --noconfirm
EOFCHROOT

set -euxo pipefail

# Instalar y configurar SSH
pacman -Sy --noconfirm openssh
systemctl enable sshd
systemctl start sshd

# Crear el usuario SSH
useradd -m -s /bin/bash archuser
echo "archuser:password" | chpasswd
echo "archuser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Permitir root por SSH (opcional, solo para debugging)
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl restart sshd
