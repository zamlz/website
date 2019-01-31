#!/bin/sh

RESDIR=".resume"
GIT="git -C $RESDIR"

if [ ! -d "$RESDIR"]; then
    git clone https://github.com/zamlz/resume.git $RESDIR
fi

# Ensure its up to date
echo "Updating resume"
$GIT pull
echo "Building resume"
make -C $RESDIR

