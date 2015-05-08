require 'spec_helper'

describe 'pamldap::debian' do
  context 'with defaults for all parameters' do
    it { should compile.with_all_deps }
    %w(/etc/pam.d/common-session /etc/pam.d/common-auth /etc/pam.d/common-account /etc/pam.d/sudo /etc/libnss-ldap.conf).each do |file|
      it { should contain_file(file) }
    end
  end
end
