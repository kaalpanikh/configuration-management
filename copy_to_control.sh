#!/bin/bash

# This script copies the project files to the Ansible control node

# Check if SSH key paths are provided
if [ ! -f ~/.ssh/my_first_key ] || [ ! -f ~/.ssh/roadmapsh-ansible-key.pem ]; then
    echo "Error: Required SSH keys not found!"
    echo "Please ensure the following SSH keys exist:"
    echo "  - ~/.ssh/my_first_key (for control node)"
    echo "  - ~/.ssh/roadmapsh-ansible-key.pem (for target node)"
    exit 1
fi

# Create a temporary directory for the project
mkdir -p /tmp/ansible-project

# Copy all project files to the temporary directory
cp -r * /tmp/ansible-project/

# Copy project files to control node
echo "Copying project files to control node..."
scp -i ~/.ssh/my_first_key -r /tmp/ansible-project/* ec2-user@54.88.211.25:~/ansible-project/

# Copy SSH keys to control node
echo "Copying SSH keys to control node..."
scp -i ~/.ssh/my_first_key ~/.ssh/my_first_key ec2-user@54.88.211.25:~/.ssh/
scp -i ~/.ssh/my_first_key ~/.ssh/roadmapsh-ansible-key.pem ec2-user@54.88.211.25:~/.ssh/

# Set correct permissions on control node
echo "Setting correct permissions on SSH keys..."
ssh -i ~/.ssh/my_first_key ec2-user@54.88.211.25 "chmod 600 ~/.ssh/my_first_key ~/.ssh/roadmapsh-ansible-key.pem"

echo " Files copied successfully to control node"
echo ""
echo "Next steps:"
echo "1. SSH into control node:"
echo "   ssh -i ~/.ssh/my_first_key ec2-user@54.88.211.25"
echo ""
echo "2. Run the playbook:"
echo "   cd ~/ansible-project"
echo "   ansible-playbook setup.yml -i inventory.ini"
