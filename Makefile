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

ADDRESS		= 0.0.0.0
PORT		= 8000

RESUME_DIR	= .__resume__
RESUME_URL	= https://gitlab.com/zamlz/resume.git

########################################################

build: resume website

# Builds the html files
website:
	@echo "================== BUILDING WEBSITE =================="
	+${MAKE} ${MAKEARGS} ${SOURCE_DIR}

# Clean up after the builder
clean:
	+${MAKE} ${MAKEARGS} ${SOURCE_DIR} clean

# This builds the resume file.
resume:
	@echo "================== BUILDING RESUME ==================="
	if [ -d "${RESUME_DIR}" ]; \
	then git -C ${RESUME_DIR} pull; \
	else git clone ${RESUME_URL} ${RESUME_DIR}; fi;
	+${MAKE} -C ${RESUME_DIR}

# This will unencrypt the drafts
unlock:
	@echo "================== UNLOCKING DRAFTS =================="
	./scripts/crypt.sh unlock ${SOURCE_DIR}

# This will encrypt the drafts
lock: clean
	@echo "=================== LOCKING DRAFTS ==================="
	./scripts/crypt.sh lock ${SOURCE_DIR}

# Test the system locally
test:
	@echo "================ STARTING TEST SERVER ================"
	./scripts/server.sh ${SOURCE_DIR} ${ADDRESS} ${PORT}

# Install to the server folder (notice the lock)
install: clean lock build
	@echo "================= INSTALLING WEBSITE ================="
	./scripts/install.sh ${SOURCE_DIR} ${INSTALL_DIR}

build-forever:
	@echo "================ CONTINUOUS BUILDING ================="
	while true; do \
		make website; \
		sleep 1; \
	done;

########################################################

