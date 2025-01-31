# frozen_string_literal: true

require 'spec_helper_acceptance'
require 'facter'

describe 'pdk_training class' do
  context 'with default parameters' do
    # Using puppet_apply as a helper
    it 'works idempotently with no errors' do
      pp = <<-PP
      include ::pdk_training
      PP

      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end
  end
end
