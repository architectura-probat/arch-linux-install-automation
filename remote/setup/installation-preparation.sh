#!/bin/bash
##Verbosity
set -uo pipefail
## Const
CONFIG_BACKUP="/config/backup/"
# 1. Setup keymap to swiss german

echo "Setting keyboard layout to ${keymap}"
keymap="sg-latin1"
loadkeys ${keymap}

## loading keymap
echo "Keymap ${keymap} successfully set."

# 2. Install and change font

pacman -Sy --noconfirm terminus-font
setfont ter-122b

# 3. Start internet
ip link

## 3.1 Setting up Network Time
timedatectl set-ntp true

# Setup Partition


devicelist=$(lsblk -dplnx size -o name,size | grep -Ev "boot|rpmb|loop" | tac)
device=$(dialog --stdout --menu "Select installation disk" 0 0 0 ${devicelist}) || exit 1
clear

### Setup the disk and partitions ###
swap_size=$(free --mebi | awk '/Mem:/ {print $2}')
swap_end=$(( $swap_size + 129 + 1 ))MiB

parted --script "${device}" -- mklabel gpt \
  mkpart ESP fat32 1Mib 129MiB \
  set 1 boot on \
  mkpart primary linux-swap 129MiB ${swap_end} \
  mkpart primary ext4 ${swap_end} 100%

# Simple globbing was not enough as on one device I needed to match /dev/mmcblk0p1
# but not /dev/mmcblk0boot1 while being able to match /dev/sda1 on other devices.
part_boot="$(ls ${device}* | grep -E "^${device}p?1$")"
part_swap="$(ls ${device}* | grep -E "^${device}p?2$")"
part_root="$(ls ${device}* | grep -E "^${device}p?3$")"

wipefs "${part_boot}"
wipefs "${part_swap}"
wipefs "${part_root}"

mkfs.vfat -F32 "${part_boot}"
mkswap "${part_swap}"
mkfs.f2fs -f "${part_root}"

swapon "${part_swap}"
mount "${part_root}" /mnt
mkdir /mnt/boot
mount "${part_boot}" /mnt/boot

# 5. Download and install base system.
# 5.1 - Backup Pacman Mirrorlist and replace with better Options

mv /etc/pacman.d/mirrorlist "${CONFIG_BACKUP}pacman/mirrorlist.bak"
wget -O /etc/pacman.d/mirrorlist "https://www.archlinux.org/mirrorlist/?country=CH&protocol=https&ip_version=4"

## 5.2
pacstrap /mnt base linux-hardened linux-firmware f2fs-tools dosfstools exfat-utils ntfs-3g util-linux lvm2 man-db man-pages texinfo vim emacs

# 5. Enable SSH

echo "Enabling Password"
passwd

## 4.2 Backupping ssh config file
echo "Archiving default 'sshd_config'..."
mkdir /config
mkdir /config/backup
cp /etc/ssh/sshd_config ${CONFIG_BACKUP}/ssh/sshd_config.bak

## 4.3 Dev Options and setting up service
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "Enabling sshd..."
systemctl enable sshd
echo "Starting sshd service"...
systemctl start sshd.service

## 4.4 Read IP Address
ip4short=$(hostname -i)
echo "SSH can be connected through: $ip4short:22"

## 4.5 Formatting of Partitions

## 4.5
exit 0

