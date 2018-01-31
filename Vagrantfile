# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "mesh-router-builder"
  config.vm.box = "debian/stretch64"
  config.vm.box_version = "9.3.0"
  config.vm.provision :shell, path: "bootstrap.sh"

  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
  end
end
