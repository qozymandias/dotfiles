# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.provider "vmware_desktop" do |v|
    v.gui = true
  	v.memory = "16384"
  	v.cpus = 8
  end
  config.vm.disk :disk, size: "100GB", primary: true
  config.vm.provision "file", source: "~/.ssh/id_rsa", destination: "~/.ssh/id_rsa"
  config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/id_rsa.pub"
  config.vm.provision :shell, path: "bootstrap.sh"

  # config.vm.network :private_network, ip: "192.168.33.10"
  # config.ssh.forward_agent = true
  # config.vm.network :forwarded_port, host: 8001, guest: 8001

  # config.vm.provision "shell" do |s|
  # ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
  # s.inline = <<-SHELL
  #     echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
  #     echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
  #   SHELL
  # end

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 22, host: 2524

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  
  
end
