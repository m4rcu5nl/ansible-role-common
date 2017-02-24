Common
======
Ansible role for some basic tasks suitable for pretty much every (new) server.

* Set the hostname
* Set the timezone
* Install some packages*
* Add custom group(s)
* Configure sudoers for custom group(s)
* Add user(s)

\* Packages should be in distros default repo (or Epel on CentOS)    
    
[![Build Status](https://travis-ci.org/m4rcu5nl/ansible-role-common.svg?branch=master)](https://travis-ci.org/m4rcu5nl/ansible-role-common)

Role variables
--------------
### common_hostname
The variable name should be self-explanatory.    
Default: Extracts value from `{{ inventory_hostname }}`

### common_timezone
The variable name should be self-explanatory.    
Default: Europe/Amsterdam

### common_locale
Generate locale. (I mainly added this to prevent Ubuntu servers from nagging about it)    
Default: en_EN.UTF-8

### common_packages
A list of packages and their state. On CentOS hosts the epel repo will be installed before the packages you list here.     
Example:

    ---
    common_packages:
      - { name: 'vim', state: 'present' }
      - { name: 'tmux', state: 'present' }

Default: Will install Vim. It doesn't hurt to have a decent editor around.

### common_groups
A list of groups to be added and their respective sudoers entry.    
Example:

    ---
    common_groups:
      - { name: 'superheroes', state: 'present', sudoers: 'ALL=(ALL) NOPASSWD: ALL' }

Default: **None** (e.g.: will fail if you do not set this!)

### common_users
A list of dicts containing the username, groups, state, default shell and ssh\_authorized\_key for each user. If any of your users is not using /bin/bash as their default shell, don't forget to add said shell to _common\_packages_.    
Example:

    ---
    common_users:
      - { name: 'batman', groups: 'superheroes', state: 'present', shell: '/bin/bash', sshkey: 'https://m4rcu5.keybase.pub/.ssh/marcus.pub' }

Default: **None** (e.g.: will fail if you do not set this!)
