# vagrant-docker-baseimages

Base Image includes:
 * `vagrant` user (password `vagrant`) with passwordless sudo enabled
 * vagrant insecured public key is in `~/.ssh/authorized_keys`
 * sshd running in foreground just in case if you need to work at a different angle


### Usage

Use the `config.vm.box` setting to specify the basebox in your Vagrantfile.

For example, run `vagrant init tknerr/baseimage-ubuntu-14.04 --minimal` to create the Vagrantfile below:
```ruby
Vagrant.configure(2) do |config|
  config.vm.provider "docker" do |d|
    d.image = "tknerr/baseimage-ubuntu:14.04"
    d.has_ssh = true
  end

  # use shell and other provisioners as usual
  config.vm.provision "shell", inline: "echo 'hello docker!'"
end
```
Then, running `vagrant up --provider docker` 
