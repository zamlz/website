#!/usr/bin/env sh

# A simple script to preprocess the wiki markdown files. There are certain
# things that are useful to have in vimwiki but are not ideal in actual
# markdown.

# perl script cleans up links found within wiki files. While the work in
# vimwiki, once converted to html, the links are broken. If the link doesn't
# begin with http, we are pretty sure its a wiki link so we make sure to
# append .html to the link

# Using sed, we must convert vimwiki checkboxes to valid markdown checkboxes
# so it can be properly converted by pandoc into html. My vim config configures
# checkboxes as such:
#   let g:vimwiki_listsyms = ' ○◐●✓'

cat $1 \
    | perl -ne 's/(\[.+\])\(((?!http)[^)]+)\)/\1(\2.html)/g; print;' \
    | sed -e 's/\[○\]/\[ \]/g' \
          -e 's/\[◐\]/\[ \]/g' \
          -e 's/\[●\]/\[ \]/g' \
          -e 's/\[✓\]/\[X\]/g'


