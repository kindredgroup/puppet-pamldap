# == Class: pamldap::redhat
#
# Redhat family related configuration
#
# === Examples
#
#  include pamldap::redhat
#
# === Authors
#
# Ilja Bobkevic <ilja.bobkevic@unibet.com>
#
# === Copyright
#
# Copyright 2015 North Development AB
#
class pamldap::redhat {

  file { '/etc/pam.d/system-auth-ac':
    owner  => root,
    group  => root,
    mode   => '0444',
    source => "puppet:///modules/${module_name}/redhat/system-auth-ac";
  }

  file { '/etc/pam.d/sshd':
    owner  => root,
    group  => root,
    mode   => '0444',
    source => "puppet:///modules/${module_name}/redhat/sshd";
  }

  file { '/etc/pam_ldap.conf':
    ensure => link,
    target => '/etc/ldap.conf',
  }

  file { '/etc/pam.d/system-auth':
    ensure => link,
    target => '/etc/pam.d/system-auth-ac'
  }
}
