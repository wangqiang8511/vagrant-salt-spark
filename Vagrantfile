# -*- mode: ruby -*-
# vi: set ft=ruby :

$master_script = <<SCRIPT
#!/bin/bash
cat > /etc/hosts <<EOF
127.0.0.1       localhost

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters

10.211.55.100   vm-cluster-master
10.211.55.101   vm-cluster-node1
10.211.55.102   vm-cluster-node2
EOF

SCRIPT

$slave_script = <<SCRIPT
cat > /etc/hosts <<EOF
127.0.0.1       localhost

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters

10.211.55.100   vm-cluster-master
10.211.55.101   vm-cluster-node1
10.211.55.102   vm-cluster-node2
EOF
SCRIPT

Vagrant.configure("2") do |config|

  config.vm.define :master do |master|
    master.vm.box = "precise64"
    master.vm.provider "vmware_fusion" do |v|
      v.vmx["memsize"]  = "1024"
    end
    master.vm.provider :virtualbox do |v|
      v.name = "vm-cluster-master"
      v.customize ["modifyvm", :id, "--memory", "1024"]
    end
    master.vm.network :private_network, ip: "10.211.55.100"
    master.vm.hostname = "vm-cluster-master"
    master.vm.synced_folder "salt/roots/", "/srv/"
    master.vm.provision :shell, :inline => $master_script

    master.vm.provision :salt do |salt|
      # Config salt master and minion
      salt.minion_config = "salt/minion"
      salt.master_config = "salt/master"
      salt.minion_key = "salt/key/minion.pem"
      salt.minion_pub = "salt/key/minion.pub"
      salt.master_key = "salt/key/master.pem"
      salt.master_pub = "salt/key/master.pub"

      # Install Salt
      salt.install_type = "git"
      salt.install_args = "develop"
      salt.install_master = true
      salt.seed_master = {minion: salt.minion_pub}
      salt.run_highstate = false
      salt.always_install = true
      salt.verbose = true
      salt.bootstrap_script = "salt/custom-bootstrap-salt.sh"
      salt.bootstrap_options = "-D"
      salt.temp_config_dir = "/tmp"
    end
  end

  config.vm.define :node1 do |node1|
    node1.vm.box = "precise64"
    node1.vm.provider "vmware_fusion" do |v|
      v.vmx["memsize"]  = "1024"
    end
    node1.vm.provider :virtualbox do |v|
      v.name = "vm-cluster-node1"
      v.customize ["modifyvm", :id, "--memory", "1024"]
    end
    node1.vm.network :private_network, ip: "10.211.55.101"
    node1.vm.hostname = "vm-cluster-node1"
    node1.vm.synced_folder "salt/roots/", "/srv/"
    node1.vm.provision :shell, :inline => $slave_script

    node1.vm.provision :salt do |salt|

      # Config Salt Minion
      salt.minion_config = "salt/minion"
      salt.minion_key = "salt/key/minion.pem"
      salt.minion_pub = "salt/key/minion.pub"

      # Install Salt Minion
      salt.install_type = "git"
      salt.install_args = "develop"
      salt.install_master = false
      salt.run_highstate = false
      salt.always_install = true
      salt.verbose = true
      salt.bootstrap_script = "salt/custom-bootstrap-salt.sh"
      salt.bootstrap_options = "-D"
      salt.temp_config_dir = "/tmp"
    end
  end

  config.vm.define :node2 do |node2|
    node2.vm.box = "precise64"
    node2.vm.provider "vmware_fusion" do |v|
      v.vmx["memsize"]  = "1024"
    end
    node2.vm.provider :virtualbox do |v|
      v.name = "vm-cluster-node2"
      v.customize ["modifyvm", :id, "--memory", "1024"]
    end
    node2.vm.network :private_network, ip: "10.211.55.102"
    node2.vm.hostname = "vm-cluster-node2"
    node2.vm.synced_folder "salt/roots/", "/srv/"
    node2.vm.provision :shell, :inline => $slave_script

    node2.vm.provision :salt do |salt|

      # Config Salt Minion
      salt.minion_config = "salt/minion"
      salt.minion_key = "salt/key/minion.pem"
      salt.minion_pub = "salt/key/minion.pub"
      
      # Install salt minion
      salt.install_type = "git"
      salt.install_args = "develop"
      salt.install_master = false
      salt.run_highstate = false
      salt.always_install = true
      salt.verbose = true
      salt.bootstrap_script = "salt/custom-bootstrap-salt.sh"
      salt.bootstrap_options = "-D"
      salt.temp_config_dir = "/tmp"
    end
  end

end
