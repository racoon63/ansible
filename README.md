# Ansible

Ansible is an open-source software provisioning, configuration management, and application deployment tool. It comes with several modules to interact with a large number of services. The config files of ansible are called playbooks and will be written in YAML file format.
This repository is for learning purpose and for different use cases that are categoized within directories.

[Documentation](https://docs.ansible.com/ansible/latest/index.html)

## Best practices

* Use the latest Ansible version to keep your playbooks and roles up-to-date.
* Always implement execution command in playbook, role or in README.
* Use small, readable tasks and extract into Ansible roles (
  * If line count > 100. Use: `include_tasks` statement.
  * Roles have to be independent.
* Test early and often
  * Use CI/CD pipelines. Use Integration tests with e.g. GitLab-CI, Travis-CI, ...
  * [yamllint](https://yamllint.readthedocs.io/en/stable/quickstart.html)
  * ansible-playbook --syntax-check
  * [ansible-lint](https://github.com/ansible/ansible-lint)
  * Try to test in parallel as much as you can
* Track and fix `DEPRECATION WARNING`s
* Remove unnecessary `WARN` messages (if you know they are needless)
* Use 2 or less filter/conditons per task. "YAML is not a programming languaga" - Jeff Geerling
* Use flat variable names instead of: `apache -> maxclients`. Do it like: `apache_maxclients`
* Disable `gather_facts` wherever possible
* Try to `fork` as much as possible to increase performance of deployment
* If a task takes more than a couple of seconds, try to find other modules
* Use extra callback plugins by using `callback_whitelist` option under `defaults` in your `ansible.cfg`
  * e.g. `callback_whitelist = profile_roles, profile_tasks, timer`

## Available Examples

* Create a new VM with VMware ESXi, vCenter and Ansible
* Create VM from given Template on vCenter
* Prepare VM/target host for ansible via ssh
* Dockerfile to create docker image to exercise with ansible

## Planned Examples

* automated update from Templates on latest OS versions (RHEL, Centos, Fedora, Debian)
* automated installation of docker hosts (manager or workers) (on RHEL, Centos, Fedora, Debian)