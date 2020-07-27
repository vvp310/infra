#!/bin/bash
set -e

# Install MongoDB
wget http://repo.mongodb.org/apt/ubuntu/dists/xenial/mongodb-org/3.2/multiverse/binary-amd64/mongodb-org-server_3.2.22_amd64.deb
wget http://repo.mongodb.org/apt/ubuntu/dists/xenial/mongodb-org/3.2/multiverse/binary-amd64/mongodb-org-shell_3.2.22_amd64.deb
wget http://repo.mongodb.org/apt/ubuntu/dists/xenial/mongodb-org/3.2/multiverse/binary-amd64/mongodb-org-mongos_3.2.22_amd64.deb
wget http://repo.mongodb.org/apt/ubuntu/dists/xenial/mongodb-org/3.2/multiverse/binary-amd64/mongodb-org-tools_3.2.22_amd64.deb
wget http://repo.mongodb.org/apt/ubuntu/dists/xenial/mongodb-org/3.2/multiverse/binary-amd64/mongodb-org_3.2.22_amd64.deb
dpkg -i mongodb-org-server_3.2.22_amd64.deb
dpkg -i mongodb-org-shell_3.2.22_amd64.deb
dpkg -i mongodb-org-mongos_3.2.22_amd64.deb
dpkg -i mongodb-org-tools_3.2.22_amd64.deb
dpkg -i mongodb-org_3.2.22_amd64.deb

systemctl enable mongod
