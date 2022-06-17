TZ=${TZ:-UTC}
export TZ
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP
cd /home/container || exit 1
CYAN='\033[0;36m'
RESET_COLOR='\033[0m'
printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0mpython --version\n"
python --version
echo -e "${CYAN}STARTUP /home/container: /start.sh ${RESET_COLOR}"
clear
printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0m%s\n" "$PARSED"
eval '/start.sh'