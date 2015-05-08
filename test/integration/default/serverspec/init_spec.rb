require 'spec_helper'

describe file('/etc/krb5.conf') do
  its(:content) { should match /EXAMPLE\.COM = {/ }
  its(:content) { should match /default_domain = example\.com/ }
  its(:content) { should match /default_realm = EXAMPLE\.COM/ }
  its(:content) { should match /example\.com = EXAMPLE\.COM/ }
  its(:content) { should match /kdc = bogus_kdc\.example\.com/ }
end

describe file('/etc/ldap.conf') do
  its(:content) { should match /base dc=example,dc=com/ }
  its(:content) { should match /binddn cn=root,ou=users/ }
  its(:content) { should match /bindpw bogus_passwd/ }
  its(:content) { should match /uri ldap:\/\/bogus_kdc\.example\.com\// }
end
