<p align="center">
  <img src=".github/logo.png">
</p>

<p align="center">
  <a href="https://github.com/Xplouder/Toolset/actions"><img alt="CI" src="https://github.com/Xplouder/Toolset/workflows/CI/badge.svg"></a>
</p>

# Toolset

An Ansible role for setting up development tools, GUI applications, and dotfiles on Arch Linux systems. This role automates the installation and configuration of a complete development environment.

## Features

- **OS Package Management**: Installs essential development and system tools via pacman
- **AUR Package Support**: Handles AUR packages with proper change detection
- **Configuration Backup**: Automatically backs up existing dotfiles before replacement
- **Modular Design**: Use tags to run only specific parts of the setup
- **Safety Checks**: Validates OS compatibility and tool availability
- **Docker Integration**: Sets up Docker with proper user permissions

## Requirements

- **Operating System**: Arch Linux only
- **Python**: Required for Ansible execution
- **Privileges**: Root access needed for system package installation

## Supported Software

### Development Tools
- Git, Go, Python, Terraform, Kubectl, Helm, K9s
- JetBrains Toolbox, VS Code alternatives
- Container tools (Docker, Kind, Lens)

### System Tools  
- Terminal emulators (Tilix), file managers
- System monitoring (htop, powertop, ncdu)
- Security tools (KeePassXC, BurpSuite)

### GUI Applications
- Communication (Discord, Slack, WhatsApp)
- Productivity (DrawIO, Notable, Brave browser)

## Role Variables

### Configuration Options
```yaml
# Backup existing configurations before overwriting
toolset_backup_existing_configs: true

# Install AUR packages (requires yay)
toolset_install_aur_packages: true

# Configure Docker and add user to docker group
toolset_configure_docker: true

# Install development tools
toolset_install_dev_tools: true

# Install GUI applications
toolset_install_gui_tools: true
```

### Package Lists
See `defaults/main.yml` for complete package lists:
- `arch_packages`: Official repository packages
- `aur_packages`: AUR packages (requires yay)
- `python_packages`: Python packages via pip

## Usage

### Quick Installation
```bash
git clone https://github.com/Xplouder/Toolset.git toolset
cd toolset
./install.sh
```

### Development Setup
```bash
# Clone the repository
git clone https://github.com/Xplouder/Toolset.git toolset
cd toolset

# The .venv directory is already set up locally but not committed
# Activate the virtual environment
source .venv/bin/activate

# Install/update testing dependencies if needed
pip install -r requirements.txt

# Run tests
./test.sh
```

### Manual Ansible Execution
```yaml
- hosts: localhost
  become: true
  roles:
    - xplouder.toolset
```

### Selective Installation with Tags
```bash
# Install only packages
ansible-playbook -i localhost, -c local playbook.yml --tags packages

# Configure only development tools
ansible-playbook -i localhost, -c local playbook.yml --tags docker,git,vim

# Skip GUI applications
ansible-playbook -i localhost, -c local playbook.yml --skip-tags sublime
```

### Available Tags
- `packages`: OS and AUR package installation
- `docker`: Docker setup and configuration
- `zsh`: Oh My Zsh configuration
- `vim`: Vim setup with gruvbox theme
- `git`: Git aliases and configuration
- `python`: Python package installation
- `sublime`: Sublime Text setup
- `settings`: OS-level settings
- `cleanup`: Temporary file cleanup

## Safety Features

### Backup Protection
- Existing dotfiles are automatically backed up with timestamps
- Use `toolset_backup_existing_configs: false` to disable

### User Environment Handling
- Properly detects user home directory and username
- Works correctly with `become: true` (sudo) execution
- Handles file ownership and permissions properly

### Error Handling
- Validates OS compatibility before execution
- Checks for required tools (yay, git) before use
- Provides clear error messages for troubleshooting

## Troubleshooting

### Common Issues

**AUR packages fail to install**
- Ensure `yay` is installed: `pacman -S yay`
- Check internet connectivity
- Verify AUR package names in `defaults/main.yml`

**Permission errors with dotfiles**
- Role automatically handles user/group ownership
- Ensure you're running with appropriate privileges

**Docker group changes not effective**
- Log out and back in after installation
- Check group membership: `groups $USER`

### Getting Help
1. Check the execution logs for specific error messages
2. Run with increased verbosity: `ansible-playbook -vvv`
3. Use tags to isolate problematic sections
4. Verify system requirements and dependencies

## Contributing

1. Test changes with Molecule: `molecule test`
2. Follow Ansible best practices
3. Update documentation for new features
4. Add appropriate tags to new tasks

## License

MIT
