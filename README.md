[![Build Status](https://travis-ci.org/m4rcu5nl/ansible-role-common.svg?branch=master)](https://travis-ci.org/m4rcu5nl/ansible-role-common)

Common
======
Ansible role containing some common server config tasks.

* Set the hostname
* Set the timezone
* Add custom group(s)
* Configure sudoers for custom group(s)
* Add user(s)
* Install some packages*

\* Packages should be in default repo (or Epel)    
    
Role variables
--------------
### common_hostname
The variable name should be self-explanatory.    
Default: Extracts value from `{{ inventory_hostname }}`

### common_timezone
The variable name should be self-explanatory.    
Default: Europe/Amsterdam

### common_groups
A list of groups to be added and their respective sudoers entry.    

    ---
    common_groups:
      - { name: 'superheroes', state: 'present', sudoers: 'ALL=(ALL) NOPASSWD: ALL' }

### common_users
A list of dicts containing the username, groups, state, default shell and ssh\_authorized\_key for each user. If any of your users is not using /bin/bash as their default shell, don't forget to add said shell to _common\_packages_.    

    ---
    common_users:
      - { name: 'batman', groups: 'superheroes', state: 'present', shell: '/bin/bash', sshkey: 'https://m4rcu5.keybase.pub/.ssh/marcus.pub' }

### common_packages
A list of packages and their state. Packages should be in standard repo or Epel and require no aditional configuration. Some good examples are Vim, Tmux, Fish, etc..    

    ---
    common_packages:
      - { name: 'vim', state: 'present' }
      - { name: 'tmux', state: 'present' }

