#!/bin/bash
set -e

echo "Starting SSHD..."
/usr/sbin/sshd

echo "Starting qnetd..."
exec corosync-qnetd -f -p 5403
