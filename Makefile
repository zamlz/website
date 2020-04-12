# __  __       _         __ _ _
#|  \/  | __ _| | _____ / _(_) | ___
#| |\/| |/ _` | |/ / _ \ |_| | |/ _ \
#| |  | | (_| |   <  __/  _| | |  __/
#|_|  |_|\__,_|_|\_\___|_| |_|_|\___|
#

###############################################################################

# GENERAL MAKE VARIABLES

SOURCE_DIR  = source
DATA_DIR    = ${SOURCE_DIR}/data
INSTALL_DIR	= /var/www/zamlz.org

ADDRESS     = 0.0.0.0
PORT        = 8000

###############################################################################

# Builds the html files
build:
	@echo "================== BUILDING RESUME ==================="
	+${MAKE} resume
	@echo "================== BUILDING WEBSITE =================="
	+${MAKE} website

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

# Build dependencies
PANDOC      = pandoc -f markdown -t html
PD_TEMPLATE = source/.template.html

# Directories
BLOG_DIR = ${SOURCE_DIR}/blog
BLOG_POST_DIR = ${BLOG_DIR}/posts

# Markdown Files
MAIN_MD = ${SOURCE_DIR}/index.md
BLOG_MD = ${BLOG_DIR}/index.md
TIME_MD = source/blog/posts.md
TAGS_MD = source/blog/tags.md
POST_MD = $(shell find ${BLOG_POST_DIR} -type f -name "*.md")

# HTML Files
MAIN_HTML = ${MAIN_MD:.md=.html}
TIME_HTML = ${TIME_MD:.md=.html}
TAGS_HTML = ${TAGS_MD:.md=.html}
POST_HTML = ${POST_MD:.md=.html}

###############################################################################

# Builds all components of the website
website: ${MAIN_HTML} ${TIME_HTML} ${TAGS_HTML} ${POST_HTML}

# Blog posts page ordered by time
${TIME_MD}: ${BLOG_MD} ${POST_MD}
	./scripts/make_blog.py --time $^ > $@

# Blog posts page grouped by tags
${TAGS_MD}: ${BLOG_MD} ${POST_MD}
	./scripts/make_blog.py --tags $^ > $@

# General build procedure for html files
%.html: %.md ${PD_TEMPLATE}
	${PANDOC} $< -o $@ --template=${PD_TEMPLATE}

###############################################################################

# RESUME MAKE VARIABLES

RESUME_DIR  = .__resume__
RESUME_URL  = https://git.zamlz.org/resume.git

RESUME_FILE = amlesh_resume.pdf
RESUME_SRC  = ${RESUME_DIR}/${RESUME_FILE}
RESUME_TAR  = ${DATA_DIR}/${RESUME_FILE}

CV_FILE     = amlesh_curriculum_vitae.pdf
CV_SRC      = ${RESUME_DIR}/${CV_FILE}
CV_TAR      = ${DATA_DIR}/${CV_FILE}

###############################################################################

# This builds the resume file.
resume: resume_update ${RESUME_TAR} ${CV_TAR}

# Build resume using original source files
resume_update:
	if [ -d "${RESUME_DIR}" ]; \
	then GIT_SSL_NO_VERIFY=true git -C ${RESUME_DIR} pull; \
	else GIT_SSL_NO_VERIFY=true git clone ${RESUME_URL} ${RESUME_DIR}; fi;
	+${MAKE} -C ${RESUME_DIR}

${RESUME_TAR}: ${RESUME_SRC}
	cp ${RESUME_SRC} ${RESUME_TAR}

${CV_TAR}: ${CV_SRC}
	cp ${CV_SRC} ${CV_TAR}

###############################################################################

# Clean up after the builder
clean:
	-rm ${RESUME_TAR}
	-rm ${CV_TAR}
	-rm ${MAIN_HTML}
	-rm ${POST_HTML}
	-rm ${TIME_HTML}
	-rm ${TAGS_HTML}
	-rm ${TIME_MD}
	-rm ${TAGS_MD}

###############################################################################

.PHONY = ${RESUME_SRC} ${CV_SRC} website resume clean build \
         lock unlock test install build-forever

