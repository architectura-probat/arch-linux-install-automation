# Environment variables
# hostname="${1:?"Missing hostname"}"

####### ENVIRONMENT VARIABLES READ ####################
## Read Hostname
echo -n "Hostname: "
read hostname
: "${hostname:?"Missing hostname"}"

## Read Password
echo -n "Password: "  # [-n]: Append newline
read -s password  # [-s]: Do not echo keystrokes
echo
echo -n "Repeat Password: "
read -s password2
echo
[[ "$password" == "$password2" ]] || ( echo "Passwords did not match"; exit 1; )

## Partiitoning
devicelist=$(lsblk -dplnx size -o name,size | grep -Ev "boot|rpmb|loop" | tac)
device=$(dialog --stdout --menu "Select installation disk" 0 0 0 ${devicelist}) || exit 1


