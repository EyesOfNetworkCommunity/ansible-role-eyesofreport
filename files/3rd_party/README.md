Thrid party packages
====================

As Eyes Of Report is built on top of many other third party packages
that are not necessarily included with CentOS for license purpose or
any other reason, we need a way to push these packages on target
host.

These packages aer :
- Oracle Java Development Kit 8
- Java/J connector for MySQL
- Hitachi Pentaho data integration
- Wildfly 9.0
- Eclipse BIRT 4.5

The role can handle 3 different strategies to put these packages on the target host:
1. The package is present in this folder: Then it will be copied on target
2. The package is present from a mountpoint accessible from the Ansible host: Then it will be copied on target
3. The package is referenced as a URI (can be the download link from the upstream project, of an alternate resource): then the package will be downloaded directly from the target host. *This implies the target host __must__ have Internet access*

Docker images
=============

Eyes Of Application have 2 docker images as requirements:
- CentOS 7.1 docker image
- Busybox docker image

The role first try to push a local Docker image archive from role's **files/3rd_party** directory.

The docker image files must follow the naming scheme:

   `docker.io_<image name>_<image tag>.tar.bz2`

Where **image name** is a Docker image name (eg. **centos**) and **image tag** is a Docker image tag (eg. **7.1.1503**)

Example: _docker.io_centos_7.1.1503.tar.bz2_

 This implies the docker image is _bzip2_ compressed.
