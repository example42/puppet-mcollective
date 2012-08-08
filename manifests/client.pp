# = Class: mcollective::client
#
# This class installs the mcollective client
#
#
# == Parameters
# All parameters are passed to the main mcollective class
#
class mcollective::client inherits mcollective {

  package { 'mcollective_client':
    ensure => $mcollective::manage_package,
    name   => $mcollective::package_client,
  }

  file { 'mcollective_client.conf':
    ensure  => $mcollective::manage_file,
    path    => $mcollective::config_file_client,
    mode    => $mcollective::config_file_mode,
    owner   => $mcollective::config_file_owner,
    group   => $mcollective::config_file_group,
    require => Package['mcollective_client'],
    content => $mcollective::manage_file_content_client,
    replace => $mcollective::manage_file_replace,
    audit   => $mcollective::manage_audit,
  }

  if $mcollective::bool_puppi == true {
    # Mcollective puppi plugin
    include puppi::mcollective::client
  }

}
