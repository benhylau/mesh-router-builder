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

# Copy build scripts from Synced Folder to Vagrant machine user home
cp -r /vagrant/src/* /home/vagrant/
chown -R vagrant:vagrant /home/vagrant/*

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
