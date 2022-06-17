#!/bin/sh

if [ ! -d ./data ]; then
    echo "You must mount a data directory!"
    echo "This is new as of Version 2 -- please check the FAQ: https://github.com/demize/quesoqueue_docker/wiki/V2-Migration-FAQ"
    exit 1
fi

if [ ! -f ./settings.json ]; then
    ./settings.sh
fi

if [ -d ./config ]; then
    echo "Old config directory mounted. This is necessary for migration, but could cause issues after migration."
    echo "Please stop the container and remove the mount for the config directory."
    echo "Please see the FAQ for more information: https://github.com/demize/quesoqueue_docker/wiki/V2-Migration-FAQ"
    if [ ! -f ./config/waitingUsers.txt ]; then
        echo "[]" > ./config/waitingUsers.txt
    fi
    if [ ! -f ./config/userWaitTime.txt ]; then
        echo "[]" > ./config/userWaitTime.txt
    fi
    if [ ! -f ./config/queso.save ]; then
        echo "[]" > ./config/queso.save
    fi
    ln -s ./config/waitingUsers.txt .
    ln -s ./config/userWaitTime.txt .
    ln -s ./config/queso.save .
fi

if [ ! -f ./data/customCodes.json ]; then
    if [ -f ./config/customCodes.json ]; then
        cp ./config/customCodes.json ./data/
    else
        echo '[["ROMhack","R0M-HAK-LVL"]]' > ./data/customCodes.json
    fi
fi

ln -s ./data/customCodes.json ./customCodes.json
npm start run
