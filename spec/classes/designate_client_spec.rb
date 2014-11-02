#
# Unit tests for designate::client
#
require 'spec_helper'

describe 'designate::client' do

  shared_examples 'designate-client' do

    it { should contain_class('designate::params') }

    it 'installs designate client package' do
      should contain_package('python-designateclient').with(
        :ensure => 'present',
        :name   => platform_params[:client_package_name]
      )
    end
  end

  context 'on Debian platforms' do
    let :facts do
      { :osfamily => 'Debian' }
    end

    let :platform_params do
      { :client_package_name => 'python-designateclient' }
    end

    it_configures 'designate-client'
  end

  context 'on RedHat platforms' do
    let :facts do
      { :osfamily => 'RedHat' }
    end

    let :platform_params do
      { :client_package_name => 'python-designateclient' }
    end

    it_configures 'designate-client'
  end
end
