# -*- mode: ruby -*-
# vi: set ft=ruby :

# Multi-VM Configuration: Builds Web, Application, and Database Servers using JSON config file
# Configures VMs based on Hosted Chef Server defined Environment and Node (vs. Roles)
# Author: Gary A. Stafford

VAGRANTFILE_API_VERSION = "2"

vm_nodes = (JSON.parse(File.read("./conf/nodes.json")))['nodes']

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  vm_nodes.each do |node|
    node_name = node[0] # name of node
    node_conf = node[1] # content of node

    config.vm.define node_name do |machine|    
      machine.vm.box = node_conf[':box']
      machine.vm.hostname = node_name
      machine.vm.network :private_network, ip: node_conf[':ip']
      machine.vm.post_up_message = node_conf[':up_message']

      # syncs local repository of large third-party installer files (quicker than downloading each time)
      #config.vm.synced_folder "#{ENV['HOME']}/Documents/git_repos/chef-artifacts", "/vagrant"

      forwarding_ports = node_conf['ports']
      forwarding_ports.each do |forwarding_port|
        machine.vm.network :forwarded_port,
          host:  forwarding_port[':host'],
          guest: forwarding_port[':guest'],
          id:    forwarding_port[':id']
      end # forwarding_ports.each

      machine.vm.provider :virtualbox do |virtualbox|
        virtualbox.customize ["modifyvm", :id, "--memory", node_conf[':memory']]
        virtualbox.customize ["modifyvm", :id, "--name", node_name]
      end # machine.vm.provider

      machine.vm.provision :ansible do |ansible|
        ansible.playbook = "./ansible/playbook.yml"
        ansible.inventory_path = "./ansible/hosts"
        ansible.sudo = true
        ansible.verbose = "vv"
      end
    end # config.vm.define
  end # vm_nodes.each
end # Vagrant.configure