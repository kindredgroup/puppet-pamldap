require 'puppetlabs_spec_helper/module_spec_helper'

# add default facts here
RSpec.configure do |c|
  c.default_facts = {
    :processorcount             => '1',
    :osfamily                   => 'RedHat',
    :operatingsystem            => 'RedHat',
    :operatingsystemmajrelease  => '6',
    :operatingsystemminrelease  => '6',
    :operatingsystemrelease     => '6.6',
    :architecture               => 'x86_64'
  }
end

# coverage report
at_exit { RSpec::Puppet::Coverage.report! }
