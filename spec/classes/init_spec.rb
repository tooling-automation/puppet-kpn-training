# frozen_string_literal: true

require 'spec_helper'
describe 'profile_empty_template' do
  context 'with default values for all parameters' do
    it { is_expected.to contain_class('profile_empty_template') }
  end
end
