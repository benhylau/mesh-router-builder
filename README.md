Package and image builder for mesh routers
==========================================

This project will create .deb packages of the following mesh routers:

    * cjdns
    * yggdrasil

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
    * raspberrypi3 (for 3b and 3b+)
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

You can use this builder in three environments:

| OS       | Self-managed VM | Vagrant-managed VM                                                   | Travis CI |
|:---------|:---------------:|:--------------------------------------------------------------------:|:---------:|
|**Debian**| `stretch`       | [debian/stretch64](https://app.vagrantup.com/debian/boxes/stretch64) |           |
|**Ubuntu**| `xenial`        | [ubuntu/xenial64](https://app.vagrantup.com/ubuntu/boxes/xenial64)   | [![Build Status](https://travis-ci.org/benhylau/mesh-router-builder.svg?branch=master)](https://travis-ci.org/benhylau/mesh-router-builder) [![GitHub release](https://img.shields.io/github/release/benhylau/mesh-router-builder.svg)](https://github.com/benhylau/mesh-router-builder/releases) |

### Self-managed VM

It is highly recommended that you spin up a fresh **Debian Stretch** or **Ubuntu Xenial**
VM to use this builder. Using a non-root user with `sudo`, from its `$HOME` directory,
run the following commands:

    $ git clone https://github.com/benhylau/mesh-router-builder.git
    $ ./bootstrap.sh
    $ source /etc/profile
    $ cd $HOME
    $ make (optionally, make PROFILE=custom-profile)

You will find built artifacts in the `~/mesh-router-builder/output` directory:

    ./output/debian-packages/yggdrasil_0.1-1_amd64.deb
                             yggdrasil_0.1-1_armhf.deb
                             ...
             mesh-orange-images/raspberrypi2.img
                                sun8i-h2-plus-orangepi-zero.img
                                ...

### Vagrant-managed VM

This is the recommended way to use this builder. Ensure you have
[Vagrant](https://www.vagrantup.com) installed, then clone this repository and run:

    $ vagrant up
    $ vagrant ssh

In the Vagrant machine, call `make` (optionally, `make PROFILE=custom-profile`).
When the build completes, call `exit` and find the built artifacts in the
**output** directory of your host.

Then you may destroy the Vagrant machine with `vagrant destroy`.

#### macOS High Sierra

There is a known bug in macOS High Sierra that prevents Synced Folders from
working. You will have to get the built artifacts manually before destroying the
Vagrant machine:

    $ vagrant ssh-config > vagrant-ssh.conf
    $ mkdir output-macos
    $ scp -r -F vagrant-ssh.conf mesh-router-builder:/vagrant/output/* output-macos/

### Travis CI

This repository auto-builds in a Ubuntu Xenial environment using Travis CI. See
[.travis.yml](https://github.com/benhylau/mesh-router-builder/blob/master/.travis.yml)
for details.

Publish to GitHub Releases
--------------------------

Travis CI is configured to publish official artifacts to
[GitHub Releases](https://github.com/benhylau/mesh-router-builder/releases) on each
release tag.

If you wish to manually publish to GitHub Releases of a forked repository, create a file
named **.github_publish** in the project root before `vagrant up` with the following
information:

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
published to Github Releases in your repository.

