# Testing Guide

This document describes the comprehensive testing strategy for the Toolset Ansible role.

## Test Structure

### 1. Syntax and Linting Tests
- **YAML Lint**: Validates YAML syntax across all files
- **Ansible Lint**: Checks Ansible best practices and potential issues
- **Syntax Check**: Validates playbook syntax

### 2. Molecule Tests
Molecule provides isolated testing in Docker containers:

#### Default Scenario (`molecule/default/`)
- Tests full installation with Docker enabled
- Verifies all core functionality
- Checks service states and user configurations
- Validates file permissions and ownership

#### Minimal Scenario (`molecule/minimal/`)
- Tests basic installation without GUI tools
- Verifies essential packages only
- Ensures Docker is not configured when disabled

### 3. Integration Tests
- Real environment testing (optional)
- Custom configuration scenarios
- End-to-end functionality verification

## Running Tests

### Quick Test (Recommended)
```bash
# Run all tests except integration
./test.sh
```

### Individual Test Types
```bash
# Syntax checks only
./test.sh --skip-molecule

# Molecule tests only
./test.sh --skip-syntax

# Include integration tests (requires local environment)
./test.sh --integration
```

### Manual Molecule Testing
```bash
# Test default scenario
molecule test -s default

# Test minimal scenario
molecule test -s minimal

# Debug mode (keeps container running)
molecule converge -s default
molecule verify -s default
molecule destroy -s default
```

## Test Coverage

### Verified Components

#### Package Management
- ✅ Core development tools installation
- ✅ AUR package handling (when enabled)
- ✅ Python package installation
- ✅ Package availability verification

#### Service Configuration
- ✅ Docker service startup and enablement
- ✅ User addition to docker group
- ✅ Service state validation

#### File Management
- ✅ Dotfile installation (.vimrc, .bashrc, .zshrc)
- ✅ Configuration backup functionality
- ✅ File ownership and permissions
- ✅ Directory creation (vim plugins)

#### User Environment
- ✅ Git configuration and aliases
- ✅ Vim setup with gruvbox theme
- ✅ Shell configuration (bash/zsh)
- ✅ System settings (swappiness)

#### Error Handling
- ✅ OS compatibility validation
- ✅ Tool availability checks
- ✅ Graceful failure handling
- ✅ Proper change detection

### Test Scenarios

#### Scenario 1: Full Installation
```yaml
toolset_install_aur_packages: true
toolset_configure_docker: true
toolset_install_gui_tools: true
toolset_install_dev_tools: true
toolset_backup_existing_configs: true
```

#### Scenario 2: Minimal Installation
```yaml
toolset_install_aur_packages: false
toolset_configure_docker: false
toolset_install_gui_tools: false
toolset_install_dev_tools: false
toolset_backup_existing_configs: false
```

#### Scenario 3: Development Only
```yaml
toolset_install_aur_packages: false
toolset_configure_docker: true
toolset_install_gui_tools: false
toolset_install_dev_tools: true
toolset_backup_existing_configs: true
```

## Continuous Integration

### GitHub Actions Workflow
The CI pipeline includes:

1. **Lint Stage**: YAML and Ansible linting
2. **Molecule Stage**: Parallel testing of all scenarios
3. **Integration Stage**: Real environment testing (main branch only)
4. **Security Stage**: Vulnerability scanning
5. **Documentation Stage**: Link checking and metadata validation

### Test Matrix
- **Python Versions**: 3.11 (primary)
- **Ansible Versions**: Latest stable
- **Test Scenarios**: default, minimal
- **Platforms**: Arch Linux (Docker)

## Local Development Testing

### Prerequisites
```bash
# Install testing dependencies
pip install molecule[docker] molecule-plugins[docker] ansible yamllint ansible-lint
```

### Development Workflow
1. Make changes to role
2. Run syntax checks: `./test.sh --skip-molecule`
3. Test specific scenario: `molecule test -s default`
4. Run full test suite: `./test.sh`
5. Check test report: `cat test_report.md`

### Debugging Failed Tests
```bash
# Keep container running for debugging
molecule converge -s default

# Connect to test container
molecule login -s default

# Run specific verification
molecule verify -s default

# Clean up
molecule destroy -s default
```

## Test Data and Fixtures

### Test User Configuration
- **Username**: `molecule`
- **Home Directory**: `/home/molecule`
- **Groups**: `wheel` (for sudo access)
- **Shell**: `/bin/bash`

### Mock Environment Variables
```bash
USER=molecule
HOME=/home/molecule
ANSIBLE_USER_ID=molecule
```

### Test Package Lists
Tests use minimal package lists to reduce execution time while maintaining coverage.

## Performance Considerations

### Test Optimization
- Docker layer caching for faster container startup
- Minimal package installation in test scenarios
- Parallel test execution where possible
- Skip AUR packages in CI (time-intensive)

### Resource Usage
- **Memory**: ~2GB per container
- **Disk**: ~1GB per test scenario
- **Time**: ~5-10 minutes per scenario

## Troubleshooting

### Common Issues

#### Docker Permission Errors
```bash
# Add user to docker group
sudo usermod -aG docker $USER
# Log out and back in
```

#### Molecule Container Issues
```bash
# Clean up all containers
molecule destroy -s default
docker system prune -f
```

#### Package Installation Failures
- Check internet connectivity in container
- Verify package names in defaults/main.yml
- Review pacman mirror configuration

### Test Environment Issues
```bash
# Reset test environment
molecule destroy -s default
molecule dependency -s default
molecule create -s default
```

## Contributing to Tests

### Adding New Tests
1. Add verification tasks to `molecule/*/verify.yml`
2. Update test scenarios in `molecule/*/molecule.yml`
3. Add integration tests to `tests/`
4. Update this documentation

### Test Guidelines
- Each feature should have corresponding verification
- Tests should be idempotent and isolated
- Use descriptive assertion messages
- Include both positive and negative test cases
- Document any special test requirements

### Review Checklist
- [ ] All new features have tests
- [ ] Tests pass in all scenarios
- [ ] Documentation updated
- [ ] CI pipeline passes
- [ ] Performance impact considered