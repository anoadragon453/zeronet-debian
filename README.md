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

If the package builds successfully then any lintian warnings or errors will be shown.

Installation
------------

    sudo apt-get install tor python python-msgpack python-gevent python-pip bittornado
    pip install msgpack-python --upgrade
    sudo dpkg -i zeronet_*.deb

By default zeronet will be installed to **/etc/share/zeronet**.

To enable the daemons:

    sudo systemctl enable zeronet
    sudo systemctl start zeronet

Or for the mesh networking version:

    sudo systemctl enable tracker
    sudo systemctl enable zeronet-mesh
    sudo systemctl start tracker
    sudo systemctl start zeronet-mesh

You should then be able to navigate to http://127.0.0.1:43110/
