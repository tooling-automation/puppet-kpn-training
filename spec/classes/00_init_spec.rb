# frozen_string_literal: true

require 'spec_helper'

describe 'pdk_training' do
  on_supported_os.each do |os, facts|
    context "when on #{os} with defaults" do
      let(:facts) { facts }

      case os
      when %r{redhat}
        it { is_expected.to contain_class('pdk_training::linux::install') }
        it { is_expected.to contain_file('/usr/local/sbin/pdk_training').with_ensure('directory') }
      when %r{windows}
        it { is_expected.to contain_class('pdk_training::windows::install') }
        it { is_expected.to contain_file('c:/Management/pdk_training').with_ensure('directory') }
      end
    end
  end
end
