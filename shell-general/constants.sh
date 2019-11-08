# Keymap

keymap = 'sg-latin1'
keymap-path='/usr/share/kbd/keymaps/i386/qwertz/sg-latin1.map.gz'

## Load Swiss German Keyboard
loadkeys ${keymap}
## timedatectl set-ntp true

### List devices
fdisk -l

## m
## l  List
## n  New
## p  Primary
## 1  Chose number
## t  Type
## L  List types
## 82 [SWAP]
## y  Yes

## n  New
## p  Primary
## 2  Chose number
## t  Type
## L  List types
## 83 [Linux]    Four /mnt
## y   Yes

## w  Write partitions to disk


# Partition device
## /mnt /[SWAT]
fdisk /dev/sda
### Change partition type from main menu
#### l - - load disk layout from sfdisk script filke
##### [SWAP]  -  [82 - Linux swapt / So]
##### [/MOUNT] -  [83 - Linux]

##### $ w  => write
##### $ 'The partition table has been altere.'
##### $ 'Callin ioctl() to re-read partition table.'
##### $ 'Syncing disks.'


### mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/sda2
#### swap to /dev/sda1
### inititalize SWAP
mkswap /dev/sda1
swapon /dev/sda1

## Mount /mnt filesystem
mount /dev/sda2 /mnt

#### !!!!!!!!!! In between check the man page
man fdisk
man mkfs
man mkswap
man mkswapon

## xSelect the mirrors
#2. Installation
## 2.1 Select the mirros
### 2.1.1 Check the mirrors
vi /etc/pacman-d/mirrorlist
#### 2.1.1.1 Grep the file
grep -i 'switzerland' /etc/pacman.d/mirrorlist
#### 2.1.1.2 Check the following 1 Line after match:
grep -A1 -i 'switzerland' /etc/pacman.d/mirrorlist
#### 2.1.1.3 Most prioritized mirror very up
#Server = https://pkg.adfinis-sygroup.ch/archlinux/$repo/os/$arch

### 2.2 Install essential packages
# Use the pacstrap script to install the base package, the linux
#   and Linux kernel and firmware for common hardware.

 pacstrap /mnt base linux linux-firmware
## https://www.archlinux.org/mirrorlist/?country=CH&protocol=http&protocol=https&ip_version=4
