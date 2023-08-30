#!/bin/bash

ROOTF=$(dirname $(realpath $0))
source $ROOTF/log.sh

function tools_check(){
    which picocom >> /dev/null
    if [ ! $? ];then
        echo "------------------------------------------------------------"
        echo "  please execute the following commands to install picocom  "
        echo "  sudo apt update                                           "
        echo "  sudo apt install picocom                                  "
        echo "------------------------------------------------------------"
    fi 
}

function 4G_module_check(){
    if [ ! -e /sys/class/net/usb0 ];then
        error_log "Unable to find 4G device"
        exit 1
    fi
    SIM_card_check
}

function com() {
    local port="/dev/ttyUSB2"
    local timeout=1000
    local picocom_bin=picocom

    $picocom_bin -qrix $timeout --omap lfcr,igncr $port
}   

function SIM_card_check(){
    local resp1=$(echo 'at+cpin?' | com $port)
    if [[ ${resp1} == *"READY"* ]]   
    then
        info_log "at+cpin OK"
    else
        error_log "SIM card not found"
        return 1
    fi
}

function net_test(){
    for interface in $@
    do
        ping_test $interface
    done 
}

function ping_test(){
    ping baidu.com -I $1 -c 1 > /dev/null 2>&1 
    if [ $? -ne 0 ];then
        error_log "$1 can't connect to baidu.com"
    fi
}

main(){
    if [ ! -e $log ];then
        echo "There is no log.txt, add log.txt"
        touch $log
    fi

    echo "Checking devices"
    4G_module_check
    tools_check
    interface=$(ls /sys/class/net/ | grep -v lo |grep -v can0)
    info_log "Network interfaces:\n $interface"

    while true;do
        sleep 3
        net_test ${interface}
    done
}

main
