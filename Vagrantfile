# -*- mode: ruby -*-
# vi: set ft=ruby : vsa

Vagrant.configure(2) do |config| 
 config.vm.box = "centos/7" 
 config.vm.box_version = "2004.01" 

 config.vm.provider "virtualbox" do |v| 
 v.memory = 1024 
 v.cpus = 1 
 end 

 config.vm.define "backup" do |backup| 
 backup.vm.network "private_network", ip: "192.168.11.160",  virtualbox__intnet: "net1" 
 backup.vm.hostname = "backup" 

 backup.vm.provider "virtualbox" do |bk|
   unless FileTest.exist?('./backup.vdi')
	bk.customize ['createhd', '--filename', './backup.vdi', '--variant', 'Fixed', '--size', 2048]
	needsController = true
	end
   bk.customize ["storagectl", :id, "--name", "SATA", "--add", "sata"]
   bk.customize ['storageattach', :id, '--storagectl', 'SATA', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', './backup.vdi']
   end 
 backup.vm.provision "shell", path: "server/backup.sh"
 end
 config.vm.define "client" do |client| 
 client.vm.network "private_network", ip: "192.168.11.150",  virtualbox__intnet: "net1" 
# client.vm.network "private_network", ip: "192.168.11.150",  name: "vboxnet0"
 client.vm.hostname = "client"
 client.vm.provision "shell", path: "client/client.sh" 
 end
end

  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
#end
