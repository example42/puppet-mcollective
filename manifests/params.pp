# Class: mcollective::params
#
# This class defines default parameters used by the main module class mcollective
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to mcollective class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class mcollective::params {

  ### Class specific parameters
  $dependencies_class = 'mcollective::dependencies'

  $stomp_host = 'localhost'
  $stomp_port = '61613'
  $stomp_user = 'mcollective'
  $stomp_password = 'secret'
  $stomp_admin = 'mcollective_admin'
  $stomp_admin_password = 'secret!'

  $install_client = false
  $install_stomp_server = false
  $install_plugins = true
  $psk = 'th1s_1s_someTHING_diff1cult2guess!butNOTsoSAFE!!'

  $package_client = $::operatingsystem ? {
    default => 'mcollective-client',
  }

  $package_provider   = $::operatingsystem ? {
    default => undef,
  }

  $config_file_client = $::operatingsystem ? {
    default => '/etc/mcollective/client.cfg',
  }

  $template_factsyml       = 'mcollective/facts.yml.erb'
  $filter_factsyml       = '(uptime.*|last_run|manage_file_content|classvars|path|timestamp|free|.*password.*|.*psk.*|.*key)'

  $template_client = ''
  $template_stomp_server = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'mcollective/ubuntu_activemq.xml.erb',
    default                   => 'mcollective/activemq.xml.erb',
  }

  $daemonize = $::operatingsystem ? {
#    Ubuntu   => '0',
    default  => '1',
  }

  ### Application related parameters

  $package = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'mcollective',
    default                   => 'mcollective',
  }

  $package_dependencies = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'libstomp-ruby',
    default                   => undef,
  }

  $service = $::operatingsystem ? {
    default => 'mcollective',
  }

  $service_status = $::operatingsystem ? {
    ubuntu  => false,
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'ruby',
  }

  $process_args = $::operatingsystem ? {
    default => 'mcollectived',
  }

  $process_user = $::operatingsystem ? {
    default => 'root',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/mcollective',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/mcollective/server.cfg',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0640',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/mcollective',
    default                   => '/etc/sysconfig/mcollective',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/mcollectived.pid',
  }

  # This is the libdir in the configuration file
  # Here plugins are stored
  $data_dir = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/usr/share/mcollective/plugins',
    default                   => '/usr/libexec/mcollective',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/mcollective',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/mcollective.log',
  }

  $port = '61613'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = ''
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false

}
