#!/bin/sh

if [ ! -f configured.txt ]; then
    ./settings.sh
fi

if [ -d ./config ]; then
    if [ ! -f ./config/waitingUsers.txt ]; then
        echo "[]" > ./config/waitingUsers.txt
    fi
    if [ ! -f ./config/userWaitTime.txt ]; then
        echo "[]" > ./config/userWaitTime.txt
    fi
    if [ ! -f ./config/customCodes.json ]; then
        echo '[["ROMhack","R0M-HAK-LVL"]]' > ./config/customCodes.json
    fi
    if [ ! -f ./config/queso.save ]; then
        echo "[]" > ./config/queso.save
    fi
    ln -s ./config/* .
    npm start run
else
    echo "You must mount a config directory!"
    exit 1
fi