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

POST_DIR	= ./posts

POSTSMD		= $(shell find ${POST_DIR} -type f -name "*.md")
POSTSRAW	= ${POSTSMD:.md=.raw}

PRDIR		= $(shell echo ${POSTSRAW} | sed -e 's/_/\//g')
POSTSHTML	= ${PRDIR:.raw=.html}

MDHTML		= -f markdown -t html -s

########################################################

# Specify all the files that we build here
all: rawbuild ${POSTSHTML} ${BLOGMD}

${BLOGMD}: ${HEADMD}
	cp -v head.md index.md

# How to build the real html files
%.html: %.raw
	@mv -v $< $@
	

# Build the raw files
rawbuild: ${POSTSRAW}
	for rawpost in ${POSTSRAW}; do \
		newraw=$$(echo $$rawpost | sed -e s'/_/\//g'); \
		mkdir -p $$(dirname $$newraw); \
		cp -v $$rawpost $$newraw; \
	done; 

# How to build all the raw html files
%.raw : %.md
	pandoc $< ${MDHTML} -o $@

# Remove the html files
clean:
	-rm -v ${POSTSRAW}
	-rm -v ${BLOGMD}
