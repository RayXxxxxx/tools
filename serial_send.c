#include <wiringSerial.h>
#include <wiringPi.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

#define boudrace 115200

char*   get_ch(int fd, char* ch);
void    send_ch(int fd, char* ch);
char*    switch_devr(char* choose);


int main(int argc, char *argv[]){

    time_t now;
    struct tm *timenow;
    char *devrr=NULL;

    devrr = argv[1];

    time(&now);
    timenow = localtime(&now);

    printf("Serial %s: ",devrr);
	int fd;
    int avail;
    char ch[50];
    printf("Local time is %s\n",asctime(timenow));
    strcpy(ch,asctime(timenow));

    char rech[50];
 
    int j = 0;
	if(wiringPiSetupGpio()<0)
		return 1;
	if((fd=serialOpen(devrr, boudrace))<0)
		return 2;
    // printf("start send\n");
    
    send_ch(fd, ch);
    get_ch(fd, rech);

    if(strcmp(ch,rech))
    {
        serialClose(fd);
        return 3;
    }
    
    serialClose(fd);
	return 0;
}


char* get_ch(int fd, char* ch)
{
    int j = 0;

    while(serialDataAvail(fd) < 1);
    
    while(serialDataAvail(fd) > 0)
    {
        delay(10);
        ch[j] = serialGetchar(fd);
        j++;
    }
    ch[j]='\0';
    return ch;
}

void send_ch(int fd, char* ch)
{
    serialPrintf(fd, ch);
}
