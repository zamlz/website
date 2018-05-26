# __  __       _         __ _ _      
#|  \/  | __ _| | _____ / _(_) | ___ 
#| |\/| |/ _` | |/ / _ \ |_| | |/ _ \
#| |  | | (_| |   <  __/  _| | |  __/
#|_|  |_|\__,_|_|\_\___|_| |_|_|\___|
#                                    

########################################################

MAKEARGS	= --no-print-directory -C

INDEX		= index.html
BLOG		= blog.html
ABOUT		= about.html

########################################################

# Specify all the files that we build here
all: ${INDEX} ${BLOG} ${ABOUT}

# Describe the recipe for index.html
${INDEX}: ${INDEX:.html=.md}
	pandoc ${INDEX:.html=.md} -f markdown  -t html -s -o ${INDEX}

# Describe the recipe for blog.html
${BLOG}: ${BLOG:.html=.md}
	pandoc ${BLOG:.html=.md} -f markdown  -t html -s -o ${BLOG}

# Describe the recipe for about.html
${ABOUT}: ${ABOUT:.html=.md}
	pandoc ${ABOUT:.html=.md} -f markdown  -t html -s -o ${ABOUT}

clean:
	- rm ${INDEX}
	- rm ${ABOUT}
	- rm ${BLOG}
