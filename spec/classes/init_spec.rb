require 'spec_helper'
describe 'pe_repo_posix_regexp_fix' do
  let :facts do
    {
      :pe_server_version => '2016.4.2'
    }
  end

  context 'with default values for all parameters' do
    it {
      should contain_class('pe_repo_posix_regexp_fix')
      should contain_file('/opt/puppetlabs/puppet/modules/pe_repo/templates/partials/shared_functions.bash.erb')
    }
  end

  context 'patch does not apply on next release of PE' do
    let :facts do
      {
        :pe_server_version => '2014.4.3'
      }
    end
    it {
      should contain_class('pe_repo_posix_regexp_fix')
      should_not contain_file('/opt/puppetlabs/puppet/modules/pe_repo/templates/partials/shared_functions.bash.erb')
    }
  end

  context 'patch applies on next version of PE if forced' do
    let :facts do
      {
        :pe_server_version => '2014.4.3'
      }
    end
    let :params do
      {
        :force_patch => true,
      }
    end
    it {
      should contain_class('pe_repo_posix_regexp_fix')
      should contain_file('/opt/puppetlabs/puppet/modules/pe_repo/templates/partials/shared_functions.bash.erb')
    }
  end

end
