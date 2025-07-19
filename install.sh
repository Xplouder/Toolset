#!/usr/bin/env bash

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on supported OS
check_os() {
    if [[ ! -f /etc/arch-release ]]; then
        log_error "This script is designed for Arch Linux only"
        exit 1
    fi
}

# Check if python is available
check_python() {
    if ! command -v python &> /dev/null; then
        log_error "Python is required but not installed"
        exit 1
    fi
}

# Install required packages
install_dependencies() {
    log_info "Installing Ansible and Docker Python packages..."
    
    if ! python -m pip install --user ansible docker; then
        log_error "Failed to install Python dependencies"
        exit 1
    fi
    
    # Ensure pip user bin is in PATH
    export PATH="$HOME/.local/bin:$PATH"
}

# Run the Ansible playbook
run_playbook() {
    log_info "Running Ansible playbook..."
    
    export ANSIBLE_LOAD_CALLBACK_PLUGINS=1
    export ANSIBLE_STDOUT_CALLBACK=yaml
    current_dir_name="$(dirname "$(pwd)")"
    export ANSIBLE_ROLES_PATH=$current_dir_name
    
    if ! ansible localhost -bK -c local -m include_role -a name="$(basename "$(pwd)")"; then
        log_error "Ansible playbook execution failed"
        exit 1
    fi
}

# Main execution
main() {
    log_info "Starting Toolset installation..."
    
    check_os
    check_python
    install_dependencies
    run_playbook
    
    log_info "Installation completed successfully!"
    log_warn "Please log out and back in for all changes to take effect"
}

# Run main function
main "$@"
