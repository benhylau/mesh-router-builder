#!/usr/bin/env bash

# Install standard tools
apt install -y build-essential git vim

# Install golang
mkdir /tmp/golang
wget --progress=bar:force https://dl.google.com/go/go1.9.2.linux-amd64.tar.gz -P /tmp/golang
tar -C /usr/local -xzf /tmp/golang/go1.9.2.linux-amd64.tar.gz
{
  echo ''
  echo '# Add golang path'
  echo 'export PATH=$PATH:/usr/local/go/bin'
} >> /etc/profile

# Copy build scripts from Synced Folder to Vagrant machine user home
cp -r /vagrant/src/* /home/vagrant/
chown vagrant:vagrant /home/vagrant/*
