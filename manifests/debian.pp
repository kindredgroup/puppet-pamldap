# == Class: pamldap::debian
#
# Debian family related configuration
#
# === Examples
#
#  include pamldap::debian
#
# === Authors
#
# Ilja Bobkevic <ilja.bobkevic@unibet.com>
#
# === Copyright
#
# Copyright 2015 North Development AB
#
class pamldap::debian {

  file { '/etc/pam.d/common-session':
    owner  => root,
    group  => root,
    mode   => '0444',
    source => "puppet:///modules/${module_name}/debian/common-session";
  }

  file { '/etc/pam.d/common-auth':
    owner  => root,
    group  => root,
    mode   => '0444',
    source => "puppet:///modules/${module_name}/debian/common-auth";
  }

  file { '/etc/pam.d/common-account':
    owner  => root,
    group  => root,
    mode   => '0444',
    source => "puppet:///modules/${module_name}/debian/common-account";
  }

  file { '/etc/pam.d/sudo':
    owner  => root,
    group  => root,
    mode   => '0444',
    source => "puppet:///modules/${module_name}/debian/sudo";
  }

  file { '/etc/libnss-ldap.conf':
    ensure => link,
    target => '/etc/ldap.conf',
  }

}
