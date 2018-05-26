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
postlist=$(find ${POST_DIR} -type f -name "*.html")

for post in ${postlist}; do
    echo $post
done
