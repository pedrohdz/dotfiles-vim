# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'ubuntu/bionic64'
  config.vm.hostname = 'vim-sampler'

  config.vm.provider 'virtualbox' do |vb|
    vb.gui = false
    vb.memory = 1024
    vb.cpus = 1
  end

  if Vagrant.has_plugin?('vagrant-vbguest')
    config.vbguest.auto_update = true
  end

  config.vm.synced_folder 'home/', '/vagrant',
    automount: true,
    type: 'virtualbox',
    owner: 'vagrant',
    group: 'vagrant'

  config.vm.provision 'shell',
    inline: <<-'EOT'
      apt-get update
      apt-get dist-upgrade -y
      apt-get install -y vim
    EOT

  config.vm.provision 'shell',
    privileged: false,
    inline: <<-'EOT'
      ln -fvs /vagrant/.vimrc /home/vagrant/.vimrc
      ln -nfvs /vagrant/.vim /home/vagrant/.vim
      ln -fvs /vagrant/.vimrc.local /home/vagrant/.vimrc.local
    EOT

  #config.vm.provision 'shell',
  #  reboot: true

end
