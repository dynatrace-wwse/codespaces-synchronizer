#!/bin/bash

# Set permissions explicitly 
sudo chgrp $(stat -c '%G' /var/run/docker.sock) /var/run/docker.sock
sudo chmod 660 /var/run/docker.sock


groupadd -g <GID> dockergroup
usermod -aG dockergroup <user>


# Run as ubuntu
sudo chmod 660 /var/run/docker.sock

sudo chown root:docker /var/run/docker.sock
