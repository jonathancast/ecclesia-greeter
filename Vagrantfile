Vagrant.configure("2") do |config|
    config.vm.box = "debian/contrib-jessie64"

    config.vm.network "forwarded_port", guest: 5000, host: 18080

    config.vm.provision :shell, inline: <<SHELL
        apt-get install -y curl
        apt-get install -y libc6-dev
SHELL

    config.vm.provision :shell, privileged: false, inline: <<SHELL
        cd /vagrant
        ./INSTALL
SHELL
end
