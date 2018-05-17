# Note, if you're unfamiliar with this:
#
# This config puts the boxes onto your local LAN.
# If you share your LAN with someone else,
# and that someone else is *also* doing development on Greeter,
# you probably want to change the last number in PRIVATE_NETWORK to something unique to your box
PRIVATE_NETWORK = "10.45.45"

Vagrant.configure("2") do |config|
    config.vm.define "db" do |db|
        db.vm.box = "debian/contrib-jessie64"

        db.vm.network "private_network", ip: "#{PRIVATE_NETWORK}.4"

        db.vm.provision :shell, inline: "cd /vagrant && ./vagrant-db.pl #{PRIVATE_NETWORK}.4"
    end

    config.vm.define "web" do |web|
        web.vm.box = "debian/contrib-jessie64"

        web.vm.network "private_network", ip: "#{PRIVATE_NETWORK}.5"

        web.vm.network "forwarded_port", guest: 5000, host: 18080

        web.vm.provision :shell, inline: "apt-get install -y curl libc6-dev postgresql-client libpq-dev"
        web.vm.provision :shell, privileged: false, inline: "echo 'export PGHOST=#{PRIVATE_NETWORK}.4' >> $HOME/.profile"
        web.vm.provision :shell, privileged: false, inline: "echo '*:*:*:vagrant:vagrdbpass' >> $HOME/.pgpass"
        web.vm.provision :shell, privileged: false, inline: "chmod 0600 $HOME/.pgpass"
        web.vm.provision :shell, privileged: false, inline: "cd /vagrant && ./INSTALL"
    end
end
