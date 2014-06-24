# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure("2") do |config|

  config.vm.define "app" do |v|
    v.vm.provider "docker" do |d|
      d.build_dir = "./docker"
      d.cmd	  = ["ls", "/app"]
      d.remains_running = false
    end
  end

  config.vm.define "db" do |v|
     v.vm.provider "docker" do |d|
	d.image = "paintedfox/postgresql"
   end
  end
end


