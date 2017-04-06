#!/bin/bash
# This is the file from BITS-Darshini
# customize before committing the file to repo

echo "PS1='\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \$ '" >> /home/vagrant/.bashrc
echo "cd /home/vagrant/autolab" >>  /home/vagrant/.bashrc
source /home/vagrant/.bashrc
cd /home/vagrant/autolab

# install development environment
apt-get install -y git
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
apt-get install -y nodejs
npm install npm@latest -g

# run setup.sh to install the Autolab prerequisite packages
source /home/vagrant/autolab/deploy/setup.sh

# if available, load docker images
if [ -d /home/vagrant/autolab/docker-images ]
then
  cd /home/vagrant/autolab/docker-images
  bash load.sh
fi

# run Ansible playbook
cd /home/vagrant/autolab/deploy
sudo ansible-playbook playbook.yml -i inventory
#sudo ansible-playbook playbook.yml -i inventory --user=vagrant --extra-vars "ansible_ssh_port=2222 ansible_become_pass=vagrant"