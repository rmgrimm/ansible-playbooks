#!/bin/sh

# Drop sudo cache and ask again to confirm sudo
sudo -K
if ! sudo -v; then
    echo "sudo failed; aborting."
    exit 1
fi

# Use aptitude because apt-get doesn't store which packages are explicitly
# installed vs auto-installed.
if ! which aptitude >/dev/null; then
    sudo apt-get install -y aptitude || exit 1
fi

# Set up ansible from PPA
sudo add-apt-repository -y ppa:ansible/ansible || exit 1
sudo aptitude update || exit 1
sudo aptitude install -y ansible || exit 1
