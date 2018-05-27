# __  __       _         __ _ _      
#|  \/  | __ _| | _____ / _(_) | ___ 
#| |\/| |/ _` | |/ / _ \ |_| | |/ _ \
#| |  | | (_| |   <  __/  _| | |  __/
#|_|  |_|\__,_|_|\_\___|_| |_|_|\___|
#                                    

########################################################

MAKEARGS	= -C

BLOGMD		= index.md
HEADMD		= head.md

# The underscore here in the post directory is a hack
# that lets me create a new post directory because of
# the way sed is used below
POST_DIR	= posts

POSTSMD		= $(shell find ${POST_DIR} -type f -name "*.md")
POSTSRAW	= ${POSTSMD:.md=.tmp}

PRDIR		= $(shell echo ${POSTSRAW} | sed -e 's/_/\//g')
POSTSHTML	= ${PRDIR:.tmp=.html}

BUILDER		= ./build.sh
MDHTML		= 	-f markdown -t html -s \
				--template=../.template.html \
				--include-before=../.header.html \
				--include-after=../.footer.html

########################################################

${BLOGMD}: tmpbuild ${POSTSHTML} ${HEADMD} ${BUILDER}
	cp -v head.md index.md
	${BUILDER} ${POST_DIR} >> index.md

# How to build the real html files
%.html: %.tmp
	@mv -v $< $@
	

# Build the tmp files
tmpbuild: ${POSTSRAW}
	for tmppost in ${POSTSRAW}; do \
		newtmp=$$(echo $$tmppost | sed -e s'/_/\//g'); \
		mkdir -p $$(dirname $$newtmp); \
		cp -v $$tmppost $$newtmp; \
	done; 

# How to build all the tmp html files
%.tmp : %.md
	pandoc $< ${MDHTML} -o $@

# Remove the html files
clean:
	for pdir in $$(ls -F ${POST_DIR} | grep "/"); do \
		rm -rfv ${POST_DIR}/$$pdir; \
	done;
	-rm -v ${POSTSRAW}
	-rm -v ${BLOGMD}
