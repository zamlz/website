# __  __       _         __ _ _      
#|  \/  | __ _| | _____ / _(_) | ___ 
#| |\/| |/ _` | |/ / _ \ |_| | |/ _ \
#| |  | | (_| |   <  __/  _| | |  __/
#|_|  |_|\__,_|_|\_\___|_| |_|_|\___|
#                                    

########################################################

MAKEARGS	= --no-print-directory -C

HOME		= index.html
BLOG		= blog/index.html
ABOUT		= about/index.html

########################################################

# Specify all the files that we build here
all: ${HOME} ${BLOG} ${ABOUT}

# Describe the recipe for index.html
${HOME}: ${HOME:.html=.md}
	pandoc ${HOME:.html=.md} -f markdown  -t html -s -o ${HOME}

# Describe the recipe for blog.html
${BLOG}: ${BLOG:.html=.md}
	pandoc ${BLOG:.html=.md} -f markdown  -t html -s -o ${BLOG}

# Describe the recipe for about.html
${ABOUT}: ${ABOUT:.html=.md}
	pandoc ${ABOUT:.html=.md} -f markdown  -t html -s -o ${ABOUT}

clean:
	- rm ${HOME}
	- rm ${ABOUT}
	- rm ${BLOG}
