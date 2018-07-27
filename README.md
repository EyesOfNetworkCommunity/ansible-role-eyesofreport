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
- Eclipse BIRT 4.5 (can be downloaded from upstream provider, or be present on a local repo)
- Hitachi Pentaho data integration (can be downloaded from upstream provider, or be present on a local repo)

Role Variables
--------------

All variables are defaulted into defaults/main.yml file.

Detailled description of used varaibles is available in [ROLE-VARIABLE](ROLE-VARIABLES.md) file.

Dependencies
------------

The following role is an optional dependency:
  - ansible-role-snmpd (git@gitlab.cloudbuilder.axians.com:ansible/ansible-role-snmpd.git)

Example Playbook
----------------

Simply invoke ansible-role-eyesofreport :)

See on tests/directory for an example playbook

License
-------

This is [GNU Lesser General Public License 3.0](lgpl-3.0.md)

Author Information
------------------

Based on The EyesOfNetwork Community team work:
- [*Mickaël Aubertin*](https://github.com/maubertin/eyesofreport), [*Benoît Village*](https://github.com/benoitvillage/eyesofreport) the EOR's initiators and gurus ;)
- The [*EyesOfNetowrkCommunity*](https://github.com/EyesOfNetworkCommunity) members, who maintain and enhance the **EOR** application
- [*Eric Belhomme*](https://github.com/eric-belhomme), who develop and maintain this *Ansible role*

ToDo tasks
----------

Many tasks still pending:
- create dedicated users for Pentaho and Wildfly
- remove hardcoded dependencies to /srv/eyeofreport and /srv/eyesofnetwork paths (especially on eorweb)
- etc. 