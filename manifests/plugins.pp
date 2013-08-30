# Class: mcollective::plugins
#
# This class installs mcollective plugins as packages
#
class mcollective::plugins {

  include mcollective

  Mcollective::Plugin {
    ensure         => $mcollective::manage_package,
    install_client => $mcollective::install_client,
  }

  mcollective::plugin { 'filemgr':
  }

  mcollective::plugin { 'iptables':
  }

  mcollective::plugin { 'nrpe':
  }

  mcollective::plugin { 'nettest':
  }

  mcollective::plugin { 'package':
  }

  mcollective::plugin { 'puppet':
  }

  mcollective::plugin { 'service':
  }

}
