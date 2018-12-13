#!/usr/bin/env bash

# Install standard tools
apt install -y \
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
tar -C /usr/local -xzf /tmp/golang/go1.11.2.linux-amd64.tar.gz
{
  echo ''
  echo '# Add golang path'
  echo 'export PATH=$PATH:/usr/local/go/bin'
} >> /etc/profile

# Install nodejs
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
apt-get install -y nodejs

# Configure for vagrant build environment
if [ "$USER" == 'vagrant' ]; then
  # Set source directory to path in synced folder
  echo 'Vagrant environment detected'
  echo 'Setting source directory to Synced Folder at /vagrant/src'
  SOURCE_DIR=/vagrant/src

  # Set local directory for build artifacts to synced folder
  {
    echo ''
    echo '# Set local directory for build artifacts'
    echo 'export BUILD_ARTIFACTS_DIR=/vagrant/output'
  } >> /etc/profile

  # Copy github release publishing configurations
  if [ -f /vagrant/.github_publish ]; then
    . /vagrant/.github_publish
    {
      echo ''
      echo '# GitHub Release publishing configurations'
      echo "export GITHUB_USERNAME=$GITHUB_USERNAME"
      echo "export GITHUB_REPOSITORY=$GITHUB_REPOSITORY"
      echo "export GITHUB_TOKEN=$GITHUB_TOKEN"
      echo "export GITHUB_RELEASE_VERSION=$GITHUB_RELEASE_VERSION"
    } >> /etc/profile
  fi

# Configure for travis build environment
elif [ "$USER" == 'travis' ]; then
  # Set source directory to path where travis clones repository
  echo 'Travis environment detected'
  echo "Setting source directory to Travis build directory at $TRAVIS_BUILD_DIR/src"
  SOURCE_DIR=$TRAVIS_BUILD_DIR/src

  # Set local directory for build artifacts
  {
    echo ''
    echo '# Set local directory for build artifacts'
    echo 'export BUILD_ARTIFACTS_DIR=./output'
  } >> /etc/profile

  # Set github release from travis publishing configurations
  {
    echo ''
    echo '# GitHub Release publishing configurations'
    echo "export GITHUB_RELEASE_VERSION=`echo $TRAVIS_TAG | sed 's/^v//'`"
  } >> /etc/profile

# Configure for local build environment
else
  # Set source directory to local path relative to this script
  echo "Setting source directory to local directory at ./src"
  SOURCE_DIR=./src

  # Set local directory for build artifacts
  {
    echo ''
    echo '# Set local directory for build artifacts'
    echo "export BUILD_ARTIFACTS_DIR=./output"
  } >> /etc/profile

  # Copy github release publishing configurations
  if [ -f .github_publish ]; then
    . .github_publish
    {
      echo ''
      echo '# GitHub Release publishing configurations'
      echo "export GITHUB_USERNAME=$GITHUB_USERNAME"
      echo "export GITHUB_REPOSITORY=$GITHUB_REPOSITORY"
      echo "export GITHUB_TOKEN=$GITHUB_TOKEN"
      echo "export GITHUB_RELEASE_VERSION=$GITHUB_RELEASE_VERSION"
    } >> /etc/profile
  fi
fi

# Copy build scripts to user home
cp -r $SOURCE_DIR/* /home/$USER/
chown -R $USER:$USER /home/$USER/*

