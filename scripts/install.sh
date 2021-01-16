#!/usr/bin/env sh

SOURCE_DIR=$1
INSTALL_DIR=$2

echo "Source Directory  : ${SOURCE_DIR}"
echo "Install Directory : ${INSTALL_DIR}"
echo "======================================================"

rm -rfv ${INSTALL_DIR}

echo "======================================================"

rsync -a --include '*/' --include '*.html' --exclude '*' \
    ${SOURCE_DIR}/ ${INSTALL_DIR}/
find -L ${SOURCE_DIR} -name '*.html'

rsync -a --include '*/' --include '*.pdf' --exclude '*' \
    ${SOURCE_DIR}/ ${INSTALL_DIR}/
find -L ${SOURCE_DIR} -name '*.pdf'

rsync -a --include '*/' --include '*.gif' --exclude '*' \
    ${SOURCE_DIR}/ ${INSTALL_DIR}/
find -L ${SOURCE_DIR} -name '*.gif'

rsync -a --include '*/' --include '*.png' --exclude '*' \
    ${SOURCE_DIR}/ ${INSTALL_DIR}/
find -L ${SOURCE_DIR} -name '*.png'

rsync -a --include '*/' --include '*.png' --exclude '*' \
    resources ${INSTALL_DIR}/
find -L resources -name '*.png'

rsync -a --include '*/' --include '*.css' --exclude '*' \
    resources ${INSTALL_DIR}/
find -L resources -name '*.css'

cp resources/favicon.ico ${INSTALL_DIR}/

echo "======================================================"
