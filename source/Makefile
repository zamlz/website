# __  __       _         __ _ _      
#|  \/  | __ _| | _____ / _(_) | ___ 
#| |\/| |/ _` | |/ / _ \ |_| | |/ _ \
#| |  | | (_| |   <  __/  _| | |  __/
#|_|  |_|\__,_|_|\_\___|_| |_|_|\___|
#                                    

########################################################

MAKEARGS	= -C

PAGES		= index.html       \
			  blog/index.html  \
			  about/index.html

BLOG_DIR	= blog

MDHTML		= -f markdown -t html -s --template=.template.html

########################################################

# Specify all the files that we build here
all: blogbuild ${PAGES}

# Build the blog/index.md file
blogbuild :
	+${MAKE} ${MAKEARGS} ${BLOG_DIR}

# How to build all the html files
%.html : %.md
	pandoc $< ${MDHTML} -o $@

# Remove the html files
clean:
	+${MAKE} ${MAKEARGS} ${BLOG_DIR} clean
	- rm ${PAGES}
