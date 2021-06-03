Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  
  # Define VM
  config.vm.define "devops-project-lvl2"

  # The hostname the machine should have
  config.vm.hostname = "devops-project-lvl2"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine.
  config.vm.network "forwarded_port", guest: 8080, host: 8080,
    id: "port_redmine_http",
    guest_ip: "0.0.0.0",
    host_ip: "127.0.0.1"

  # Share an additional folder to the guest VM.
  config.vm.synced_folder ".", "/vagrant"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false
  
    # Customize the amount of memory on the VM
    vb.memory = "2048"

    # Customize the name that appears in the VirtualBox GUI
    vb.name = "devops-project-lvl2"

    # Enable Symbolic Links
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant", "1"]
  end

  # Run Ansible from the Vagrant Host
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "./vagrant-provision/playbook.yml"
  end
end
