# Config

Configuration of various hosts in my life using ansible

## In Use Modules

-   https://docs.ansible.com/ansible/latest/user_guide/vault.html
-   https://docs.ansible.com/ansible/latest/collections/ansible/builtin/copy_module.html
-   https://docs.ansible.com/ansible/latest/collections/ansible/posix/mount_module.html
-   https://docs.ansible.com/ansible/latest/collections/ansible/builtin/systemd_module.html
-   https://docs.ansible.com/ansible/latest/collections/ansible/builtin/apt_repository_module.html
-   https://docs.ansible.com/ansible/latest/collections/ansible/builtin/apt_key_module.html
-   https://docs.ansible.com/ansible/latest/collections/ansible/builtin/apt_module.html
-   https://docs.ansible.com/ansible/latest/collections/ansible/builtin/user_module.html
-   https://docs.ansible.com/ansible/latest/collections/ansible/builtin/shell_module.html
-   https://docs.ansible.com/ansible/latest/collections/ansible/builtin/git_module.html
-   https://docs.ansible.com/ansible/latest/collections/community/general/yarn_module.html

## Interesting reading for next steps:

-   https://yetiops.net/posts/proxmox-terraform-cloudinit-saltstack-prometheus/

## Grab bag of important things

-   copy the devnet password to ~/.erisyon_ansible_pass
-   use `--ask-become-pass` when conditioning computers
-   always keep the hosts encrypted

### Examples

```
# decrypt hosts
poetry run ansible-vault decrypt hosts_enc.yml --output hosts.yaml --vault-password-file ~/.erisyon_ansible_pass

# if you change hosts in the decrypted version, remember to re-encrypt and commit the change
poetry run ansible-vault encrypt hosts.yaml --output hosts_enc.yml --vault-password-file ~/.erisyon_ansible_pass

# run playbook for all development computers
poetry run ansible-playbook development.yml --check --ask-become-pass

# install galaxy things
poetry run ansible-galaxy install -r requirements.yaml
```

## Tags

|     tag name      | notes                                     |
| :---------------: | ----------------------------------------- |
|  `ssh/password`   | disables password auth over ssh           |
| `projects/common` | installs common tools related to projects |
|  `users/ossareh`  | creates the ossareh user                  |

## Debugging

Use the `-v` flag to `ansible-playbook` to see what's happening when things don't work
