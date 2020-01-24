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

# find posts and sort them
postlist=$(find ${POST_DIR} -type f -name "*.html" | sort -r)
echo ""

CUR_YEAR=""

for post in ${postlist}; do

    url="/blog/${post}"

    full_date=$(echo ${post} | sed -e 's/\// /g' | awk '{print $2}')
    year=$(echo ${full_date} | grep -o "^[^-]*")

    if [ "$year" != "$CUR_YEAR" ]; then
        echo "<h3>$year</h3>"
        CUR_YEAR=$year
    fi

    name=$(grep 'class="name"' ${post} | sed -e 's/class="title"//g')
    name=$(echo ${name} | pandoc -f html -t commonmark)
    name=$(echo ${name} | sed -e 's/# //')

    echo " - [${name}](${url}) [$full_date]"
done
