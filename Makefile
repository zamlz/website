# __  __       _         __ _ _      
#|  \/  | __ _| | _____ / _(_) | ___ 
#| |\/| |/ _` | |/ / _ \ |_| | |/ _ \
#| |  | | (_| |   <  __/  _| | |  __/
#|_|  |_|\__,_|_|\_\___|_| |_|_|\___|
#                                    

########################################################

README   	= README
MKFILE   	= Makefile
MAKEARGS	= -C

SOURCE_DIR	= source
INSTALL_DIR	= /var/www/html/zamlz.org/public_html

ADDRESS		= 127.0.0.1
PORT		= 8000

########################################################

# Builds the html files
build:
	+${MAKE} ${MAKEARGS} ${SOURCE_DIR}

# Clean up after the builder
clean:
	+${MAKE} ${MAKEARGS} ${SOURCE_DIR} clean

# Test the system locally
test: build
	./server.sh ${SOURCE_DIR} ${ADDRESS} ${PORT}

# Install to the server folder
install: 
	./install.sh ${SOURCE_DIR} ${INSTALL_DIR}

########################################################

