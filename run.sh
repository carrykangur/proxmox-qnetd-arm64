#!/bin/bash
set -e

# Prepare .ssh directory
mkdir -p /root/.ssh
chmod 700 /root/.ssh

# If an SSH key was passed, write it
if [ -n "$SSH_PUBLIC_KEY" ]; then
    echo "Deploying SSH public key..."
    echo "$SSH_PUBLIC_KEY" > /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
else
    echo "WARNING: No SSH_PUBLIC_KEY provided. SSH login will require password."
fi

# Disable password login for safety
sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/^#\?ChallengeResponseAuthentication.*/ChallengeResponseAuthentication no/' /etc/ssh/sshd_config

echo "Starting SSHD..."
/usr/sbin/sshd

echo "Starting qnetd..."
exec corosync-qnetd -f -p 5403
