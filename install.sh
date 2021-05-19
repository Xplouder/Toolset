#!/usr/bin/env bash

set -eux

python -m pip install --user ansible

ansible-galaxy install -f -r requirements.yaml

ansible-playbook -bK playbooks/setup.yaml