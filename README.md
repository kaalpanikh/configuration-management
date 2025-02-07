# Ansible Configuration Management Project

This project demonstrates how to use Ansible for server configuration management, specifically setting up a web server with Nginx and SSL. It follows the project requirements from [roadmap.sh's Configuration Management Project](https://roadmap.sh/projects/configuration-management).

## Project Overview

We use Ansible to configure two AWS EC2 instances:
1. **Control Node**: Amazon Linux 2023 instance that runs Ansible
2. **Target Node**: Ubuntu instance that hosts our website

The project automates the following:
- Basic server setup and security
- Nginx web server installation and configuration
- SSL certificate setup using Let's Encrypt
- Website deployment from a Git repository

## Project Result

![SSL Proof](images/ssl-proof.png)

Successfully set up a secure website with:
- HTTPS encryption using Let's Encrypt SSL
- Automatic HTTP to HTTPS redirection
- Modern security headers
- Automated certificate renewal

The website is securely accessible at https://ansible.nikhilmishra.live

## Learning Resources

For a deep dive into this project:
- Check out [LEARNING_GUIDE.md](LEARNING_GUIDE.md) for a comprehensive understanding of:
  * Complete project implementation details
  * Technical concepts and best practices
  * Real-world applications and scaling
  * Maintenance and troubleshooting
  * Advanced topics and improvements

## Prerequisites

1. **AWS Account** with two EC2 instances:
   - Control Node: Amazon Linux 2023
   - Target Node: Ubuntu

2. **SSH Keys** for both instances:
   - Control Node: `~/.ssh/my_first_key`
   - Target Node: `~/.ssh/roadmapsh-ansible-key.pem`

3. **Domain Name** pointing to the target node's IP address
   - Our example uses: ansible.nikhilmishra.live

## Project Structure

```
configuration-management/
├── inventory.ini           # Defines our servers
├── setup.yml              # Main playbook
├── requirements.txt       # Python dependencies
└── roles/
    ├── base/             # Basic server setup
    │   ├── tasks/
    │   └── handlers/
    ├── nginx/            # Nginx web server
    │   ├── tasks/
    │   ├── handlers/
    │   └── templates/
    ├── app/              # Website deployment
    │   ├── tasks/
    │   └── defaults/
    └── ssh/              # SSH configuration
        ├── tasks/
        └── handlers/
```

## Role Descriptions

1. **Base Role**
   - Updates system packages
   - Installs essential tools
   - Sets up security (UFW/firewalld, fail2ban)
   - Installs certbot for SSL

2. **Nginx Role**
   - Installs and configures Nginx
   - Sets up server blocks
   - Configures SSL with Let's Encrypt
   - Adds security headers

3. **App Role**
   - Creates web directory
   - Deploys website from Git
   - Sets proper permissions

4. **SSH Role**
   - Configures SSH security
   - Manages SSH keys
   - Sets up proper permissions

## Getting Started

1. **Clone the Repository**
   ```bash
   git clone https://github.com/kaalpanikh/configuration-management.git
   cd configuration-management
   ```

2. **Update Inventory**
   - Edit `inventory.ini` with your EC2 instances' details
   - Update SSH key paths

3. **Copy Files to Control Node**
   ```bash
   ./copy_to_control.sh
   ```

4. **Run the Playbook**
   ```bash
   cd ~/ansible-project
   ansible-playbook setup.yml -i inventory.ini
   ```

## What the Playbook Does

1. **Basic Setup** (base role)
   - Updates system packages
   - Installs security tools
   - Configures firewall rules
   - Sets up fail2ban for security

2. **Web Server** (nginx role)
   - Installs Nginx
   - Creates server configuration
   - Obtains SSL certificate
   - Sets up automatic SSL renewal

3. **Website Deployment** (app role)
   - Clones website from Git
   - Sets proper permissions
   - Configures web root

4. **SSH Security** (ssh role)
   - Configures SSH daemon
   - Sets up key-based authentication
   - Applies security best practices

## Security Features

1. **Firewall Configuration**
   - UFW on Ubuntu
   - Only ports 22 (SSH), 80 (HTTP), and 443 (HTTPS) are open

2. **SSL/TLS**
   - Automatic SSL certificate from Let's Encrypt
   - HTTP to HTTPS redirection
   - Modern SSL security settings

3. **Server Hardening**
   - fail2ban for brute force protection
   - Secure SSH configuration
   - Security headers in Nginx

## Maintenance

- SSL certificates automatically renew via cron job
- System packages can be updated by re-running the playbook
- Website updates by pushing to the Git repository

## Troubleshooting

1. **SSH Connection Issues**
   - Verify security group rules
   - Check SSH key permissions (should be 600)
   - Ensure proper key paths in inventory

2. **SSL Certificate Issues**
   - Verify domain DNS settings
   - Check nginx configuration
   - Review certbot logs

3. **Website Not Loading**
   - Check nginx status
   - Verify website files in /var/www/html
   - Check nginx error logs

## Contributing

Feel free to submit issues and enhancement requests!

## License

This project is licensed under the MIT License - see the LICENSE file for details.