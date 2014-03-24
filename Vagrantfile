# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "recipes/cookbooks"
    chef.roles_path = "recipes/roles"
    chef.add_role "sysdig-base"
  end
end
