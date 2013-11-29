require 'spec_helper'

describe 'scribble::log', :type => :define do
  let :facts do
    {
      :osfamily               => 'CentOS',
      :operatingsystemrelease => '6',
      :concat_basedir         => '/trollface',
    }
  end

  context 'with file and category set' do
    let :params do
      {
        :file     => '/var/log/messages',
        :category => 'messages',
      }
    end

    let :title do
      'somemessageslog'
    end

    it { should include_class('scribble') }

    it { should contain_concat__fragment('somemessageslog').with(
      'target' => '/etc/scribed/logs.conf',
      'content' => /^messages \/var\/log\/messages$/
      )
    }
  end

  context 'with only title set as filename' do
    let :title do
      '/var/log/httpd/error_log'
    end

    it { should include_class('scribble') }

    it { should contain_concat__fragment('/var/log/httpd/error_log').with(
      'target' => '/etc/scribed/logs.conf',
      'content' => /^default \/var\/log\/httpd\/error_log$/
      )
    }
  end
end
