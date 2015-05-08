class {'::pamldap':
  ldap_base                       => 'dc=example,dc=com',
  ldap_binddn                     => 'cn=root,ou=users',
  ldap_bindpw                     => 'bogus_passwd',
  ldap_nss_initgroups_ignoreusers => 'vagrant',
  krb_realm                       => 'EXAMPLE.COM',
  krb_domain                      => 'example.com',
  kdcs                            => ['bogus_kdc.example.com'],
}
