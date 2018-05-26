# __  __       _         __ _ _      
#|  \/  | __ _| | _____ / _(_) | ___ 
#| |\/| |/ _` | |/ / _ \ |_| | |/ _ \
#| |  | | (_| |   <  __/  _| | |  __/
#|_|  |_|\__,_|_|\_\___|_| |_|_|\___|
#                                    

########################################################

README   	= README
MKFILE   	= Makefile

SOURCE		= source
DEPLOYDIR	= /var/www/html/

MAKEARGS	= --no-print-directory -C

########################################################

# Builds the html files
build:
	+${MAKE} ${MAKEARGS} ${SOURCE}

# Clean up after the builder
clean:
	+${MAKE} ${MAKEARGS} ${SOURCE} clean
