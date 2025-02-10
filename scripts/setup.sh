#!/bin/bash

# Stop on errors
set -e

#######################
#  Setting variables  #
#######################
DRIVE=${DRIVE:-/dev/vda}
IS_UEFI=${IS_UEFI:-false}
HOSTNAME=${HOSTNAME:-'owlArch'}
KEYMAP=${KEYMAP:-'es'}
LANGUAGE=${LANGAGE:-'es_ES.UTF-8'}
COUNTRIES=${COUNTRIES:-all}
TIMEZONE='UTC'
TARGET_DIR='/mnt'
USERNAME='owlArch'

if [ $PACKER_BUILDER_TYPE == "qemu" ]; then
  DISK='/dev/vda'
else
  DISK='/dev/sda'
fi

ROOT_PARTITION="${DISK}1"
UEFI_PART="${DISK}1"

echo "#################"
echo "#   Variables   #"
echo "#################"
echo "^.^ >>  IS_UEFI: ${IS_UEFI}"
echo "^.^ >>  HOTNAME: ${HOSTNAME}"
echo "^.^ >>  KEYMAP: ${KEYMAP}"
echo "^.^ >>  LANGUAGE: ${LANGUAGE}"
echo "^.^ >>  COUNTRIES: ${COUNTRIES}"
echo "^.^ >>  TIMEZONE: ${TIMEZONE}"
echo "^.^ >>  TARGET_DIR: ${TARGET_DIR}"
echo "^.^ >>  PACKER_BUILD_TYPE: ${PACKER_BUILDER_TYPE}"
echo "^.^ >>  DISK: ${DISK}"
echo "^.^ >>  ROOT_PARTITION: ${ROOT_PARTITION}"
echo "^.^ >>  UEFI_PART: ${UEFI_PART}"

##################
#   Disk setup   #
##################

echo "##################"
echo "#   Disk Setup   #"
echo "##################"

if [ "${IS_UEFI}" != "false" ] ; then
    echo "^.^ >> Is uefi"
    echo "^.^ >> Clearing partition table on ${DISK}.."
    /usr/bin/sgdisk --zap ${DISK}

    echo "^.^ >> Destroying magic strings and signatures on ${DISK}.."
    /usr/bin/dd if=/dev/zero of=${DISK} bs=512 count=2048
    /usr/bin/wipefs --all ${DISK}

    echo "^.^ >> Creating /root partition on ${DISK}.."
    /usr/bin/sgdisk --new=1:0:0 ${DISK}

    echo "^.^ >> Setting ${DISK} bootable.."
    /usr/bin/sgdisk ${DISK} --attributes=1:set:2
else
    echo "^.^ >> Setting ${DISK} minimum partition"
    sfdisk --force ${DISK}  << PARTITION
label: dos
device: ${DISK}
unit: sectors
sector-size: 512

/dev/sda1 : start= 2048, size= 1, type=83, bootable

PARTITION
    echo "^.^ >> Setting ${DISK} extend partition to max disk"
    parted ${DISK} resizepart 1 100%
fi

echo "^.^ >> Creating /root filesystem (ext4).."
/usr/bin/mkfs.ext4 -O ^64bit -F -m 0 -q -L root ${ROOT_PARTITION}

echo "^.^ >> Mounting ${ROOT_PARTITION} to ${TARGET_DIR}.."
/usr/bin/mount -o noatime,errors=remount-ro ${ROOT_PARTITION} ${TARGET_DIR}

############################
# Installing base software #
############################

echo "#############################"
echo "#   Install base software   #"
echo "#############################"

echo "^.^ >> Bootstrapping the base installation.."
/usr/bin/pacstrap ${TARGET_DIR} base base-devel linux-lts lvm2 linux-firmware

####################
# Generating fstab #
####################

echo "########################"
echo "#   Generating fstab   #"
echo "########################"

echo "^.^ >> Generating the filesystem table.."
/usr/bin/genfstab -p ${TARGET_DIR} >> "${TARGET_DIR}/etc/fstab"

echo "###################"
echo "# Entering chroot #"
echo "###################"

arch-chroot ${TARGET_DIR} <<EOFCHROOT

echo "#############################"
echo "# Setting localse and clock #"
echo "#############################"

ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
hwclock --systohc

sed -i '/^#.${LANGUAGE}/s/^#//' /etc/locale.gen &&  sed -i '/^#.*en_US.UTF-8/s/^#//' /etc/locale.gen
locale-gen
echo "LANG=${LANGUAGE}" | tee /etc/locale.conf
echo "KEYMAP=${KEYMAP}" |  tee /etc/vconsole.conf

echo "####################"
echo "# Configuring host #"
echo "####################"

echo ${HOSTNAME} > /etc/hostname
cat <<EOF > /etc/hosts
127.0.0.1   localhost
::1         localhost
127.0.1.1   ${HOSTNAME}
EOF

echo "#################"
echo "# Setting users #"
echo "#################"

useradd -m -s /bin/bash ${USERNAME}
echo "${USERNAME}:${USERNAME}" | chpasswd
 usermod -aG wheel ${USERNAME}
echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/ers

echo "#####################"
echo "# Setting initframs #"
echo "#####################"

/usr/bin/sed -i 's/block filesystems/block lvm2 filesystems/' /etc/mkinitcpio.conf
/usr/bin/mkinitcpio -p linux-lts

echo "#################################"
echo "# Repo update and base software #"
echo "#################################"

pacman -Syu --noconfirm
pacman -S --noconfirm gptfdisk bash-completion rsync dehcpcd ufw firejail archaudit libpwquality

echo "###########################"
echo "# Setting GRUB bootloader #"
echo "###########################"

 if [ "${IS_UEFI}" != "false" ] ; then
    echo ">>>> ${CONFIG_SCRIPT_SHORT}: Insatll grub EFI packages"
    pacman -S --noconfirm grub efibootmgr dosfstools os-prober mtools
  else
    echo ">>>> ${CONFIG_SCRIPT_SHORT}: Install grub bios packages"
    pacman -S --noconfirm grub dosfstools os-prober mtools
  fi

/usr/bin/sed -i  's/GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"/' /etc/default/grub

  if [ "${IS_UEFI}" != "false" ] ; then
    echo ">>>> ${CONFIG_SCRIPT_SHORT}: Installing UEFI grub"
    mkdir -p /boot/EFI
    mount ${UEFI_PART} /boot/EFI
    grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
    mkdir -p /boot/grub/locale
    cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
    grub-mkconfig -o /boot/grub/grub.cfg
  else
    echo ">>>> ${CONFIG_SCRIPT_SHORT}: Installing BIOS grub"
    grub-install --target=i386-pc --recheck ${DISK} 
    # mkdir /boot/grub/locale
    cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
    grub-mkconfig -o /boot/grub/grub.cfg
  fi

/usr/bin/pacman -Rcns --noconfirm gptfdisk


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
