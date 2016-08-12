# Deprecation notice

This module was designed for Puppet versions 2 and 3. It should work also on Puppet 4 but doesn't use any of its features.

The current Puppet 3 compatible codebase is no longer actively maintained by example42.

Still, Pull Requests that fix bugs or introduce backwards compatible features will be accepted.


# Puppet module: mcollective

This is a Puppet module for mcollective based on the second generation layout ("NextGen") of Example42 Puppet Modules.

Made by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-mcollective

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module (you need it even if you don't use and install Puppi)

For detailed info about the logic and usage patterns of Example42 modules check the DOCS directory on Example42 main modules set.

## USAGE - Module specific

The main mcollective class may be configured to install the server agent only, the central client console or the  Stomp server (ActiveMq currently)

* A single class definition (can be used on a common baseline class) that manages stomp credentials and installations of the mcollective ecosystem components, according to custom logic)

        class { 'mcollective':
          stomp_host           => 'mq.example42.com',
          stomp_user           => 'mcollective',
          stomp_password       => 'private_server',
          stomp_admin          => 'admin',
          stomp_admin_password => 'private_client',
          psk                  => 'aSecretPreSharedKey',
          install_client       => $::role ? {
            mco     => true,
            default => false,
          },
          install_stomp_server => $::role ? {
            mq      => true,
            default => false,
          },
        }

Currently only psk security is supported. Client and Servers have different users and passwords to improve (a bit) the security of this approach (an hijacked server can't become a client without knowing the admin username and password).

* Basic setup without plugins installation

        class { 'mcollective':
          install_plugins => false,
        }

* Install mcollective stomp server without including the (needed) dependencies that rely on other Example42 modules.

        class { 'mcollective':
          install_stomp_server => true,
          install_dependencies => false,
        }

* Install mcollective from Puppetlabs repo on Ubuntu (on Ubuntu daemonize option is set to 0 because the service is managed by Upstart, by default is set to 1 for the other distros. If you use Puppetlabs' repo on Ubuntu set explicitely to 1 as init and not upstart is used to manage the service)

        class { 'mcollective':
          daemonize => '1',
        }

## USAGE - Basic management

* Install mcollective with default settings

        class { 'mcollective': }

* Install a specific version of mcollective package

        class { 'mcollective':
          version => '1.0.1',
        }

* Disable mcollective service.

        class { 'mcollective':
          disable => true
        }

* Remove mcollective package

        class { 'mcollective':
          absent => true
        }

* Enable auditing without without making changes on existing mcollective configuration files

        class { 'mcollective':
          audit_only => true
        }

## USAGE - The shellcmd plugin

The bundled [shellcmd plugin](https://github.com/slivarez/mcollective-shellcmd-agent) allows to run shell commands on servers.
It is not deployed by default.
It requires the ruby open4 library that won't be installed by this module.

* Ruby open4 dependency installation example

        package { 'ruby-open4':
          ensure   => 'installed',
          name     => $::osfamily ? {
            'RedHat' => 'open4',
            default  => 'ruby-open4',
          },
          provider => $::osfamily ? {
            'RedHat' => 'gem',
            default  => undef,
          },
        }

* Shellcmd plugin deployment example

        mcollective::plugin { 'shellcmd':
          application    => $::role ? {
            mco     => 'shellcmd.rb',
            default => undef,
          },
          install_client => $::role ? {
            mco     => true,
            default => false,
          },
          install_mode   => '',
          require        => Package['ruby-open4'],
        }

* Usage example

        mco shellcmd 'echo i execute therefore i am'
        mco shellcmd 'ls -l /etc/network/if-up.d' -F 'osfamily=Debian'

## USAGE - Overrides and Customizations
* Use custom sources for main config file

        class { 'mcollective':
          source => [ "puppet:///modules/lab42/mcollective/mcollective.conf-${hostname}" , "puppet:///modules/lab42/mcollective/mcollective.conf" ],
        }


* Use custom source directory for the whole configuration dir

        class { 'mcollective':
          source_dir       => 'puppet:///modules/lab42/mcollective/conf/',
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file. Note that template and source arguments are alternative.

        class { 'mcollective':
          template => 'example42/mcollective/mcollective.conf.erb',
        }

* Automatically include a custom subclass

        class { 'mcollective':
          my_class => 'mcollective::example42',
        }


## USAGE - Example42 extensions management
* Activate puppi (recommended, but disabled by default)

        class { 'mcollective':
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with a puppi::helper define ) to customize the output of puppi commands

        class { 'mcollective':
          puppi        => true,
          puppi_helper => 'myhelper',
        }

* Activate automatic monitoring (recommended, but disabled by default). This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { 'mcollective':
          monitor      => true,
          monitor_tool => [ 'nagios' , 'monit' , 'munin' ],
        }

* Activate automatic firewalling. This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { 'mcollective':
          firewall      => true,
          firewall_tool => 'iptables',
          firewall_src  => '10.42.0.0/24',
          firewall_dst  => $ipaddress_eth0,
        }


## TODO

* Complete spec tests

* Introduce TLS security

* Add extra plugins

[![Build Status](https://travis-ci.org/example42/puppet-mcollective.png?branch=master)](https://travis-ci.org/example42/puppet-mcollective)
