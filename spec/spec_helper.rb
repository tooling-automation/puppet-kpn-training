# frozen_string_literal: true

require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'
# rubocop:disable Style/MixinUsage
include RspecPuppetFacts
# rubocop:enable Style/MixinUsage

add_custom_fact :customer_name, 'kpn'
add_custom_fact :customer_environment, 'development'
add_custom_fact :defaultgatewayinterface_ip, '12.12.12.12'
add_custom_fact :choco_install_path, 'C:\Management\Programs\Chocolatey'
add_custom_fact :chocolateyversion, '0.10.8'

add_custom_fact :os,
                family: 'windows',
                architecture: 'x64',
                hardware: 'x86_64',
                name: 'windows',
                windows: { system32: 'C:\windows\system32' },
                release: { major: '2012 R2', full: '2012 R2' },
                confine: 'windows-2012 R2-x64'

add_custom_fact :os,
                family: 'windows',
                architecture: 'x64',
                hardware: 'x86_64',
                name: 'windows',
                windows: { system32: 'C:\windows\system32' },
                release: { major: '2016', full: '2016' },
                confine: 'windows-2016-x64'

add_custom_fact :os,
                family: 'windows',
                architecture: 'x64',
                hardware: 'x86_64',
                name: 'windows',
                windows: { system32: 'C:\windows\system32' },
                release: { major: '2019', full: '2019' },
                confine: 'windows-2019-x64'

add_custom_fact :kernel, 'windows'

RSpec.configure do |c|
  c.fail_fast = true
  c.hiera_config = File.expand_path(File.join(__FILE__, '../hiera/rspec.yaml'))
  c.before :each do
    # Prevent 'fact "clientversion" already has the maximum number of resolutions allowed (100).' error
    Facter.clear
  end
end

at_exit { RSpec::Puppet::Coverage.report!(100) }
