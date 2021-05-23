#!/usr/bin/env bash

set -eux

python -m pip install --user ansible docker

export ANSIBLE_LOAD_CALLBACK_PLUGINS=1
export ANSIBLE_STDOUT_CALLBACK=yaml
current_dir_name="$(dirname "$(pwd)")"
export ANSIBLE_ROLES_PATH=$current_dir_name

ansible localhost -bK -c local -m include_role -a name="$(basename "$(pwd)")"
