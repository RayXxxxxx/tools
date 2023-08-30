#!/bin/bash

ROOTF=$(dirname $(realpath $0))
SEND=$ROOTF/serial_send
CAN=$ROOTF/can_send

source $ROOTF/log.sh

function serial_send(){
    timeout 10 $SEND $1 > /dev/null
    if [ $? -eq 1 ];then
        error_log "$1 Init port failed" 
    elif [ $? -eq 2 ];then
        error_log "$1 Open port failed" 
    elif [ $? -eq 3 ];then
        error_log "$1 Data verification failed"
    elif [ $? -eq 124 ];then
        error_log "$1 Timeout"
    else
        echo "$1 Successfully sent data"
    fi
}

function can_send(){
    timeout 10 $CAN > /dev/null
    if [ $? -eq 1 ];then
        error_log "CAN Send data error" 
    elif [ $? -eq 2 ];then
        error_log "CAN Data verification failed" 
    elif [ $? -eq 124 ];then
        error_log "CAN Timeout"
    else
        echo "CAN Successfully sent data"
    fi
}


main(){
    while true;do
        info_log $(vcgencmd measure_temp)
        serial_send /dev/ttyAMA2
        serial_send /dev/ttyAMA3
        serial_send /dev/ttyAMA1
        serial_send /dev/ttyAMA4
        serial_send /dev/serial0
        can_send
        sleep 10
    done
}

main
