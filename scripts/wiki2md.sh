#!/usr/bin/env sh

# A simple script to preprocess the wiki markdown files. There are certain
# things that are useful to have in vimwiki but are not ideal in actual
# markdown.


cat $1 | perl -ne 's/(\[.+\])\(((?!http)[^)]+)\)/\1(\2.html)/g; print;'

