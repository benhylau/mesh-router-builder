Package builder for mesh routers
================================

This project will create .deb packages of the following mesh routers:

    * cjdns
    * yggdrasil-go

A debian/stretch64 Vagrant machine is used to build binaries for **armhf**
and **amd64**, then package them into corresponding .deb packages.

I hope to add support for the Vagrant machine to build full Debian images
of [mesh-orange](https://github.com/tomeshnet/mesh-orange) with each mesh
router .deb pre-installed, so the .img artifacts can be directly flashed
onto an SD card to create mesh routers on ARM devices. Other routers that
may (or may not) fit in this list include libp2p and the GNUnet transport
subsystem.

Usage
-----

Ensure you have [Vagrant](https://www.vagrantup.com) installed, then clone
this repository and run:

    $ vagrant up
    $ vagrant ssh

In the Vagrant machine, call `make`. When the build completes, call `exit`
and find the built artifacts in the **output** directory of your host. Then
you may destroy the Vagrant machine with `vagrant destroy`.

macOS High Sierra
------------------

There is a known bug in macOS High Sierra that prevents Synced Folders
from working. You will have to get the built artifacts manually before
destroying the Vagrant machine:

    $ vagrant ssh-config > vagrant-ssh.conf
    $ mkdir output-macos
    $ scp -F vagrant-ssh.conf mesh-router-builder:/vagrant/output/* output-macos/
