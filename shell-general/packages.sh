


# https://www.archlinux.org/packages/community/any/terminus-font/
pacman -Sy terminus-font
setfont ter-122b

# Enable SSH
## 1.Enable password for current user
passwd
## 2.Configure SSH to permit Root Login
'PermitRootLogin yes' >> /etc/ssh/sshd_config
## 3. Enable SSH
systemctl enable sshd
# setup SSH Service
systemctl start sshd.service


cp ~/.bashrc ~/.bashrc.bak
cp /etc/bash.bashrc /etc/bash.bashrc.back
touch /etc/DIR_COLORS

vim /etc/bash.bashrc

## Set Environment variables for MAN coloring
export LESS_TERMCAP_mb=$'\E[01;31m' \
          LESS_TERMCAP_md=$'\E[01;38;5;74m' \
          LESS_TERMCAP_me=$'\E[0m' \
          LESS_TERMCAP_se=$'\E[0m' \
          LESS_TERMCAP_so=$'\E[38;5;246m' \
          LESS_TERMCAP_ue=$'\E[0m' \
          LESS_TERMCAP_us=$'\E[04;38;5;146m'
