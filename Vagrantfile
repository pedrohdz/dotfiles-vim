# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'ubuntu/focal64'
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
      apt-get install -y vim tree nodejs npm python3-pip python3-venv
    EOT

  config.vm.provision 'shell',
    privileged: false,
    inline: <<-'EOT'
      set -o errexit
      set -o nounset
      set -o pipefail

      ln -fvs /vagrant/.vimrc /home/vagrant/.vimrc
      ln -fvs /vagrant/.vimrc.local /home/vagrant/.vimrc.local

      # The neoclide/coc.nvim vim pligin does not like symlinks when creating
      # ~/.vim/plugged/coc.nvim.  So we are symlinking eveything in ~/.vim/
      # instead.
      mkdir /home/vagrant/.vim || true
      find /vagrant/.vim/* -maxdepth 0 -type d -exec ln -fsv \{\} /home/vagrant/.vim/ \;
      ln -fsv /vagrant/.vim/coc-settings.json /home/vagrant/.vim/coc-settings.json
    EOT

  #config.vm.provision 'shell',
  #  reboot: true

end
