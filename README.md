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
Then, running `vagrant up --provider docker` we will get something like
```ruby
> vagrant up --provider docker
Bringing machine 'default' up with 'docker' provider...
==> default: Creating the container...
    default:   Name: vagrant-docker-baseimages_default_1471468586
    default:  Image: mcheriyath/ubuntu16.04
    default: Volume: ~/Projects/vagrant-docker-baseimages:/vagrant
    default:   Port: 127.0.0.1:2222:22
    default:  
    default: Container created: f32fb9eea98df378
==> default: Starting container...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 172.17.0.2:22
    default: SSH username: vagrant
    default: SSH auth method: private key
==> default: Machine booted and ready!
==> default: Running provisioner: shell...
    default: Running: inline script
==> default: mesg: ttyname failed: Inappropriate ioctl for device
==> default: hello docker!
``` 
