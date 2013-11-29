# == Class: scribble::params
#
# The scribble::params class provides some sensible defaults for others classes
# and isn't supposed to be declared by itself.
#
# === Authors
#
# Andy Shinn <andys@andyshinn.as>
#
# === Copyright
#
# Copyright 2013 Andy Shinn
#
class scribble::params {
  $package_name = 'scribble'
  $service_name = 'scribble'
  $config_file = '/etc/scribed/logs.conf'
  $default_category = 'default'
}
