 #!/bin/bash
 
 
####################################################
#////    Colorize and add text parameters     /////#
####################################################
	
blk=$(tput setaf 0) # black
red=$(tput setaf 1) # red
grn=$(tput setaf 2) # green
ylw=$(tput setaf 3) # yellow
blu=$(tput setaf 4) # blue
mga=$(tput setaf 5) # magenta
cya=$(tput setaf 6) # cyan
wht=$(tput setaf 7) # white
#
txtbld=$(tput bold) # Bold
bldblk=${txtbld}$(tput setaf 0) # black
bldred=${txtbld}$(tput setaf 1) # red
bldgrn=${txtbld}$(tput setaf 2) # green
bldylw=${txtbld}$(tput setaf 3) # yellow
bldblu=${txtbld}$(tput setaf 4) # blue
bldmga=${txtbld}$(tput setaf 5) # magenta
bldcya=${txtbld}$(tput setaf 6) # cyan
bldwht=${txtbld}$(tput setaf 7) # white
txtrst=$(tput sgr0) # Reset

USBDEV1=`blkid -L CBOOT | head -n 1`
USBDEV=${USBDEV1%1}
USBMNT=`grep -w ${USBDEV1} /proc/mounts | cut -d ' ' -f 2`


####################################################
#////              Qemu                       /////#
####################################################

echo "Boot in UEFI or BIOS mode?"
select yn in "UEFI" "BIOS"; do
    case $yn in
        UEFI ) BOOTMODE="-bios /usr/share/ovmf/x64/OVMF_CODE.fd"; break;;
        BIOS ) BOOTMODE="" ; break;;
    esac
done

sudo qemu-system-x86_64 -machine type=pc,accel=kvm -enable-kvm -cpu host -smp cores=2  \
-m size=2G  \
${BOOTMODE}  \
-hda ${USBDEV}  \
-vga std  \
-k de  \
