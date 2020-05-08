# __  __       _         __ _ _
#|  \/  | __ _| | _____ / _(_) | ___
#| |\/| |/ _` | |/ / _ \ |_| | |/ _ \
#| |  | | (_| |   <  __/  _| | |  __/
#|_|  |_|\__,_|_|\_\___|_| |_|_|\___|
#

###############################################################################

# GENERAL MAKE VARIABLES

SOURCE_DIR  = ./source
MAIN_DIR    = ${SOURCE_DIR}/main
BLOG_DIR    = ${SOURCE_DIR}/blog
NOTES_DIR   = ${SOURCE_DIR}/notes

INSTALL_DIR       = /var/www
MAIN_INSTALL_DIR  = ${INSTALL_DIR}/zamlz.org
BLOG_INSTALL_DIR  = ${INSTALL_DIR}/blog.zamlz.org
NOTES_INSTALL_DIR = ${INSTALL_DIR}/notes.zamlz.org

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
	./scripts/server.sh ${SOURCE_DIR} ${ADDRESS} 8000

# Install to the server folder (notice the lock)
install:
	@echo "================= INSTALLING WEBSITE ================="
	@echo "Source Directory  : ${MAIN_DIR}"
	@echo "Install Directory : ${MAIN_INSTALL_DIR}"
	@echo "======================================================"
	-rm -rfv ${MAIN_INSTALL_DIR}
	@echo "======================================================"
	rsync -a --include '*/' --include '*.html' --exclude '*' ${MAIN_DIR}/ ${MAIN_INSTALL_DIR}/
	@find -L ${MAIN_DIR} -name '*.html'
	rsync -a --include '*/' --include '*.pdf' --exclude '*' ${MAIN_DIR}/ ${MAIN_INSTALL_DIR}/
	@find -L ${MAIN_DIR} -name '*.pdf'
	rsync -a --include '*/' --include '*.gif' --exclude '*' ${MAIN_DIR}/ ${MAIN_INSTALL_DIR}/
	@find -L ${MAIN_DIR} -name '*.gif'
	rsync -a --include '*/' --include '*.css' --exclude '*' resources ${MAIN_INSTALL_DIR}/
	@find -L ${MAIN_DIR} -name '*.css'
	cp resources/favicon.ico ${MAIN_INSTALL_DIR}/
	@echo "======================================================"
	@echo "Source Directory  : ${BLOG_DIR}"
	@echo "Install Directory : ${BLOG_INSTALL_DIR}"
	@echo "======================================================"
	-rm -rfv ${BLOG_INSTALL_DIR}
	@echo "======================================================"
	rsync -a --include '*/' --include '*.html' --exclude '*' ${BLOG_DIR}/ ${BLOG_INSTALL_DIR}/
	@find -L ${BLOG_DIR} -name '*.html'
	rsync -a --include '*/' --include '*.css' --exclude '*' resources ${BLOG_INSTALL_DIR}/
	@find -L ${MAIN_DIR} -name '*.css'
	cp resources/favicon.ico ${BLOG_INSTALL_DIR}/
	@echo "======================================================"
	@echo "Source Directory  : ${NOTES_DIR}"
	@echo "Install Directory : ${NOTES_INSTALL_DIR}"
	@echo "======================================================"
	-rm -rfv ${NOTES_INSTALL_DIR}
	@echo "======================================================"
	-rsync -a --include '*/' --include '*.html' --exclude '*' ${NOTES_DIR}/ ${NOTES_INSTALL_DIR}/
	-@find -L ${NOTES_DIR} -name '*.html'
	-rsync -a --include '*/' --include '*.png' --exclude '*' ${NOTES_DIR}/ ${NOTES_INSTALL_DIR}/
	-@find -L ${NOTES_DIR} -name '*.png'
	-rsync -a --include '*/' --include '*.css' --exclude '*' resources ${NOTES_INSTALL_DIR}/
	-@find -L ${MAIN_DIR} -name '*.css'
	cp resources/favicon.ico ${NOTES_INSTALL_DIR}/
	@echo "======================================================"

###############################################################################

# WEBSITE MAKE VARIABLES

# Build dependencies
PANDOC      = pandoc -f markdown -t html
PD_TEMPLATE = ./resources/template.html

# Directories
BLOG_POST_DIR = ${BLOG_DIR}/posts

# Markdown Files for Main
MAIN_MD = ${MAIN_DIR}/index.md

# Markdown Files for Blog
BLOG_MD = ${BLOG_DIR}/index.md
TIME_MD = ${BLOG_DIR}/posts.md
TAGS_MD = ${BLOG_DIR}/tags.md
POST_MD = $(shell find ${BLOG_POST_DIR} -type f -name "*.md")

# HTML Files
MAIN_HTML = ${MAIN_MD:.md=.html}
TIME_HTML = ${TIME_MD:.md=.html}
TAGS_HTML = ${TAGS_MD:.md=.html}
POST_HTML = ${POST_MD:.md=.html}

###############################################################################

# Builds all components of the website
website: julia-plots main blog notes

# General build procedure for html files
%.html: %.md ${PD_TEMPLATE}
	${PANDOC} $< -o $@ --template=${PD_TEMPLATE}

###############################################################################

# Build script for main website is pretty straightforward
main: ${MAIN_HTML}

###############################################################################

blog: ${TIME_HTML} ${TAGS_HTML} ${POST_HTML}

# Blog posts page ordered by time
${TIME_MD}: ${BLOG_MD} ${POST_MD}
	./scripts/make_blog.py --time $^ > $@

# Blog posts page grouped by tags
${TAGS_MD}: ${BLOG_MD} ${POST_MD}
	./scripts/make_blog.py --tags $^ > $@

###############################################################################

# RESUME MAKE VARIABLES

RESUME_DIR  = .__resume__
RESUME_URL  = https://git.zamlz.org/resume.git

RESUME_FILE = amlesh_resume.pdf
RESUME_SRC  = ${RESUME_DIR}/${RESUME_FILE}
RESUME_TAR  = ${MAIN_DIR}/data/${RESUME_FILE}

CV_FILE     = amlesh_curriculum_vitae.pdf
CV_SRC      = ${RESUME_DIR}/${CV_FILE}
CV_TAR      = ${MAIN_DIR}/data/${CV_FILE}

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

# NOTES VARIABLES (note, you manually add this repo and update your manually)
NOTES_MD    = $(shell find -L ${NOTES_DIR} -type f -name "*.md")
NOTES_HTML  = ${NOTES_MD:.md=.html}

###############################################################################

notes: ${NOTES_HTML}

###############################################################################

# Julia Plot variables
JULIA_PLOTS      = $(shell find -L ${SOURCE_DIR} -type f -name "*.mkplt.jl")
JULIA_PLOTS_HTML = ${JULIA_PLOTS:.mkplt.jl=.mkplt.html}
HTML_POSTPROCESS = ./scripts/htmlplot_preprocess.py

###############################################################################

julia-plots: ${JULIA_PLOTS_HTML}

%.mkplt.html : %.mkplt.jl
	julia $< $@

###############################################################################

.PHONY = ${RESUME_SRC} ${CV_SRC} website main blog notes resume clean build \
         lock unlock test install build-forever julia-plots

###############################################################################

# Clean up after the builder
clean:
	@echo "================ CLEANING BUILD FILES ================="
	-rm ${RESUME_TAR}
	-rm ${CV_TAR}
	-rm ${MAIN_HTML}
	-rm ${POST_HTML}
	-rm ${NOTES_HTML}
	-rm ${JULIA_PLOTS_HTML}
	-rm ${TIME_HTML}
	-rm ${TAGS_HTML}
	-rm ${TIME_MD}
	-rm ${TAGS_MD}
