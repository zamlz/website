#!/bin/sh

# Parse command line arguments
SOURCE_DIR=$1
DEPLOY_DIR=$2

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Missing command line arguments"
    exit 1
fi

echo "=========================================="
echo "Source Directory: ${SOURCE_DIR}"
echo "Deploy Directory: ${DEPLOY_DIR}"
echo "=========================================="
rm -rfv ${DEPLOY_DIR}
echo "=========================================="

# Push a specific type of file to the deploy directory
# $1 file type
deploy () {
   
    for src in $(find ${SOURCE_DIR} -type f -name "${1}" | grep -v '/\.'); do

        sedarg="-r s/^${SOURCE_DIR}//"
        destination="${DEPLOY_DIR}$(echo ${src} | eval sed "$sedarg")"

        mkdir -v -p $(dirname ${destination})
        cp ${src} ${destination}
        echo "${src} -> ${destination}"

    done
}

deploy "*.html"

