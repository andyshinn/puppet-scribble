# == Class: scribble
#
# The scribble class install
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { scribble:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Andy Shinn <andys@andyshinn.as>
#
# === Copyright
#
# Copyright 2013 Andy Shinn
#
class scribble (
  $config_file      = $scribble::params::config_file,
  $default_category = $scribble::params::default_category
) inherits scribble::params {

  anchor { 'scribble::begin': } -> Package[$scribble::params::package_name]
  Service[$scribble::params::service_name] -> anchor { 'scribble::end': }

  package { $scribble::params::package_name:
    ensure => installed,
  }

  service { $scribble::params::service_name:
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Concat[$config_file]
  }

  concat { $config_file:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package[$scribble::params::package_name]
  }

  concat::fragment{ 'warning':
    target  => $config_file,
    content => '#This file is managed by Puppet\n',
    order   => '01',
  }
}
