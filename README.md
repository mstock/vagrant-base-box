vagrant-base-box
================

Puppet manifest to configure a Debian-based VM as [Vagrant](http://www.vagrantup.com/) base box.

Usage
-----

- Setup a virtual machine with a Debian-based Linux distribution (follow the description in [Base
  Boxes](https://developer.hashicorp.com/vagrant/docs/boxes/base) for this,
  until you reach the "Default User Settings" section).
- Install Puppet.
- Copy the `vagrant-base-box.pp` file to the virtual machine and run `puppet apply
  vagrant-base-box.pp`. This sets up `sudo`, `ssh` (including the [insecure SSH
  key](https://github.com/hashicorp/vagrant/tree/main/keys)) and installs some packages (including
  `git` and `tmux`).
