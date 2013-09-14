# = Class: mcollective
#
# This is the main mcollective class
#
#
# == Parameters
#
# Module specific parameters
# [*dependencies_class*]
#   The name of the class that installs dependencies and prerequisite
#   resources needed by this module.
#   Default is $mcollective::dependencies which uses Example42 modules.
#   Set to '' false to not install any dependency (you must provide what's
#   defined in mcollective/manifests/dependencies.pp in some way).
#   Set directy the name of a custom class to manage there the dependencies
#
# [*stomp_host*]
#   Address or hostname of the stomp server (Active/RabbitMQ server)
#   If set a default configfile is provided which uses the stomp
#   parameters below. (Note: the default template is overriden if you
#   set a custom $source or $template)
#
# [*stomp_port*]
#   The port to use for stomp communications
#
# [*stomp_user*]
#   The user used for simple authentication
#
# [*stomp_password*]
#   The password used for simple authentication
#
# [*stomp_admin*]
#   The user configured on Mcollective client used to control
#   the mcollective infrastructure
#   Set $install_client to true to install mcollective client on
#   the local node
#
# [*stomp_admin_password*]
#   The password for the stomp_admin_user
#
# [*install_client*]
#   Set to true if you want to install mcollective client
#   (With mcollective client you manage the whole mcollective
#   infrastructure)
#
# [*install_stomp_server*]
#   Set to true if you want to install the Stomp server (currently
#   only activemq is supported. Note that you need the Example42
#   activemq as prerequisite for this option
#
# [*install_plugins*]
#   Set to true if you want to install some mcollective plugins
#   Default: true
#
# [*psk*]
#   The Pre Shared Key configured on Mcollective clients and servers
#
# [*package_client*]
#   The name of mcollective client package
#
# [*template_client*]
#   Sets the path to the template to use as content for main
#   mcollective client configuration file
#
# [*template_stomp_server*]
#   Sets the path to the template to use as content for stomp server
#   configuration file. This is used only when $install_stomp_server
#   is set to true. The default value provides a working template
#   (cuttently for ActiveMQ) that uses the other stomp parameters
#   provided in this module.
#
# [*config_file_client*]
#   Mcollective client configuration file path
#
# [*daemonize*]
#   Daemonize option. Default defined according to OS
#
# [*template_factsyml*]
#   Sets the path to the template to use as facts yml
#
# [*filter_factsyml*]
#   Define the filter to use for the default template of the facts yml
#
# [*package_provider*]
#   The Provider to use for the package resource
#
#
# Standard class parameters
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, mcollective class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $mcollective_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, the main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $mcollective_source
#
# [*source_dir*]
#   If defined, the whole configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $mcollective_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the variable $mcollective_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, the main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $mcollective_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $mcollective_options
#
# [*service_autorestart*]
#   Automatically restarts the mcollective service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $mcollective_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $mcollective_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $mcollective_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $mcollective_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for mcollective checks
#   Can be defined also by the (top scope) variables $mcollective_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the (top scope) variables $mcollective_monitor_target
#   and $monitor_target
#
# [*monitor_config_hash*]
#   A generic Hash that will be passed to certain monitoring Implementations
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the top scope variables $mcollective_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $mcollective_puppi_helper
#   and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $mcollective_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for mcollective port(s)
#   Can be defined also by the (top scope) variables $mcollective_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling mcollective.
#   Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $mcollective_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $mcollective_firewall_dst
#   and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined by the (top scope) variables $mcollective_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $mcollective_audit_only
#   and $audit_only
#
# Default class params - As defined in mcollective::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of mcollective package
#
# [*service*]
#   The name of mcollective service
#
# [*service_status*]
#   If the mcollective service init script supports status argument
#
# [*process*]
#   The name of mcollective process
#
# [*process_args*]
#   The name of mcollective arguments. Used by puppi and monitor.
#   Used only in case the mcollective process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user mcollective runs with. Used by puppi and monitor.
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application libdir, where plugins are stored.
#   Used by puppi and the default template.
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $mcollective_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $mcollective_protocol
#
#
# == Examples
#
# You can use this class in 2 ways:
# - Set variables (at top scope level on in a ENC) and "include mcollective"
# - Call mcollective as a parametrized class
#
# See README for details.
#
#
# == Author
#   Alessandro Franceschi <al@lab42.it/>
#
class mcollective (
  $dependencies_class     = params_lookup( 'dependencies_class' ),
  $stomp_host             = params_lookup( 'stomp_host' ),
  $stomp_port             = params_lookup( 'stomp_port' ),
  $stomp_user             = params_lookup( 'stomp_user' ),
  $stomp_password         = params_lookup( 'stomp_password' ),
  $stomp_admin            = params_lookup( 'stomp_admin' ),
  $stomp_admin_password   = params_lookup( 'stomp_admin_password' ),
  $install_client         = params_lookup( 'install_client' ),
  $install_stomp_server   = params_lookup( 'install_stomp_server' ),
  $install_plugins        = params_lookup( 'install_plugins' ),
  $psk                    = params_lookup( 'psk' ),
  $package_client         = params_lookup( 'package_client' ),
  $config_file_client     = params_lookup( 'config_file_client' ),
  $template_client        = params_lookup( 'template_client' ),
  $template_factsyml      = params_lookup( 'template_factsyml' ),
  $filter_factsyml        = params_lookup( 'filter_factsyml' ),
  $package_provider       = params_lookup( 'package_provider' ),
  $template_stomp_server  = params_lookup( 'template_stomp_server' ),
  $daemonize              = params_lookup( 'daemonize' ),
  $my_class               = params_lookup( 'my_class' ),
  $source                 = params_lookup( 'source' ),
  $source_dir             = params_lookup( 'source_dir' ),
  $source_dir_purge       = params_lookup( 'source_dir_purge' ),
  $template               = params_lookup( 'template' ),
  $service_autorestart    = params_lookup( 'service_autorestart' , 'global' ),
  $options                = params_lookup( 'options' ),
  $version                = params_lookup( 'version' ),
  $absent                 = params_lookup( 'absent' ),
  $disable                = params_lookup( 'disable' ),
  $disableboot            = params_lookup( 'disableboot' ),
  $monitor                = params_lookup( 'monitor' , 'global' ),
  $monitor_tool           = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target         = params_lookup( 'monitor_target' , 'global' ),
  $monitor_config_hash    = params_lookup( 'monitor_config_hash' ),
  $puppi                  = params_lookup( 'puppi' , 'global' ),
  $puppi_helper           = params_lookup( 'puppi_helper' , 'global' ),
  $firewall               = params_lookup( 'firewall' , 'global' ),
  $firewall_tool          = params_lookup( 'firewall_tool' , 'global' ),
  $firewall_src           = params_lookup( 'firewall_src' , 'global' ),
  $firewall_dst           = params_lookup( 'firewall_dst' , 'global' ),
  $debug                  = params_lookup( 'debug' , 'global' ),
  $audit_only             = params_lookup( 'audit_only' , 'global' ),
  $package                = params_lookup( 'package' ),
  $package_dependencies   = params_lookup( 'package_dependencies' ),
  $service                = params_lookup( 'service' ),
  $service_status         = params_lookup( 'service_status' ),
  $process                = params_lookup( 'process' ),
  $process_args           = params_lookup( 'process_args' ),
  $process_user           = params_lookup( 'process_user' ),
  $config_dir             = params_lookup( 'config_dir' ),
  $config_file            = params_lookup( 'config_file' ),
  $config_file_mode       = params_lookup( 'config_file_mode' ),
  $config_file_owner      = params_lookup( 'config_file_owner' ),
  $config_file_group      = params_lookup( 'config_file_group' ),
  $config_file_init       = params_lookup( 'config_file_init' ),
  $pid_file               = params_lookup( 'pid_file' ),
  $data_dir               = params_lookup( 'data_dir' ),
  $log_dir                = params_lookup( 'log_dir' ),
  $log_file               = params_lookup( 'log_file' ),
  $port                   = params_lookup( 'port' ),
  $protocol               = params_lookup( 'protocol' )
  ) inherits mcollective::params {

  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_firewall=any2bool($firewall)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)
  $bool_install_client=any2bool($install_client)
  $bool_install_stomp_server=any2bool($install_stomp_server)
  $bool_install_plugins=any2bool($install_plugins)

  ### Definition of some variables used in the module
  $manage_package = $mcollective::bool_absent ? {
    true  => 'absent',
    false => $mcollective::version,
  }

  $manage_service_enable = $mcollective::bool_disableboot ? {
    true    => false,
    default => $mcollective::bool_disable ? {
      true    => false,
      default => $mcollective::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $mcollective::bool_disable ? {
    true    => 'stopped',
    default =>  $mcollective::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_service_autorestart = $mcollective::bool_service_autorestart ? {
    true    => Service[mcollective],
    false   => undef,
  }

  $manage_file = $mcollective::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $mcollective::bool_absent == true
  or $mcollective::bool_disable == true
  or $mcollective::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $mcollective::bool_absent == true
  or $mcollective::bool_disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $mcollective::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $mcollective::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $mcollective::source ? {
    ''        => undef,
    default   => $mcollective::source,
  }

  # A default template is provided if $mcollective::stomp_host is
  # set and no $mcollective::source or $mcollective::template
  # is explicitely set
  $manage_file_content = $mcollective::template ? {
    ''        => $mcollective::source ? {
      ''      => $mcollective::stomp_host ? {
        ''      => undef,
        default => template('mcollective/server.cfg.erb'),
      },
      default => undef,
    },
    default   => template($mcollective::template),
  }

  $manage_file_content_client = $mcollective::template_client ? {
    ''        => template('mcollective/client.cfg.erb'),
    default   => template($mcollective::template_client),
  }

  ### Managed resources
  if $mcollective::package_dependencies {
    package { $mcollective::package_dependencies:
      ensure  => $mcollective::manage_package,
      before  => Package[$mcollective::package]
    }
  }

  package { $mcollective::package:
    ensure   => $mcollective::manage_package,
    provider => $mcollective::package_provider,
  }

  service { 'mcollective':
    ensure     => $mcollective::manage_service_ensure,
    name       => $mcollective::service,
    enable     => $mcollective::manage_service_enable,
    hasstatus  => $mcollective::service_status,
    pattern    => $mcollective::process_args,
    require    => Package[$mcollective::package],
  }

  file { 'mcollective.conf':
    ensure  => $mcollective::manage_file,
    path    => $mcollective::config_file,
    mode    => $mcollective::config_file_mode,
    owner   => $mcollective::config_file_owner,
    group   => $mcollective::config_file_group,
    require => Package[$mcollective::package],
    notify  => $mcollective::manage_service_autorestart,
    source  => $mcollective::manage_file_source,
    content => $mcollective::manage_file_content,
    replace => $mcollective::manage_file_replace,
    audit   => $mcollective::manage_audit,
  }

  # The whole mcollective configuration directory can be recursively overriden
  if $mcollective::source_dir {
    file { 'mcollective.dir':
      ensure  => directory,
      path    => $mcollective::config_dir,
      require => Package[$mcollective::package],
      notify  => $mcollective::manage_service_autorestart,
      source  => $mcollective::source_dir,
      recurse => true,
      purge   => $mcollective::bool_source_dir_purge,
      replace => $mcollective::manage_file_replace,
      audit   => $mcollective::manage_audit,
    }
  }


  ### Include custom class if $my_class is set
  if $mcollective::my_class {
    include $mcollective::my_class
  }

  ### Include mcollective client if $install_client == true
  if $mcollective::bool_install_client == true {
    include mcollective::client
  }

  ### Include Stomp Server (ActiveMQ) if $install_stomp_server == true
  if $mcollective::bool_install_stomp_server == true {
    include mcollective::stomp_server
  }

  ### Include Mcollective Plugins
  if $mcollective::bool_install_plugins == true {
    include mcollective::plugins
  }

  ### Include Mcollective Plugin Dependencies
  if $mcollective::dependency_class {
    include $mcollective::dependency_class
  }

  ### Provide puppi data, if enabled ( puppi => true )
  if $mcollective::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'mcollective':
      ensure    => $mcollective::manage_file,
      variables => $classvars,
      filter    => '.*content.*|.*password.*|.*psk.*',
      helper    => $mcollective::puppi_helper,
    }
    # Mcollective puppi plugin
    include puppi::mcollective::server
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $mcollective::bool_monitor == true {
    monitor::port { "mcollective_stomp_${mcollective::stomp_host}_${mcollective::stomp_port}":
      protocol    => $mcollective::protocol,
      port        => $mcollective::stomp_port,
      target      => $mcollective::stomp_host,
      tool        => $mcollective::monitor_tool,
      checksource => 'local',
      enable      => $mcollective::manage_monitor,
    }
    monitor::process { 'mcollective_process':
      process     => $mcollective::process,
      service     => $mcollective::service,
      pidfile     => $mcollective::pid_file,
      user        => $mcollective::process_user,
      argument    => $mcollective::process_args,
      tool        => $mcollective::monitor_tool,
      enable      => $mcollective::manage_monitor,
      config_hash => $mcollective::monitor_config_hash,
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if $mcollective::bool_firewall == true {
    firewall { "mcollective_${mcollective::protocol}_${mcollective::port}":
      source      => $mcollective::firewall_src,
      destination => $mcollective::firewall_dst,
      protocol    => $mcollective::protocol,
      port        => $mcollective::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $mcollective::firewall_tool,
      enable      => $mcollective::manage_firewall,
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $mcollective::bool_debug == true {
    file { 'debug_mcollective':
      ensure  => $mcollective::manage_file,
      path    => "${settings::vardir}/debug-mcollective",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
    }
  }

  ### Yaml based fact source for mcollective.
  file { 'facts.yaml':
    ensure   => $mcollective::manage_file,
    path     => "${mcollective::config_dir}/facts.yaml",
    mode     => '0400',
    owner    => 'root',
    group    => 'root',
    backup   => false,
    require  => Package[$mcollective::package],
    loglevel => debug, # this is needed to avoid it being logged and reported on every run
    # avoid including highly-dynamic facts as they will cause unnecessary template writes
    content  => template($mcollective::template_factsyml),
  }

}
