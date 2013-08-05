# = Define: mcollective::plugin
#
# This define can be used to install mcollective plugins
#
# == Parameters
#
# Module specific parameters
# [*base_source*]
#   The base source prefix that indicates the source path from where
#   to retrieve the plugin componenets.
#   Default value is : puppet:///modules/mcollective/plugins
#   Directory structure here should be in this format:
#   ${plugin_type}/${name}.[rb|ddl] for plugins and ddls
#   ${plugin_type}/applications/${name}.rb for applications
#
# [*plugin_type*]
#   The type of the plugin (agent/facts/data) Default:agent
#
# [*install_client*]
#   If Mcollective client components should be installed
#   (typically the applications). Default: false
#
# [*ensure*]
#   If the plugin has to be installed. Default: present.
#    Set to "absent" to remove a previously installed plugin
#
# [*ddl*]
#   The name of the ddl file. Provide an empty string if you
#   have no ddl components to install. Default: ${name}.ddl
#
# [*application*]
#   The name of the application file. Provide an empty string if you
#   have no application components to install. Default ${name}.rb
#   Note: the pplication file is copied only if $install_client = true
#
define mcollective::plugin (
  $base_source    = 'puppet:///modules/mcollective/plugins',
  $plugin_type    = 'agent',
  $install_client = false,
  $install_mode   = 'package',
  $ensure         = 'present',
  $ddl            = true,
  $application    = true ) {

  include mcollective

  $bool_install_client=any2bool($install_client)

  $real_ensure = $ensure ? {
    absent  => 'absent',
    default => 'present',
  }

  $real_ddl = $ddl ? {
    true    => "${name}.ddl",
    ''      => false,
    default => $ddl,
  }

  $real_application = $application ? {
    true    => "${name}.rb",
    ''      => false,
    default => $application,
  }



  if $install_mode == 'package' {

    package { "mcollective-${name}-agent":
      ensure  => $real_ensure,
    }

    if $bool_install_client == true {
      package { "mcollective-${name}-client":
        ensure  => $real_ensure,
      }
    }

  } else {

    file { "Mcollective_${name}.rb":
      ensure  => $real_ensure,
      path    => "${mcollective::data_dir}/mcollective/${plugin_type}/${name}.rb",
      owner   => root,
      group   => root,
      mode    => '0444',
      require => Package[$mcollective::package],
      notify  => Service['mcollective'],
      source  => "${base_source}/${plugin_type}/${name}.rb",
    }

    if $real_ddl != false {
      file { "Mcollective_${name}.ddl":
        ensure  => $real_ensure,
        path    => "${mcollective::data_dir}/mcollective/${plugin_type}/${real_ddl}",
        owner   => root,
        group   => root,
        mode    => '0444',
        require => Package[$mcollective::package],
        notify  => Service['mcollective'],
        source  => "${base_source}/${plugin_type}/${real_ddl}",
      }
    }

    if $real_application != false and $bool_install_client == true {
      file { "Mcollective_${name}.app":
        ensure  => $real_ensure,
        path    => "${mcollective::data_dir}/mcollective/application/${real_application}",
        owner   => root,
        group   => root,
        mode    => '0444',
        require => Package[$mcollective::package],
        notify  => Service['mcollective'],
        source  => "${base_source}/application/${real_application}",
      }
    }
  }
}
