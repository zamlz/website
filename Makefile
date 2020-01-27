# __  __       _         __ _ _
#|  \/  | __ _| | _____ / _(_) | ___
#| |\/| |/ _` | |/ / _ \ |_| | |/ _ \
#| |  | | (_| |   <  __/  _| | |  __/
#|_|  |_|\__,_|_|\_\___|_| |_|_|\___|
#

###############################################################################

# GENERAL MAKE VARIABLES

SOURCE_DIR	= ./source
INSTALL_DIR	= /var/www/html/zamlz.org/public_html

ADDRESS		= 0.0.0.0
PORT		= 8000

RESUME_DIR	= .__resume__
RESUME_URL	= https://gitlab.com/zamlz/resume.git

PANDOC      = pandoc -f markdown -t html

###############################################################################

# Builds the html files
build: resume
	@echo "================== BUILDING WEBSITE =================="
	+${MAKE} website

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

###############################################################################

# WEBSITE MAKE VARIABLES

# Directories
BLOG_DIR = ${SOURCE_DIR}/blog
BLOG_POST_DIR = ${BLOG_DIR}/posts

# Markdown Files
MAIN_PAGE = ${SOURCE_DIR}/index.md
BLOG_TEMP = ${BLOG_DIR}/index.md
TIME_PAGE = source/blog/chronological.md
TAGS_PAGE = source/blog/tags.md
BLOG_PAGE = $(shell find ${BLOG_POST_DIR} -type f -name "*.md")

# HTML Files
MAIN_HTML = ${MAIN_PAGE:.md=.html}
TIME_HTML = ${TIME_PAGE:.md=.html}
TAGS_HTML = ${TAGS_PAGE:.md=.html}
BLOG_HTML = ${BLOG_PAGE:.md=.html}

###############################################################################

website: ${MAIN_HTML} # ${CHRONO_HTML} ${TAGS_HTML}

%.html: %.md
	${PANDOC} $< -o $@

# Clean up after the builder
clean:
	echo test
