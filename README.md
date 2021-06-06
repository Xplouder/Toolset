<p align="center">
  <img src=".github/logo.png">
</p>

<p align="center">
  <a href="https://github.com/Xplouder/Toolset/actions"><img alt="CI" src="https://github.com/Xplouder/Toolset/workflows/CI/badge.svg"></a>
</p>

Toolset
=========

Just a quick way to install the tools (cli and gui) and dotfiles for daily basis in an unix distribution.

Requirements
------------

None.

Role Variables
--------------

Take a look at `defaults/main.yaml` to find which software is installed by default.

Dependencies
------------

None.

Examples
----------------

- #### Playbook

    ```yaml
    - hosts: localhost
      become: true
      roles:
        - xplouder.toolset
    ```

- #### Ad-Hoc usage

  `ansible localhost -bK -m include_role -a name=xplouder.toolset`

  ```
  ANSIBLE_LOAD_CALLBACK_PLUGINS=1 ANSIBLE_STDOUT_CALLBACK=yaml ANSIBLE_ROLES_PATH=$(dirname $(pwd)) ansible localhost -bK -c local -m include_role -a name=$(basename $(pwd))
  ```

- #### Easy install

  In order to ease the objective of this role, there is a small script to install everything needed automatically, all
  you need is python installed. just run the following command.

  `git clone <repository_url> toolset && cd toolset && ./install.sh`

License
-------

MIT

TODO
-------

- correct `oh-my-zh` setup
