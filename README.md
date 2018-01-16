Package and image builder for mesh routers
==========================================

This project will create .deb packages of the following mesh routers:

    * cjdns
    * yggdrasil-go

A debian/stretch64 Vagrant machine is used to build binaries for **armhf** and
**amd64**, then package them into corresponding .deb packages. Other routers that
may (or may not) fit on this list include libp2p and the GNUnet transport
subsystem.

The Vagrant machine also builds Debian-based system images of
[mesh-orange](https://github.com/tomeshnet/mesh-orange) with each mesh router
.deb pre-installed, so the .img artifacts can be directly flashed onto SD cards
to create mesh routers on ARM devices. The following single-board computers are
supported by mesh-orange:

    * raspberrypi2
    * sun4i-a10-cubieboard
    * sun7i-a20-bananapi
    * sun8i-h2-plus-orangepi-zero
    * sun8i-h3-orangepi-lite
    * sun8i-v3s-licheepi-zero

Note that only **raspberrypi2** and **sun8i-h2-plus-orangepi-zero** are enabled
by default. Uncomment boards in `/home/vagrant/mesh-orange-images/Makefile` after
ssh-ing to your Vagrant machine to enable the other boards you want.

Status
------

* cjdns .deb packages are not being generated
* mesh-orange images do not have the mesh router .deb pre-installed

Usage
-----

Ensure you have [Vagrant](https://www.vagrantup.com) installed, then clone
this repository and run:

    $ vagrant up
    $ vagrant ssh

In the Vagrant machine, call `make`. When the build completes, call `exit` and
find the built artifacts in the **output** directory of your host:

    ./output/debian-packages/yggdrasil-go_0.1-1_amd64.deb
                             yggdrasil-go_0.1-1_armhf.deb
                             ...
             mesh-orange-images/raspberrypi2.img
                                sun8i-h2-plus-orangepi-zero.img
                                ...

Then you may destroy the Vagrant machine with `vagrant destroy`.

macOS High Sierra
------------------

There is a known bug in macOS High Sierra that prevents Synced Folders from
working. You will have to get the built artifacts manually before destroying the
Vagrant machine:

    $ vagrant ssh-config > vagrant-ssh.conf
    $ mkdir output-macos
    $ scp -r -F vagrant-ssh.conf mesh-router-builder:/vagrant/output/* output-macos/
