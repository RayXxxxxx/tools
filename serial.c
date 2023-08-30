#include <stdio.h>   /* Standard input/output definitions */
#include <string.h>  /* String function definitions */
#include <unistd.h>  /* UNIX standard function definitions */
#include <fcntl.h>   /* File control definitions */
#include <errno.h>   /* Error number definitions */
#include <termios.h> /* POSIX terminal control definitions */

int open_port(const char *dev)
{
	int fd; /* File descriptor for the port */

	fd = open(*dev, O_RDWR | O_NOCTTY | O_NDELAY);
 	if (fd == -1) {
	 	/*
	    * Could not open the port.
	    */
	    perror("open_port: Unable to open $s\n", *dev);
    } else {
    	fcntl(fd, F_SETFL, 0);
    }

  	return (fd);
}

int main() {
    
    return 0;
}
