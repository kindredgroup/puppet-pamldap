# == Class: pamldap::params
#
# Params class. See init.pp for description of parameters.
#
class pamldap::params {

  case $::osfamily {
    'Debian': {
      $nsswitch_passwd = 'ldap'
      $nsswitch_group = 'ldap'
      $packages = ['libnss-ldap', 'ldap-utils', 'nscd', 'krb5-user', 'libpam-krb5', 'libpam-cracklib']
    }
    'Redhat': {
      if $::operatingsystemmajrelease < '6' {
        $nsswitch_passwd = 'ldap'
        $nsswitch_group = 'ldap'
        $package_ldap = 'nss_ldap'
      } else {
        $nsswitch_passwd = 'sss'
        $nsswitch_group = 'sss'
        $package_ldap = 'sssd'
      }
      $packages = concat(['pam_krb5', 'krb5-workstation', 'openldap-clients'], $package_ldap)
    }
    default: { fail("Unsupported osfamily: $::{osfamily}") }
  }

  $ldap_base = undef
  $ldap_binddn = undef
  $ldap_bindpw = undef
  $ldap_scope = sub
  $ldap_timelimit = 120
  $ldap_bind_timelimit = 5
  $ldap_bind_policy = soft
  $ldap_idle_timelimit = 3600
  $ldap_nss_initgroups_ignoreusers = undef
  $ldap_referrals = no
  $kdcs = []
  $krb_realm = undef
  $krb_domain = undef
  $krb_pam_ticket_lifetime = 36000
  $krb_pam_renew_lifetime = 36000
  $krb_pam_debug = false
  $krb_pam_forwardable = true
  $krb_pam_validate = false
  $krb_pam_krb4_convert = false
  $krb_pkinit_allow_pkinit = false
  $krb_dns_lookup_realm = true
  $krb_dns_lookup_kdc = true

}
