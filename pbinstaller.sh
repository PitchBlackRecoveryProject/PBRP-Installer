#!/bin/bash
#A script to flash PitchBlack Recovery from linux
#sloppy20181108 v1.1
blue='\033[0;34m'
cyan='\033[0;36m'
green='\e[0;32m'
yellow='\033[0;33m'
nocol='\033[0m'
purple='\e[0;35m'
white='\e[0;37m'
RED='\033[0;31m'
NC='\033[0m'
echo -e "${blue} __________   __    __              __     ${purple} __________   __                       __     "
echo -e "${blue} \______   \ |__| _/  |_    ____   |  |__  ${purple} \______   \ |  |   _____      ____   |  | __ "
echo -e "${blue}  |     ___/ |  | \   __\ _/ ___\  |  |  \ ${purple}  |    |  _/ |  |   \__  \   _/ ___\  |  |/ / "
echo -e "${blue}  |    |     |  |  |  |   \  \___  |   Y  \ ${purple} |    |   \ |  |__  / __ \_ \  \___  |    <  "
echo -e "${blue}  |____|     |__|  |__|    \___  > |___|  /${purple}  |______  / |____/ (____  /  \___  > |__|_ \ "
echo -e "${blue}                               \/       \/ ${purple}         \/              \/       \/       \/ "
echo -e "${green}                     __________    "
echo -e "                     \______   \ ____   ____  _______  __ ___________ ___.__.            "
echo -e "                      |       _// __ \_/ ___\/  _ \  \/ // __ \_  __ <   |  |            "
echo -e "                      |    |   \  ___/\  \__(  <_> )   /\  ___/|  | \/\___  |            "
echo -e "                      |____|_  /\___  >\___  >____/ \_/  \___  >__|   / ____|            "
echo -e "                             \/     \/     \/                \/       \/         ${NC}\n "
echo                                                                     
printf "${RED}                                 Welcome to PBRP installer ${NC}\n"
echo
printf "${RED}Checking for required packages... ${NC}\n"

chkadb=$(which adb 2>/dev/null)
chkfastboot=$(which fastboot 2>/dev/null)
chkunzip=$(which unzip 2>/dev/null)
if [[ ( "$chkadb" != "/usr/bin/adb") || ( "$chkfastboot" != "/usr/bin/fastboot") || ( "$chkunzip" != "/usr/bin/unzip") ]]; then
    echo
    printf "${RED}Not all required packages are installed...\n\nInstalling required packages...  ${NC}\n"
    echo
    printf "${cyan}Getting info about on linux disto..${NC}\n"
    echo
    grep -R ID_LIKE= /etc/os-release
    echo
        if ID_LIKE=arch; then
            printf "${cyan}Arch based distro detected...\n\nInstalling arch stuff...\n${NC}\n"
            sudo pacman -S android-tools unzip --noconfirm
        elif ID_LIKE=debian; then
            printf "${cyan}Debian based distro detected...\n\nInstalling debian stuff...\n${NC}\n"
            sudo apt-get install adb fastboot unzip -y
        fi
else true;
fi
echo
printf "${RED}All required packages are installed!${NC}\n"
echo
printf "${RED}Press enter if you are in bootloader mode... ${NC}\n"
read
printf "${RED}Getting stuff ready... ${NC}\n"
unzip PitchBlack*.zip > /dev/null
rm -R META-INF
echo
printf "${RED}Flashing PBRP... ${NC}\n"
fastboot flash recovery TWRP/*.img 2>/dev/null
echo
printf "${RED}Booting into PBRP... ${NC}\n"
fastboot boot TWRP/*.img 2>/dev/null
rm -R TWRP
echo
printf "${RED}Press enter when PBRP fully boots... ${NC}\n"
read
printf "${RED}Pushing tools... ${NC}\n"
adb shell rm -r /sdcard/PBRP/tools 2>/dev/null
adb push PBRP /sdcard >/dev/null
echo -e
printf "${RED}Rebooting into PBRP... ${NC}\n"
echo -e
adb reboot recovery
sleep 10
rm -R PBRP
printf "${RED}ALL DONE! ${NC}\n"
echo -e
