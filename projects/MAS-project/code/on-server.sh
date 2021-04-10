#!/usr/bin/bash

LIGHT_GREEN='\033[1;32m'
LIGHT_CYAN='\033[1;36m'
NC='\033[0m'

function help {
  echo -e "${LIGHT_CYAN}SYNOPSIS${NC}"
  echo -e "\t./on-server [${LIGHT_GREEN}user${NC}] [${LIGHT_GREEN}-h${NC}]\n"
  echo -e "${LIGHT_CYAN}DESCRIPTION${NC}"
  echo -e "\tThe filesystem is not allowed as same-origin by the browser:"
  echo -e "\t- Launches project on a python3 HTTP localhost server,"
  echo -e "\t  to prevent CORS error on the json fetch request.\n"
  echo -e "\t\t${LIGHT_GREEN}user${NC} - Non root active user, only if root.\n"
  echo -e "\t\t${LIGHT_GREEN}-h${NC} - Display help.\n"
  exit
}

if [ "$1" = "-h" -o -z "$1" -a $EUID -eq 0 ]; then
  help
elif [ $EUID -ne 0 ]; then
  xdg-open http://localhost:8000/index.html
else
  sudo -u "$1" xdg-open http://localhost:8000/index.html
fi
python3 -m http.server

exit
