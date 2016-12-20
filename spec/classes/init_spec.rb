require 'spec_helper'
describe 'pe_repo_posix_regexp_fix' do
  context 'with default values for all parameters' do
    it { should contain_class('pe_repo_posix_regexp_fix') }
  end
end
