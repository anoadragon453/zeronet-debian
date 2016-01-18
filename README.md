ZeroNet package for Debian
==========================

Current build
-------------

Version: 0.3.5

Release: 1

Upstream commit: 2121612a72e05d2fbe86cb707cae33687d4e72f1

Updating
--------

If you need to update the package to a new version then edit the above version, release and commit and also *debian/changelog* then run:

    ./debian.sh

Creating the package
--------------------

Run the debian.sh script to generate the package.

    sudo apt-get install build-essential lintian debconf
    git clone https://github.com/bashrc/zeronet-debian
    cd zeronet-debian
    ./debian.sh

The package can be tested with:

    lintian ../zeronet_*.deb

Installation
------------

    sudo apt-get install tor
    sudo dpkg -i zeronet_*.deb

By default zeronet will be installed to **/etc/share/zeronet**.
