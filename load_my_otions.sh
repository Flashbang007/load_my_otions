#!/bin/bash

BRC=~/.bashrc
BRCB=~/.bashrc.bak
BASHRCPATH=https://raw.githubusercontent.com/Flashbang007/bashrc/master/.bashrc

VIMRC=~/.vimrc
VIMRCB=~/.vimrc.bak
VIMRCPATH=https://raw.githubusercontent.com/Flashbang007/vimrc/master/.vimrc

#Colors#
CRESTORE='\033[0m'
CRED='\033[00;31m'
###################
if [[ ! -f $BRC ]]
then
    touch $BRC
fi
if [[ ! -f $VIMRC ]]
then
    touch $VIMRC
fi

lc_error() {
#This exits the last command, if it Produces an Error
    ERRORCODE=$(echo $?)

    if [ $ERRORCODE -ne 0 ]; then

        echo -e "Error Number $CRED- $ERRORCODE -$CRESTORE"
        exit $ERRORCODE
    fi
}
print_help() {
        echo -e "
Usage: load_my_otions.sh [OPTION]

    -h                  shows this help
    -f                  force Download by adding --no-check-certificate to wget
    -b                  update .bashrc
    -v                  update .vimrc
"
}

###################

if [[ $1 =~ f ]]; then
    FORCE="--no-check-certificate "
fi

case "$1" in

    -b|-bf|-fb)#Get .bashrc
        mv $BRC $BRCB
        lc_error

        wget $FORCE$BASHRCPATH
        lc_error

        source ~/.bashrc
        lc_error

        rm $BRCB
        lc_error
        ;;

    -v|-vf|-fv)#Get .vimrc
        mv $VIMRC $VIMRCB
        lc_error

        wget $FORCE$VIMRCPATH
        lc_error

        rm $VIMRCB
        lc_error
        ;;
    -h)
        print_help
        exit 0
        ;;
    *)
        print_help
        exit 1

esac

exit 0
