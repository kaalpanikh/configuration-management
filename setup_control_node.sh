#!/bin/bash

# This script sets up the Ansible control node on Amazon Linux 2023

echo "Setting up Ansible control node..."
echo "================================="

# Update package list
echo "📦 Updating system packages..."
sudo dnf update -y

# Install EPEL repository
echo "📦 Installing EPEL repository..."
sudo dnf install -y epel-release

# Install Python 3 and pip
echo "🐍 Installing Python and pip..."
sudo dnf install -y python3-pip git

# Install Ansible using pip
echo "🎮 Installing Ansible..."
python3 -m pip install --user ansible

# Add local bin to PATH
echo "🔧 Updating PATH..."
if ! grep -q 'export PATH=$PATH:$HOME/.local/bin' ~/.bashrc; then
    echo 'export PATH=$PATH:$HOME/.local/bin' >> ~/.bashrc
fi
source ~/.bashrc

# Install boto3 for AWS integration
echo "☁️ Installing AWS dependencies..."
python3 -m pip install --user boto3

# Create project directory
echo "📁 Creating project directory..."
mkdir -p ~/ansible-project

# Create SSH config
echo "🔑 Configuring SSH..."
mkdir -p ~/.ssh
cat > ~/.ssh/config << 'EOL'
Host *
    StrictHostKeyChecking no
EOL
chmod 600 ~/.ssh/config

echo ""
echo "✅ Control node setup complete!"
echo ""
echo "Next steps:"
echo "1. Run copy_to_control.sh from your local machine to copy:"
echo "   - Project files to ~/ansible-project/"
echo "   - SSH keys to ~/.ssh/"
echo ""
echo "2. Then run the playbook:"
echo "   ansible-playbook setup.yml -i inventory.ini"
