# == Define: scribble::log
#
# Add a line to the logs.conf file for category and log file. Scribble will
# poll this log file and send the data to scribed as the set category name.
#
# === Parameters
#
# Document parameters here.
#
# [*file*]
#   The file parameter is the location of the file on disk to poll.
#
# [*category*]
#   The category to be associated with the polled log file. The default is set
#   to 'default'.
#
# === Examples
#
#  scribble::log { 'messages'
#    file     => '/var/log/messages',
#    category => 'messages',
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
define scribble::log (
  $file = $title,
  $category = 'default'
) {
  include scribble

  concat::fragment { $title:
    target  => $scribble::config_file,
    content => "${category} ${file}"
  }
}
