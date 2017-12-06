#!/bin/bash
# Generates new password and it's hash usable as multiline entry for pass (passwordstore.org)
newpass="$(pwgen -s 36 1)" ; printf "%s\nhash:%s\n" "$newpass" "$(echo $newpass | mkpasswd --method=sha-512 -s)"
