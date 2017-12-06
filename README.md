[![Build Status](https://travis-ci.org/m4rcu5nl/ansible-role-common.svg?branch=master)](https://travis-ci.org/m4rcu5nl/ansible-role-common) [![GitHub issues](https://img.shields.io/github/issues/m4rcu5nl/ansible-role-common.svg)](https://github.com/m4rcu5nl/ansible-role-common/issues)

Common
======
Ansible role containing some common server config tasks.

* Set the hostname
* Set the timezone
* Set resolving nameservers (optional)
* Install some packages (optional)
* Add custom group(s) (optional)
* Configure sudoers for custom group(s) (optional)
* Add user(s) (optional)

Current version is build for and tested on CentOS 7. Though apart from installing the Epel repository (which is wrapped in an `ansible_distribution` conditional) I don't see a reason why this role should not also work for Ubuntu/Debian, really.

Role variables
--------------
### common_hostname
The variable name should be self-explanatory.    
Default: Extracts value from `{{ inventory_hostname }}`

### common_timezone
The variable name should be self-explanatory.    
Default: Europe/Amsterdam

### common_resolvers
A dictionary containing a primary and secondary resolving nameserver for your server. If not set or only 1 nameserver is given nothing will happen. Example below uses Google's public DNS servers

```yaml
    ---
    common_resolvers:
      primary: { addr: '8.8.8.8'}
      secondary: { addr: '8.8.4.4'}
```

### common_packages
A list of packages and their state. Packages should be in standard repo or Epel and require no additional configuration. Some good examples are Vim, Tmux, Fish, Git, etc..

```yaml
    ---
    common_packages:
      - { name: 'vim', state: 'present' }
      - { name: 'tmux', state: 'present' }
```

### common_groups
A list of groups to be added and optionally their respective sudoers entry.

```yaml
    ---
    common_groups:
      - { name: 'superheroes', state: 'present', sudoers: 'ALL=(ALL) NOPASSWD: ALL' }
      - { name: 'sidekicks', state: 'present', sudoers: 'ALL=(ALL:ALL)' }
      - { name: 'minions', state: 'present' }
      - { name: 'villains', state: 'absent' }
```

### common_users
A list of per-user dictionaries containing the following:

* user name (required)
* state (required)
* additional groups
* default shell
* ssh\_authorized\_key

The shell defaults to '/bin/bash'. If you specify an alternative one here, don't forget to make sure it's present by using _common\_packages_.

```yaml
    ---
    common_users:
      - { name: 'batman', state: 'present', groups: 'superheroes', shell: '/usr/bin/fish', sshkey: 'https://m4rcu5.keybase.pub/.ssh/marcus.pub' }
      - { name: 'robin', state: 'present', groups: 'sidekicks', sshkey: 'robinspublicsshkeyasastring' }
      - { name: 'johnd', state: 'present' }
```

### setrootpass (optional and highly experimental)
#### Requirements on host running Ansible:
* pass ([passwordstore.org](https://www.passwordstore.org/))
* pwgen
* mkpasswd

When this variable has value `True` (string) then a password and it's hash are generated and stored in the passwordstore on the host running this role. This newly generated password will be set as password for root on the remote host you run this role against. IF you leave this variable unset, the tasks will simply be skipped.
