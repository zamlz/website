#!/bin/sh

# Parse command line arguments
SOURCE_DIR=$1
INSTALL_DIR=$2

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Missing command line arguments"
    exit 1
fi

echo "======================================================"
echo "Source Directory  : ${SOURCE_DIR}"
echo "Install Directory : ${INSTALL_DIR}"
echo "======================================================"
echo "rm -rfv ${INSTALL_DIR}"
rm -rfv ${INSTALL_DIR}/*
echo "======================================================"

# Push a specific type of file to the install directory
# $1 file type
install () {

    if [ -z "$(find ${SOURCE_DIR} -type f -name "${1}" | grep -v '/\.')" ]; then
        echo "Warning: No files of type '${1}' are available. Make sure you run 'make build'";
    fi

    for src in $(find ${SOURCE_DIR} -type f -name "${1}" | grep -v '/\.'); do

        sedarg="-r s/^${SOURCE_DIR}//"
        destination="${INSTALL_DIR}$(echo ${src} | eval sed "$sedarg")"

        mkdir -v -p $(dirname ${destination})
        cp ${src} ${destination}
        echo "${src} -> ${destination}"

    done
}

install "*.html"
install "*.css"
install "*.png"
install "*.jpg"
install "*.pdf"
install "favicon.ico"

# There must be a better hack for this.
# The whole goal of this is to have a styles directory for the /blog
# document root since it will be a subdomain of its own.
INSTALL_DIR=$2/blog
install "*.css"
