class mcollective::plugins {

  include mcollective

  # PuppetLabs Plugins
  mcollective::plugin { 'process':
    install_client => $mcollective::install_client,
    application    => 'pgrep.rb',
  }

  mcollective::plugin { 'iptables':
    install_client => $mcollective::install_client,
  }

  mcollective::plugin { 'filemgr':
    install_client => $mcollective::install_client,
  }

  mcollective::plugin { 'nettest':
    install_client => $mcollective::install_client,
  }

  mcollective::plugin { 'service':
    install_client => $mcollective::install_client,
  }

  mcollective::plugin { 'puppetd':
    install_client => $mcollective::install_client,
  }

  mcollective::plugin { 'puppetca':
    install_client => $mcollective::install_client,
    application    => false,
  }

  mcollective::plugin { 'puppetral':
    install_client => $mcollective::install_client,
    application    => false,
  }

  mcollective::plugin { 'package':
    install_client => $mcollective::install_client,
  }

  # These are usable on Mcollective > 2.1
  # mcollective::plugin { 'sysctl_data':
  #   plugin_type => 'data',
  # }

  # mcollective::plugin { 'resource_data':
  #   plugin_type => 'data',
  # }

}
