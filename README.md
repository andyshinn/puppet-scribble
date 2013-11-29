# puppet-scribble
[![Build Status](https://travis-ci.org/andyshinn/puppet-scribble.png?branch=master)](https://travis-ci.org/andyshinn/puppet-scribble)

This Puppet module installs and configures the [scribble][scribble] daemon. [Scribble][scribble] reads log files and sends them to a local [Scribe][scribe] server.

## Requirements
You need [Scribble][scribble], [Thrift][thrift] (with python support), and [Scribe][scribe] RPMs available.

### Scribble
[Scribble][scribble] does not come with a binary packagex`. You need to build the [Scribble][scribble] RPM and host it yourself. I used Mock with the SCM plugin:

```
mock --scm-enable --scm-option method=git --scm-option package=scribble --scm-option git_get='git clone https://github.com/zxvdr/scribble.git' --scm-option spec='scribble.spec'
```

### Scribe / Thrift
The [Scribble][scribble] RPM depends on [Scribe][scribe] which means you need [Scribe][scribe] RPMs (and consequently, [Thrift][thrift] RPMs). Both [Scribe][scribe] and [Thrift][thrift] provide `spec` files to build RPMs. But I am making assumptions that you already have [Thrift][thrift] and [Scribe][scribe] setup in your environment if you are looking to use [Scribble][scribble].

[scribble]: https://github.com/zxvdr/scribble "Scribble"
[scribe]: https://github.com/facebook/scribe "Scribe"
[thrift]: https://github.com/apache/thrift "Thrift"

## Usage
Declare the the `scribble` class with requirements to your repository containing the required RPMS:

```puppet
yumrepo { 'my_repo':
  baseurl  => 'http://url.to.com/myrepo',
  descr    => 'My Repository',
  enabled  => '1',
  gpgcheck => '0',
}

class { 'scribble':
  require => Yumrepo['my_repo'],
}
```

The `scribble::log` definition takes a `file` and `category` parameter:

```puppet
scribble::log { 'mylog':
  file     => '/var/log/messages',
  category => 'messages',
}
```

The `file` param defaults to the `title` namevar and `category` defaults to `default` so you can also declare a log using:

```puppet
scribble::log { '/var/log/messages': }
```
