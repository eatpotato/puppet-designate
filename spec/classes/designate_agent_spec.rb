#
# Unit tests for designate::agent
#
require 'spec_helper'

describe 'designate::agent' do
  let :params do
    {
      :enabled => true
    }
  end

  shared_examples 'designate-agent' do
    context 'with default parameters' do
      it 'installs designate-agent package and service' do
        should contain_service('designate-agent').with(
          :name      => platform_params[:agent_service_name],
          :ensure    => 'running',
          :enable    => 'true'
        )
        should contain_package('designate-agent').with(
          :name      => platform_params[:agent_package_name],
          :ensure    => 'installed'
        )
      end

      it 'configures designate-agent with default parameters' do
        should contain_designate_config('service:agent/backend_driver').with_value('bind9')
      end

      context 'when using Power DNS backend driver' do
        before { params.merge!(:backend_driver => 'powerdns') }
        it 'configures designate-agent with pdns backend' do
          should contain_designate_config('service:agent/backend_driver').with_value('powerdns')
        end
      end
    end
  end

  context 'on Debian platforms' do
    let :facts do
      { :osfamily => 'Debian' }
    end

    let :platform_params do
      {
        :agent_package_name => 'designate-agent',
        :agent_service_name => 'designate-agent'
      }
    end

    it_configures 'designate-agent'
  end

  context 'on RedHat platforms' do
    let :facts do
      { :osfamily => 'RedHat' }
    end

    let :platform_params do
      {
        :agent_package_name => 'openstack-designate-agent',
        :agent_service_name => 'openstack-designate-agent'
      }
    end

    it_configures 'designate-agent'
  end
end
