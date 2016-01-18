#!/bin/bash

SOURCE_FILE='README.md'
ZERONET_REPO='https://github.com/HelloZeroNet/ZeroNet.git'
ZERONET_COMMIT='675bd462556c541d65e2d95f91f899146a373aad'
UPSTREAM_DIR=~/.zeronet_package
CURR_DIR=$(pwd)

if [ $1 ]; then
    ZERONET_COMMIT="$1"
fi

if [ ! -d gnu-social ]; then
    git clone $ZERONET_REPO $UPSTREAM_DIR
else
    cd $UPSTREAM_DIR
    git stash
    git checkout master
    git pull
    cd $CURR_DIR
fi

cd $UPSTREAM_DIR
git stash
git checkout $ZERONET_COMMIT -b $ZERONET_COMMIT
cd $CURR_DIR

cp -r $UPSTREAM_DIR/* src/

# update git
git add src

echo "Synced with upstream to commit $ZERONET_COMMIT"
exit 0
