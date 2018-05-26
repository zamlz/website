# __  __       _         __ _ _      
#|  \/  | __ _| | _____ / _(_) | ___ 
#| |\/| |/ _` | |/ / _ \ |_| | |/ _ \
#| |  | | (_| |   <  __/  _| | |  __/
#|_|  |_|\__,_|_|\_\___|_| |_|_|\___|
#                                    

########################################################

README   	= README
MKFILE   	= Makefile

SOURCE_DIR	= source
DEPLOY_DIR	= /var/www/html/zamlz.org/public_html

MAKEARGS	= --no-print-directory -C

########################################################

# Builds the html files
build:
	+${MAKE} ${MAKEARGS} ${SOURCE_DIR}

# Clean up after the builder
clean:
	+${MAKE} ${MAKEARGS} ${SOURCE_DIR} clean

# Deploy to the server folder
deploy:
	- sudo rm -rf ${DEPLOY_DIR}
	sudo ./push ${SOURCE_DIR} ${DEPLOY_DIR}

########################################################

