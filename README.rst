Puppet-dhcpd
============

The dhcpd modules provides a base class ``dhcpd`` 

This module have been tested and used on CentOS 5.x

**dhcpd** (*class*)
  Installs the ``dhcpd`` package and manages its configuration

  Example::

    node dhcpd.example.internal {
      include dhcpd
    }

