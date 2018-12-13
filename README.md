Package and image builder for mesh routers
==========================================

This project will create .deb packages of the following mesh routers:

    * cjdns
    * yggdrasil-go

A debian/stretch64 Vagrant machine is used to build binaries for **armhf** and
**amd64**, then package them into corresponding .deb packages. Other routers that
may (or may not) fit on this list include _libp2p_ and the _GNUnet transport
subsystem_.

The Vagrant machine also builds Debian-based system images of
[mesh-orange](https://github.com/tomeshnet/mesh-orange) with each mesh router
.deb pre-installed, so the .img artifacts can be directly flashed onto SD cards
to create mesh routers on ARM devices. The following single-board computers are
supported by mesh-orange:

    * raspberrypi2
    * raspberrypi3
    * sun4i-a10-cubieboard
    * sun7i-a20-bananapi
    * sun8i-h2-plus-orangepi-zero
    * sun8i-h3-orangepi-lite
    * sun8i-v3s-licheepi-zero

Note that only **raspberrypi2**, **raspberrypi3**, and
**sun8i-h2-plus-orangepi-zero** are enabled by default. Uncomment boards in
`~/mesh-orange-images/Makefile` after ssh-ing to your Vagrant machine
to enable the other boards you want.

Usage
-----

Ensure you have [Vagrant](https://www.vagrantup.com) installed, then clone
this repository and run:

    $ vagrant up
    $ vagrant ssh

In the Vagrant machine, call `make` (optionally, `make PROFILE=custom-profile`).
When the build completes, call `exit` and find the built artifacts in the
**output** directory of your host:

    ./output/debian-packages/yggdrasil-go_0.1-1_amd64.deb
                             yggdrasil-go_0.1-1_armhf.deb
                             ...
             mesh-orange-images/raspberrypi2.img
                                sun8i-h2-plus-orangepi-zero.img
                                ...

Then you may destroy the Vagrant machine with `vagrant destroy`.

Publish to GitHub Releases
--------------------------

If you wish to publish the built artifacts to _GitHub Releases_, create a file
named **.github_publish** in the project root before `vagrant up` with the
following information:

    GITHUB_USERNAME=<username>
    GITHUB_REPOSITORY=<repository-name>
    GITHUB_TOKEN=<github-api-token>
    GITHUB_RELEASE_VERSION=<release-version>

The _GitHub API Token_ should have `public_repo` scope for public repositories
and `repo` scope for private repositories. The `GITHUB_RELEASE_VERSION` will be
used as `debian_revision` for .deb packages, appended to filenames of .img system
images, and used to tag the release. Your file should look something like this:

    GITHUB_USERNAME=benhylau
    GITHUB_REPOSITORY=mesh-router-builder
    GITHUB_TOKEN=0123456789abcdef0123456789abcdef01234567
    GITHUB_RELEASE_VERSION=0.1

After `make` completes, you can call `make publish` and all artifacts will be
published to _Github Releases_ in your repository.

macOS High Sierra
-----------------

There is a known bug in macOS High Sierra that prevents Synced Folders from
working. You will have to get the built artifacts manually before destroying the
Vagrant machine:

    $ vagrant ssh-config > vagrant-ssh.conf
    $ mkdir output-macos
    $ scp -r -F vagrant-ssh.conf mesh-router-builder:/vagrant/output/* output-macos/
