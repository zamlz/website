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

MDHTML		= 	-f markdown -t html -s \
				--template=.template.html \
				--include-before=.header.html \
				--include-after=.footer.html

########################################################

# Specify all the files that we build here
all: ${PAGES} ${BLOG}

# How to build all the html files
%.html : %.md
	pandoc $< ${MDHTML} -o $@

# Build the blog html file
${BLOG}: blogupdate ${BLOGMD}
	pandoc ${BLOGMD} ${MDHTML} -o ${BLOG}

# Update the blog markdown file
blogupdate:
	+${MAKE} ${MAKEARGS} ${BLOG_DIR}

# Remove the html files
clean:
	+${MAKE} ${MAKEARGS} ${BLOG_DIR} clean
	- rm ${PAGES} ${BLOG}
