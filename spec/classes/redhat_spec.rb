require 'spec_helper'

describe 'pamldap::redhat' do
  context 'with defaults for all parameters' do
    it { should compile.with_all_deps }
    %w(/etc/pam.d/system-auth-ac /etc/pam.d/sshd /etc/pam_ldap.conf /etc/pam.d/system-auth).each do |file|
      it { should contain_file(file) }
    end
  end
end
