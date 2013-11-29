require 'spec_helper'

describe 'scribble' do
  let :facts do
    {
      :osfamily               => 'CentOS',
      :operatingsystemrelease => '6',
      :concat_basedir         => '/trollface',
    }
  end

  it { should include_class('scribble::params') }
  it { should contain_package('scribble') }
  it { should contain_concat('/etc/scribed/logs.conf').with(
    'owner'   => 'root',
    'group'   => 'root',
    'mode'    => '0644',
    'require' => 'Package[scribble]'
    )
  }

  it { should contain_concat__fragment('warning').with(
    'target' => '/etc/scribed/logs.conf',
    'content' => /^#This file is managed by Puppet/,
    'order' => '01'
    ) }
end
