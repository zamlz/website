#!/bin/sh

# Script takes three arguments
# $1 - Source directory
# $2 - Address
# $3 - Port Number
SOURCE=$1
ADDRESS=$2
PORT=$3

# Go into the source directory
cd ${SOURCE}

# Only tested with python 3 so far, but I think v2 should also work
if [ "3" = "$(python -c 'import sys; print(sys.version_info[0])')" ]; then
    python -m http.server --bind ${ADDRESS} ${PORT};
else
    python -m SimpleHTTPServer --bind ${ADDRESS} ${PORT};
fi

