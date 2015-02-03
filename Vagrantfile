# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |vagrant_config|

  vagrant_config.vm.define 'spring-boot-sample' do |config|

    config.vm.hostname = 'spring-boot-sample'
    config.vm.box = "ubuntu/trusty64"

    config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", 4096]
    end

    # installs mysql, rabbitmq, etc...
    config.vm.provision :shell, :path => "vagrant.sh" 

    config.vm.network(:private_network, ip: "192.168.33.50")

    #                       Host Path,            VM Path
    config.vm.synced_folder('~/projects/spring-boot-sample', '/spring-boot-sample')

  end #vagrant_config.vm.define

end #Vagrant::Config.run
