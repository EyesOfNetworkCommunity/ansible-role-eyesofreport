Role Name
=========

This role installs a full, working Eyes Of Report on the target host

Requirements
------------

The target host must run an operating system officially supported by EOR. Currently supported OSes are:
- CentOS 7.X
- Red Hat RHEL 7.X

The following extra repositories are needed, either directly from the Internet, or available throught a
Satellite/Foreman/Spacewalk repo:
- EPEL
- EyesOfNetwork

Finally, EOR have extra dependencies for third party software:
- Oracle Java JDK 7u79+ (*MUST* be present on a local repo)
- Java/J connector for MySQL (can be downloaded from upstream provider, or be present on a local repo)
- Wildfly 9.0.X (can be downloaded from upstream provider, or be present on a local repo)
- Hitachi Pentaho data integration (can be downloaded from upstream provider, or be present on a local repo)

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

The following role is required as a dependency:
  - ansible-role-snmpd (git@gitlab.cloudbuilder.axians.com:ansible/ansible-role-snmpd.git)

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
