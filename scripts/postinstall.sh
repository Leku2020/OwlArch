#!/bin/bash
echo "Post-installation script running..."

# Actualizar el sistema
pacman -Syu --noconfirm

# Instalar OpenSSH si no está presente
pacman -S --noconfirm openssh

# Habilitar y arrancar el servicio SSH
systemctl enable sshd
systemctl start sshd

# Crear el usuario y la contraseña si es necesario
useradd -m -G wheel archuser
echo 'archuser:password' | chpasswd

echo "SSH server is running and user created."
