#!/usr/bin/env bash

# Install standard tools
sudo apt update
sudo apt install -y \
  apache2 \
  apt-transport-https \
  build-essential \
  ca-certificates \
  curl \
  gcc-arm-linux-gnueabihf \
  git \
  vim

# Install golang
mkdir /tmp/golang
wget --progress=bar:force https://dl.google.com/go/go1.11.2.linux-amd64.tar.gz -P /tmp/golang
sudo tar -C /usr/local -xzf /tmp/golang/go1.11.2.linux-amd64.tar.gz
{
  echo ''
  echo '# Add golang path'
  echo 'export PATH=$PATH:/usr/local/go/bin'
} | sudo tee --append /etc/profile > /dev/null

# Install nodejs
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

###################################
# Platform specific configurations
###################################

# Install keys required for ubuntu xenial
if [ `lsb_release -c -s` == 'xenial' ]; then
  # See mesh-orange documentation regarding keys being installed
  sudo apt-get -y install debian-archive-keyring
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7638D0442B90D010
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EF0F382A1A7B6500
fi

###################################
# Build environment configurations
###################################

# Configure for vagrant build environment
if [ "$USER" == 'vagrant' ]; then
  echo 'Vagrant environment detected'

  # Set source directory to path in synced folder
  echo 'Setting source directory to Synced Folder at /vagrant/src'
  SOURCE_DIR=/vagrant/src

  # Set local directory for build artifacts to synced folder
  echo 'Setting local directory for build artifacts at /vagrant/output'
  {
    echo ''
    echo '# Set local directory for build artifacts'
    echo 'export BUILD_ARTIFACTS_DIR=/vagrant/output'
  } | sudo tee --append /etc/profile > /dev/null

  # Copy github release publishing configurations
  if [ -f /vagrant/.github_publish ]; then
    . /vagrant/.github_publish
    echo "Setting GitHub Release version to $GITHUB_RELEASE_VERSION"
    {
      echo ''
      echo '# GitHub Release publishing configurations'
      echo "export GITHUB_USERNAME=$GITHUB_USERNAME"
      echo "export GITHUB_REPOSITORY=$GITHUB_REPOSITORY"
      echo "export GITHUB_TOKEN=$GITHUB_TOKEN"
      echo "export GITHUB_RELEASE_VERSION=$GITHUB_RELEASE_VERSION"
    } | sudo tee --append /etc/profile > /dev/null
  fi

# Configure for travis build environment
elif [ "$USER" == 'travis' ]; then
  echo 'Travis environment detected'

  # Set source directory to path where travis clones repository
  echo "Setting source directory to Travis build directory at $TRAVIS_BUILD_DIR/src"
  SOURCE_DIR=$TRAVIS_BUILD_DIR/src

  # Set local directory for build artifacts
  echo "Setting local directory for build artifacts at $HOME/output"
  {
    echo ''
    echo '# Set local directory for build artifacts'
    echo "export BUILD_ARTIFACTS_DIR=$HOME/output"
  } | sudo tee --append /etc/profile > /dev/null

  # Set github release from travis publishing configurations
  echo "Setting GitHub Release version to `$TRAVIS_TAG | sed 's/^v//'`"
  {
    echo ''
    echo '# GitHub Release publishing configurations'
    echo "export GITHUB_RELEASE_VERSION=`echo $TRAVIS_TAG | sed 's/^v//'`"
  } | sudo tee --append /etc/profile > /dev/null

  # Install tools required in travis environment
  sudo apt install -y binutils libc6-dev-i386 binutils-arm-linux-gnueabihf cpp-5-arm-linux-gnueabihf cpp-arm-linux-gnueabihf gcc-5-arm-linux-gnueabihf-base gcc-5-cross-base libasan2-armhf-cross libatomic1-armhf-cross libc6-armhf-cross libc6-dev-armhf-cross libgcc-5-dev-armhf-cross libgcc1-armhf-cross libgomp1-armhf-cross libstdc++6-armhf-cross libubsan0-armhf-cross linux-libc-dev-armhf-cross

# Configure for local build environment
else
  # Set source directory to local path relative to this script
  echo "Setting source directory to local directory at `cd "$(dirname "${BASH_SOURCE[0]}")" && pwd`/src"
  SOURCE_DIR=`cd "$(dirname "${BASH_SOURCE[0]}")" && pwd`/src

  # Set local directory for build artifacts
  echo "Setting local directory for build artifacts at `pwd`/output"
  {
    echo ''
    echo '# Set local directory for build artifacts'
    echo "export BUILD_ARTIFACTS_DIR=`pwd`/output"
  } | sudo tee --append /etc/profile > /dev/null

  # Copy github release publishing configurations
  if [ -f .github_publish ]; then
    . .github_publish
    echo "Setting GitHub Release version to $GITHUB_RELEASE_VERSION"
    {
      echo ''
      echo '# GitHub Release publishing configurations'
      echo "export GITHUB_USERNAME=$GITHUB_USERNAME"
      echo "export GITHUB_REPOSITORY=$GITHUB_REPOSITORY"
      echo "export GITHUB_TOKEN=$GITHUB_TOKEN"
      echo "export GITHUB_RELEASE_VERSION=$GITHUB_RELEASE_VERSION"
    } | sudo tee --append /etc/profile > /dev/null
  fi
fi

# Copy build scripts to user home
cp -r $SOURCE_DIR/* /home/$USER/
chown -R $USER:$USER /home/$USER/*

