#!/bin/bash

SOURCE_FILE='README.md'
ZERONET_REPO='https://github.com/HelloZeroNet/ZeroNet.git'
ZERONET_COMMIT='e9d2cdfd37c135cf741992580512f0ea763c53a5'
UPSTREAM_DIR=~/.zeronet_package
CURR_DIR=$(pwd)

if [ $1 ]; then
    ZERONET_COMMIT='e9d2cdfd37c135cf741992580512f0ea763c53a5'
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

# remove excess licences
rm src/LICENSE
rm src/src/lib/PySocks/LICENSE
rm src/src/lib/pybitcointools/LICENSE
rm src/src/lib/subtl/LICENCE
rm src/src/lib/pyasn1/LICENSE
rm src/src/lib/pyelliptic/LICENSE
rm src/src/lib/rsa/LICENSE

# Make scripts executable
executables=(
	src/lib/pyelliptic/arithmetic.py
	src/lib/pybitcointools/bitcoin/stealth.py
	src/lib/pybitcointools/bitcoin/blocks.py
	src/lib/pybitcointools/bitcoin/py3specials.py
	src/lib/pybitcointools/bitcoin/py2specials.py
	src/lib/PySocks/socks.py
	src/lib/pyelliptic/__init__.py
	src/lib/pybitcointools/bitcoin/composite.py
	src/lib/PySocks/__init__.py
	src/lib/pybitcointools/bitcoin/deterministic.py
	src/lib/pybitcointools/bitcoin/ripemd.py
	update.py
	src/lib/pybitcointools/bitcoin/__init__.py
)
for i in "${executables[@]}"
do
	filename=src/$i
	chmod +x "$filename"
    if ! grep -q "#!/usr/bin/python" $filename; then
		sed -i '1s|^|#!/usr/bin/python\n|' $filename
	fi
done

# Delete empty file
rm src/src/lib/PySocks/__init__.py

# Delete an offending binary
rm -rf src/src/lib/PySocks/test

# Remore an errant test
rm src/src/Test/BenchmarkSsl.py

# Hack to ensure that the file access port is opened
# This is because zeronet normally relies on an internet site
# to do this, but on a purely local mesh the internet isn't available
sed -i 's|fileserver_port = 0|fileserver_port = config.fileserver_port\n            sys.modules["main"].file_server.port_opened = True|g' src/src/Site/Site.py

echo "Synced with upstream to commit $ZERONET_COMMIT"
exit 0
