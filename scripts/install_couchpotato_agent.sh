#!/bin/bash

## Initializing
if [ -f _functions.sh ]; then
   source _functions.sh
elif [ -f ../_functions.sh ]; then
    source ../_functions.sh
else
   echo "Config file functions.sh does not exist"
   exit 1
fi

if [ -f config.sh ]; then
   source config.sh
elif [ -f ../config.sh ]; then
	source ../config.sh
else
   echo "Config file config.sh does not exist"
   exit 1
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
main() {
  INSTALL_AGENT="local.couchpotato.couchpotato.plist"

	if ! file_exists '/Library/LaunchAgents/$INSTALL_AGENT'; then
    ask_for_sudo
    sudo cp ../config/launchctl/$INSTALL_AGENT /Library/LaunchAgents/
    #print_result $? 'Copy PlexPy launch agent'

    sudo chown root:wheel /Library/LaunchAgents/$INSTALL_AGENT
    sudo chmod 644 /Library/LaunchAgents/$INSTALL_AGENT

    launchctl load /Library/LaunchAgents/$INSTALL_AGENT
  fi

	print_result $? 'LaunchAgent CouchPotato'
}

main