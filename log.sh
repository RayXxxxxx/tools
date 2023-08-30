#!/bin/bash

com1=/dev/ttyAMA2
com2=/dev/ttyAMA3
com3=/dev/ttyAMA1
com4=/dev/ttyAMA4
rs232=/dev/serial0
can=can0
log=./log.txt

function error_log(){
    local time=$(date "+%Y/%m/%d %H:%M:%S")
    echo -e "[$time] Error $@" | tee -a $log
}

function info_log(){
    local time=$(date "+%Y/%m/%d %H:%M:%S")
    echo -e "[$time] Info $@" | tee -a $log
}

function tmp_log(){
    local time=$(date "+%Y/%m/%d %H:%M:%S")
    echo -e "[$time] Running: $@"
}