###############################################################################
# __  __       _         __ _ _
#|  \/  | __ _| | _____ / _(_) | ___
#| |\/| |/ _` | |/ / _ \ |_| | |/ _ \
#| |  | | (_| |   <  __/  _| | |  __/
#|_|  |_|\__,_|_|\_\___|_| |_|_|\___|
#
###############################################################################

# GENERAL MAKE VARIABLES

SOURCE_DIR = ./source
MAIN_DIR   = ${SOURCE_DIR}/main
BLOG_DIR   = ${SOURCE_DIR}/blog

INSTALL_DIR      = /var/www
MAIN_INSTALL_DIR = ${INSTALL_DIR}/zamlz.org
BLOG_INSTALL_DIR = ${INSTALL_DIR}/blog.zamlz.org

ADDRESS     = 0.0.0.0
PORT        = 8000

###############################################################################

# Builds the html files
build:
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
test-main: resume main
	@echo "================ STARTING TEST SERVER ================"
	./scripts/server.sh ${MAIN_DIR} ${ADDRESS} 8000

test-blog: blog
	@echo "================ STARTING TEST SERVER ================"
	./scripts/server.sh ${BLOG_DIR} ${ADDRESS} 8000

# Install to the server folder (notice the lock)
install:
	@echo "================= INSTALLING WEBSITE ================="
	@./scripts/install.sh ${MAIN_DIR} ${MAIN_INSTALL_DIR}
	@./scripts/install.sh ${BLOG_DIR} ${BLOG_INSTALL_DIR}

###############################################################################

# Build dependencies
PANDOC_ORG = pandoc -f org -t html
PANDOC_MD = pandoc -f md -t html
PD_TEMPLATE = ./resources/template.html
LIST_GENERATOR = ./scripts/make_list.py

###############################################################################

# Builds all components of the website
website: resume main blog

# General build procedure for html files
%.html: %.org ${PD_TEMPLATE}
	${PANDOC_ORG} $< -o $@ --template=${PD_TEMPLATE}

%.html: %.md ${PD_TEMPLATE}
	${PANDOC_MD} $< -o $@ --template=${PD_TEMPLATE}

###############################################################################

# Markdown Files for Main
MAIN_ORG = ${MAIN_DIR}/index.org
MAIN_HTML = ${MAIN_ORG:.org=.html}

###############################################################################

# Build script for main website is pretty straightforward
main: ${MAIN_HTML}

main-clean:
	-rm ${MAIN_HTML}

###############################################################################

# Markdown Files for Blog
BLOG_TEMPLATE_MD = ${BLOG_DIR}/template.md
TIME_MD = ${BLOG_DIR}/posts.md
TAGS_MD = ${BLOG_DIR}/tags.md

# HTML Files
TIME_HTML = ${TIME_MD:.md=.html}
TAGS_HTML = ${TAGS_MD:.md=.html}
POST_HTML = ${POST_MD:.md=.html}

# Create the collection of blog posts
BLOG_POST_DIR = ${BLOG_DIR}/posts
POST_MD = $(shell find ${BLOG_POST_DIR} -type f -name "*.md")

###############################################################################

blog: ${TIME_HTML} ${TAGS_HTML} ${POST_HTML}

# Blog posts page ordered by time
${TIME_MD}: ${BLOG_TEMPLATE_MD} ${POST_MD} ${LIST_GENERATOR}
	cat ${BLOG_TEMPLATE_MD} > $@
	${LIST_GENERATOR} --time ${BLOG_DIR} ${POST_MD} >> $@

# Blog posts page grouped by tags
${TAGS_MD}: ${BLOG_TEMPLATE_MD} ${POST_MD}
	cat ${BLOG_TEMPLATE_MD} > $@
	${LIST_GENERATOR} --tags ${BLOG_DIR} ${POST_MD} >> $@

blog-clean:
	-rm ${POST_HTML}
	-rm ${TIME_HTML}
	-rm ${TAGS_HTML}
	-rm ${TIME_MD}
	-rm ${TAGS_MD}

###############################################################################

# Julia Plot variables
JULIA_PLOTS      = $(shell find -L ${SOURCE_DIR} -type f -name "*.mkplt.jl")
JULIA_PLOTS_HTML = ${JULIA_PLOTS:.mkplt.jl=.mkplt.html}

###############################################################################

julia-plots: ${JULIA_PLOTS_HTML}

%.mkplt.html : %.mkplt.jl
	julia $< $@

julia-clean:
	-rm ${JULIA_PLOTS_HTML}

###############################################################################

# RESUME MAKE VARIABLES

RESUME_DIR  = .__resume__
RESUME_URL  = https://github.com/zamlz/resume.git

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
	@echo "================== BUILDING RESUME ==================="
	if [ -d "${RESUME_DIR}" ]; \
	then git -C ${RESUME_DIR} pull; \
	else git clone ${RESUME_URL} ${RESUME_DIR}; fi;
	+${MAKE} -C ${RESUME_DIR}

${RESUME_TAR}: ${RESUME_SRC}
	cp ${RESUME_SRC} ${RESUME_TAR}

${CV_TAR}: ${CV_SRC}
	cp ${CV_SRC} ${CV_TAR}

resume-clean:
	-rm ${RESUME_TAR}
	-rm ${CV_TAR}

###############################################################################

.PHONY = ${RESUME_SRC} ${CV_SRC} website main blog resume clean build \
		 lock unlock test install build-forever julia-plots main-clean \
		 blog-clean resume-clean julia-clean

###############################################################################

# Clean up after the builder
clean: main-clean blog-clean resume-clean julia-clean
