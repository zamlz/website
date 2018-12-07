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

# This will unencrypt the drafts
unlock:
	./crypt.sh unlock ${SOURCE_DIR}

# This will encrypt the drafts
lock: clean
	./crypt.sh lock ${SOURCE_DIR}

# Test the system locally
test:
	./server.sh ${SOURCE_DIR} ${ADDRESS} ${PORT}

# Install to the server folder (notice the lock)
install: clean lock build
	./install.sh ${SOURCE_DIR} ${INSTALL_DIR}

########################################################

