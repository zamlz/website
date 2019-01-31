# __  __       _         __ _ _
#|  \/  | __ _| | _____ / _(_) | ___
#| |\/| |/ _` | |/ / _ \ |_| | |/ _ \
#| |  | | (_| |   <  __/  _| | |  __/
#|_|  |_|\__,_|_|\_\___|_| |_|_|\___|
#

########################################################

MAKEARGS	= -C

PAGES		= index.html \
			  contact/index.html

BLOG		= blog/index.html
BLOGMD		= blog/bloglist.tmp

BLOG_DIR	= blog

TEMPLATE	= .template.html
HEADER		= .header.html
FOOTER		= .footer.html

MDHTML		= 	-f markdown -t html -s \
				--template=${TEMPLATE} \
				--include-before=${HEADER} \
				--include-after=${FOOTER} \
				--highlight-style=breezedark

RESUME_FILE	= resume_amlesh_sivanantham.pdf
RESUME_SRC	= ../.__resume__/amlesh_curriculum_vitae.pdf

########################################################

# Specify all the files that we build here
all: ${PAGES} ${BLOG} ${RESUME_FILE}

# How to build all the html files
%.html : %.md ${TEMPLATE} ${HEADER} ${FOOTER}
	pandoc $< ${MDHTML} -o $@

# Build the blog html file
${BLOG}: blogupdate ${BLOGMD} ${TEMPLATE} ${HEADER} ${FOOTER}
	pandoc ${BLOGMD} ${MDHTML} -o ${BLOG}

# Update the blog markdown file
blogupdate:
	+${MAKE} ${MAKEARGS} ${BLOG_DIR}

${RESUME_FILE}: ${RESUME_SRC}
	cp ${RESUME_SRC} ${RESUME_FILE}

# Remove the html files and any other files
clean:
	+${MAKE} ${MAKEARGS} ${BLOG_DIR} clean
	- rm ${PAGES} ${BLOG} ${RESUME_FILE}
