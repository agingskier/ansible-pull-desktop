# ansible-pull-desktop

Setup ansible roles to provision my desktop.
Eventually this should be used on virtual system "desktop" and my "bequiet".

Before running the ansible-playbook, check yml syntax with:
- ansible-lint local.yml
- fix any possible errors

## base and workstation

There are two roles:
- base
- workstation

Run the roles seperately to have to possibility to fix errors.

### Base
 
[1] Run **ansible-playbook local.yml --limit base**

### Workstation

[1] Run **ansible-playbook local.yml --limit workstation**


