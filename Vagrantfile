Vagrant.configure(2) do |config|

  config.ssh.private_key_path = "~/.ssh/vagrant"
  config.ssh.forward_agent = true

  config.vm.provider "docker" do |d|
    d.image = "mcheriyath/ubuntu16.04"
    d.has_ssh = true
  end

  # use shell and other provisioners as usual
  config.vm.provision "shell", inline: "echo 'hello docker!'"
end
