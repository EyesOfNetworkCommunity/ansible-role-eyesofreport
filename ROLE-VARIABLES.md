Role Variables
==============

Common variables:
-----------------

| variable name | defaults | description |
|:---|:---:|:---|
| eor_install_path     | /srv/eyesofreport | The base installation directory for EOR |
| eor_archive_path     | /var/archive/eyesofreport | The path where Pentaho report are archived |
| eor_tmp_install_path | /tmp/eor-install | The temporary folder where Ansible role will store ephemerous data during installation. This directory will be deleted at the end of the role execution |
| cleanup_install_files | true | a switch that allows to inhibit the cleanup of **eor_tmp_install_path** directory at the end of the role execution |
| eorweb_git.repo | https://github.com/eric-belhomme/eorweb.git | The location of **eorweb** Git repository |
| eorweb_git.release | master | The eorweb Git branch/tag to pull from the Git repository |
| tcp_ports.mysql[0] | 3306 | one item list for MariaDB listening port |
| tcp_ports.pentaho[0] | 8181 | one item list for Pentaho listening port |
| tcp_ports.wildfly[0] | 8080 | two items list for Wildfly listening ports - item 0 is application listening port |
| tcp_ports.wildfly[1] | 9990 | two items list for Wildfly listening ports - item 1 is Wildfly's admin listening port |
| tcp_ports.httpd[0] | 80 | two items list for Apache HTTPd listening ports - item 0 is standard HTTP listening port |
| tcp_ports.httpd[1] | 443 | two items list for Apache HTTPd listening ports - item 1 is standard HTTPS listening port |
| eor_smtp.relay | 127.0.0.1 | IP address of SMTP relay to be used by EOR. **beware:** altrough localhost is used as defaut, configuring a local MTA is out of scope of this role ! |
| eor_smtp.port | 25 | Listen port of SMTP relay. Currently SMTP auth and/or SSL/SASL is not supported |
| eor_repot_mail_recipients | eor@eyesofnetwork.net.invalid | a list of email recipients to receive Pentaho reports by email |

Third party software packages:
------------------------------

If you put 3rd part packages into **files/3rd_party** directory as described in [3rd party README](files/3rd_party/README.md) file, these variables will only be used to deduce package filename (by using _basename_ filter)

So the filename part of each xxx.**uri** variable must match you file naming convention !

| variable name | defaults | description |
|:---|:---|:---|
| pkg_pentaho.uri   | https://sour... | URL of upstream download link for Pentaho project |
| pkg_pentaho.sum   | sha256:240e7... | Pentaho package checksum |
| pkg_wildfly.uri   | http://downl... | URL of upstream download link for Wildfly project |
| pkg_wildfly.sum   | sha256:5872e... | Wildfly package checksum |
| pkg_jdk.uri       | /mnt/ansible... | location on filesystem of Oracle Java JDK RPM package |
| pkg_jdk.sum       | sha256:405d5... | Oracle Java JDK RPM package checksum |
| pkg_birt.uri      | http://downl... | URL of upstream download link for BIRT project |
| pkg_birt.sum      | sha512:375f8... | Pentaho BIRT checksum |
| pkg_mysqljdbc.uri | https://down... | URL of upstream download link for Mysql JDBC connector |
| pkg_mysqljdbc.sum | sha256:1d289... | Mysql JDBC connector package checksum |

Variable defaults are intentionally elipsized. see [default](defaults/main.yml) variable YaML file for reference.

Docker images:
--------------

See  [3rd party README](files/3rd_party/README.md) if you wish to provide local Docker image instead of pulling images from docker.io Hub

| variable name | defaults | description |
|:---|:---:|:---|
| docker_image_centos  | 7.1.1503 | Docker image tag to pull for **centos** image |
| docker_image_busybox | 1.29.1   | Docker image tag to pull for **busybox** image |

MariaDB specific variables:
---------------------------

| variable name | defaults | description |
|:---|:---:|:---|
| sql.bind | 127.0.0.1 | IP address where the MariaDB server is listening |
| sql.db.bp_global | global_nagiosbp | The database name for **golbal nagios BP** |
| sql.db.bp_lilac | bp_group_lilac | The database name for **Lilac BP groups** |
| sql.db.thruk | thruk | The database name for **thruk** |
| sql.db.ods | eor_ods | The database name for **EOR's ODS** |
| sql.db.dwh | eor_dwh | The database name for **EOR's DWH** |
| sql.db.technical | eyesofreport | The database name for **technical EOR** |
| sql.db.repository | eor_repository | The database name for **EOR repository** |
| sql.db.eorweb | eorweb | The database name for **eorweb** |
| sql.db.dashbuilder | dashbuilder | The database name for **Dashbuilder** |
| sql_internal_user     | eyesofreport | SQL username for internal access |
| sql_internal_pwd | - | SQL password for internal access |
| sql_external_user     | eyesofreport | SQL username for external access |
| sql_external_pwd | - | SQL password for external access |
