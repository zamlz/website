#!/bin/sh

# Output a markdown listing of the blogposts
# Takes a single argument.
#   1) post directory
POST_DIR=$1

if [ -z $1 ]; then
    echo "Missing post directory!"
    exit 1
fi

# Continue onward

# find luckilu prints output in the order I need them in
postlist=$(find ${POST_DIR} -type f -name "*.html")
echo ""

for post in ${postlist}; do

    url="${post}"

    day=$(echo ${post} | sed -e 's/\// /g' | awk '{print $2}')

    name=$(grep 'class="title"' ${post} | sed -e 's/class="title"//g')
    name=$(echo ${name} | pandoc -f html -t commonmark)
    name=$(echo ${name} | sed -e 's/# //')

    echo "${day} - [${name}](${url})"
    echo ""
done
