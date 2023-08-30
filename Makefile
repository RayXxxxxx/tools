CC:=gcc
LIB:= -lwiringPi

serial_send : serial_send.c
	${CC} -o $@ $< ${LIB} 

can_send : can_send.c
	${CC} -o $@ $<

.PHONY : all
all : serial_send can_send