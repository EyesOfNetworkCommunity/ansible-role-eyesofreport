Role Variables
==============

Common variables:
-----------------

| variable name | defaults | description |
|:---|:---:|:---|
| eor_install_path     | /srv/eyesofreport | The base installation directory for EOR |
| eor_tmp_install_path | /tmp/eor-install | The temporary folder where Ansible role will store ephemerous data during installation. This directory will be deleted at the end of the role execution |
| cleanup_install_files | true | a switch that allows to inhibit the cleanup of **eor_tmp_install_path** directory at the end of the role execution |
| eorweb_git.repo | https://github.com/eric-belhomme/eorweb.git | The location of **eorweb** Git repository |
| eorweb_git.release | master | The eorweb Git branch/tag to pull from the Git repository |

Third party software packages:
------------------------------

If you put 3rd part packages into **files/3rd_party** directory as described in [3rd party README](files/3rd_party/README.md) file, these variables will only be used to deduce package filename (by using _basename_ filter)

So the filename part of each xxx.**uri** variable must match you file naming convention !

| variable name | defaults | description |
|:---|:---|:---|
| pkg_pentaho.uri | https://sourceforge.net/projects/pentaho/files/Data%20Integration/5.4/pdi-ce-5.4.0.1-130.zip | URL of upstream download link for Pentaho project |
| pkg_pentaho.sum | sha256:240e72e2227f1e3e4c7b7173a42157a1ba0ef0e2055ffa3122d2f633ca9e14c6 | Pentaho package checksum |
| pkg_wildfly.uri | http://download.jboss.org/wildfly/9.0.2.Final/wildfly-9.0.2.Final.zip | URL of upstream download link for Wildfly project |
| pkg_wildfly.sum | sha256:5872edb16ed968ecbf4446f74eff158f91add47ec28484b8768880cb5c149ad2 | Wildfly package checksum |
| pkg_jdk.uri | /mnt/ansible_repo/oracle/java/jdk-7u80-linux-x64.rpm | location on filesystem of Oracle Java JDK RPM package |
| pkg_jdk.sum | sha256:405d5fb7fa8cc4b5e5fe2c5fa349af6fbd742d9967772163d1fa8ea4ce35cd7b | Oracle Java JDK RPM package checksum |
| pkg_birt.uri | http://download.eclipse.org/birt/downloads/drops/R-R1-4_5_0-201506092134/birt-runtime-4.5.0-20150609.zip | URL of upstream download link for BIRT project |
| pkg_birt.sum | sha512:375f8022ab082909a6ddbccc70e4e23648fa91e68ea599bee343a8439e3e1ea8591a442dacf6cd959a7bc... | Pentaho BIRT checksum |
| pkg_mysqljdbc.uri | https://downloads.mysql.com/archives/get/file/mysql-connector-java-5.1.45.tar.gz | URL of upstream download link for Mysql JDBC connector |
| pkg_mysqljdbc.sum | 'sha256:1d289a056c7eb8290108a8d2e3c4717193662a9171adb56cfa3b769b32de3300 | Mysql JDBC connector package checksum |

Docker images:
--------------

See  [3rd party README](files/3rd_party/README.md) if you wish to provide local Docker image instead of pulling images from docker.io Hub

| variable name | defaults | description |
|:---|:---:|:---|
| docker_image_centos  | 7.1.1503 | Docker image tag to pull for **centos** image |
| docker_image_busybox | 1.29.1   | Docker image tag to pull for **busybox** image |