ZeroNet package for Debian
==========================

Current build
-------------

Version: 0.3.5

Release: 1

Upstream commit: e9d2cdfd37c135cf741992580512f0ea763c53a5

Updating
--------

If you need to update the package to a new version then edit the above version/commit then run:

    make sync

Also edit debian/changelog with the latest version at the top. The email address within the changelog must exactly correspond to your gpg key.

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
