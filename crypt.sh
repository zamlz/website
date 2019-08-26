#!/bin/sh

SOURCE_DIR=$2
GPG_ID=$(cat ./.gpg-id)

lock() {
    echo "Locking draft files..."
    for draft in $(find ${SOURCE_DIR} -type f -name "*.draft.md"); do
        OUTFILE=$(echo ${draft} | sed -e 's/.draft.md/.gpg/g')
        gpg --output ${OUTFILE} --encrypt -r ${GPG_ID} ${draft}
        rm ${draft}
    done
}

unlock() {
    echo "Unlocking draft files..."
    for draft in $(find ${SOURCE_DIR} -type f -name "*.gpg"); do
        OUTFILE=$(echo ${draft} | sed -e 's/.gpg/.draft.md/g')
        gpg --output ${OUTFILE} --decrypt ${draft}
    done
}

if [ "$1" = "lock" ]; then
    lock
elif [ "$1" = "unlock" ]; then
    unlock
else
    find ${SOURCE_DIR} -type f -name "*.gpg"
fi
