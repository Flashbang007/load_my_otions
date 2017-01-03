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
cd ~


lc_error() {
#This exits the last command, if it Produces an Error
    ERRORCODE=$(echo $?)

    if [[ $ERRORCODE -ne 0 ]]; then

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
        lc_error

        if [[ -f $BRC ]]
        then
            mv $BRC $BRCB
        fi
        lc_error

        wget $FORCE$BASHRCPATH
        lc_error

        if [[ -f $BRCB ]]
        then
                rm $BRCB
        fi
        lc_error
        source $BRC
        ;;

    -v|-vf|-fv)#Get .vimrc
        lc_error

        if [[ -f $VIMRC ]]
        then
                mv $VIMRC $VIMRCB
        fi

        wget $FORCE$VIMRCPATH
        lc_error

        if [[ -f $VIMRCB ]]
        then
                rm $VIMRCB
        fi
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
