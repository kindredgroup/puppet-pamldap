# == Class: pamldap
#
# Common configuration for all supported OS families
#
# === Parameters
#
# [*ldap_base*]
#   Base search DN
#
# [*ldap_binddn*]
#   LDAP distinguished name to bind to the server with
#
# [*ldap_bindpw*]
#   LDAP credentials to bind with
#
# [*ldap_scope*]
#   LDAP search scope (e.g. sub)
#
# [*ldap_timelimit*]
#   LDAP search timelimit 
#
# [*ldap_bind_timelimit*]
#   LDAP bind/connect timelimit
#
# [*ldap_bind_policy*]
#   LDAP reconnect policy: hard (default) will retry connecting to
#   the software with exponential backoff, soft will fail # immediately
#
# [*ldap_idle_timelimit*]
#   LDAP idle timelimit; client will close connections 
#
# [*ldap_nss_initgroups_ignoreusers*]
#   Just assume that there are no supplemental groups for these named users
#
# [*ldap_referrals*]
#   Answer whether LDAP referrals are allowed
#
# [*kdcs*]
#   An array of key distribution center servers
#
# [*krb_realm*]
#   Kerberos5 realm name
#
# [*krb_domain*]
#   Kerberos5 domain name
#
# [*krb_pam_ticket_lifetime*]
#   Kerberos5 pam.d default credential lifetime, in seconds
#
# [*krb_pam_renew_lifetime*]
#   Kerberos5 pam.d default renewable lifetime, in seconds
#
# [*krb_pam_debug*]
#   Kerberos5 pam.d debugging switch
#
# [*krb_pam_forwardable*]
#   Kerberos5 pam.d control whether or not credentials are forwardable
#
# [*krb_pam_validate*]
#   Kerberos5 pam.d setting for whether or not to attempt validation of the TGT using the local keytab
#
# [*krb_pam_krb4_convert*]
#   Kerberos5 pam.d setting for whether to convert Kerberos4 tickets
#
# [*krb_pkinit_allow_pkinit*]
#   Kerberos5 pam.d pkinit allowance switch
#
# [*krb_dns_lookup_realm*]
#   Kerberos5 pam.d allowance trigger for DNS records for fallback host-to-realm mappings lookup
#
# [*krb_dns_lookup_kdc*]
#   Kerberos5 pam.d switch to indicate whether DNS SRV records should be used to locate the KDCs and other servers for a realm
#
# [*packages*]
#   Required packages to be installed. OS family depended.
#
# === Examples
#
#  class { 'pamldap':
#    ldap_base  => 'dc=example,dc=com',
#    krb_realm  => 'EXAMPLE.COM',
#    krb_domain => 'example.com',
#    kdcs       => ['10.7.96.13', '10.7.96.14'],
#  }
#
# === Authors
#
# Ilja Bobkevic <ilja.bobkevic@unibet.com>
#
# === Copyright
#
# Copyright 2015 North Development AB
#
class pamldap (
  $ldap_base                       = $pamldap::params::ldap_base,
  $ldap_binddn                     = $pamldap::params::ldap_binddn,
  $ldap_bindpw                     = $pamldap::params::ldap_bindpw,
  $ldap_scope                      = $pamldap::params::ldap_scope,
  $ldap_timelimit                  = $pamldap::params::ldap_timelimit,
  $ldap_bind_timelimit             = $pamldap::params::ldap_bind_timelimit,
  $ldap_bind_policy                = $pamldap::params::ldap_bind_policy,
  $ldap_idle_timelimit             = $pamldap::params::ldap_idle_timelimit,
  $ldap_nss_initgroups_ignoreusers = $pamldap::params::ldap_nss_initgroups_ignoreusers,
  $ldap_referrals                  = $pamldap::params::ldap_referrals,
  $kdcs                            = $pamldap::params::kdcs,
  $krb_realm                       = $pamldap::params::krb_realm,
  $krb_domain                      = $pamldap::params::krb_domain,
  $krb_pam_ticket_lifetime         = $pamldap::params::krb_pam_ticket_lifetime,
  $krb_pam_renew_lifetime          = $pamldap::params::krb_pam_renew_lifetime,
  $krb_pam_debug                   = $pamldap::params::krb_pam_debug,
  $krb_pam_forwardable             = $pamldap::params::krb_pam_forwardable,
  $krb_pam_validate                = $pamldap::params::krb_pam_validate,
  $krb_pam_krb4_convert            = $pamldap::params::krb_pam_krb4_convert,
  $krb_pkinit_allow_pkinit         = $pamldap::params::krb_pkinit_allow_pkinit,
  $krb_dns_lookup_realm            = $pamldap::params::krb_dns_lookup_realm,
  $krb_dns_lookup_kdc              = $pamldap::params::krb_dns_lookup_kdc,
  $packages                        = $pamldap::params::packages,
) inherits pamldap::params {

  package {$packages: }

  # NSSWITCH
  file { '/etc/nsswitch.conf':
    owner   => root,
    group   => root,
    mode    => '0444',
    content => template("${module_name}/nsswitch.conf.erb");
  }

  # KRB5
  file { '/etc/krb5.conf':
    owner   => root,
    group   => root,
    mode    => '0444',
    content => template("${module_name}/krb5.conf.erb");
  }

  # LDAP
  file { '/etc/ldap.conf':
    owner   => root,
    group   => root,
    mode    => '0444',
    content => template("${module_name}/ldap.conf.erb");
  }

  # To avoid passing variables back and forth setup sssd here
  if $::osfamily == 'Redhat' and $::operatingsystemmajrelease >= '6' {
    # PAM
    file { '/etc/pam.d/password-auth-ac':
      owner  => root,
      group  => root,
      mode   => '0444',
      source => "puppet:///modules/${module_name}/redhat/password-auth-ac";
    }

    # SSSD
    file { '/etc/sssd/sssd.conf':
      owner   => root,
      group   => root,
      mode    => '0600',
      content => template("${module_name}/sssd.conf.erb"),
      require => Package['sssd'],
    }

    service { 'sssd':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => Package['sssd'],
      subscribe  => File['/etc/sssd/sssd.conf'],
    }
  }

  $osfamily_lowercase = downcase($::osfamily)

  anchor {'pamldap::start': } ->
  class { "${module_name}::${osfamily_lowercase}": } ->
  anchor {'pamldap::stop': }
}
