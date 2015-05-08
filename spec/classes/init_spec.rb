require 'spec_helper'
describe 'pamldap' do

  context 'with defaults for all parameters' do
    it { should compile.with_all_deps }
  end
end
