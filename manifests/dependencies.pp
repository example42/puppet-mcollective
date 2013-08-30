# Class: mcollective::prerequisites
#
# This class installs mcollective prerequisites
#
# == Variables
#
# Refer to mcollective class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by mcollective with the parameter
# dependency_class
# Note: This class may contain resources available on the
# Example42 modules set
#
class mcollective::dependencies {

  include mcollective

  if !defined(Package[json]) {
    package { 'json':
      ensure    => $mcollective::manage_package,
      provider  => gem,
      notify    => $mcollective::manage_service_autorestart
    }
  }
  if !defined(Package[net-ping]) {
    package { 'net-ping':
      ensure    => $mcollective::manage_package,
      provider  => gem,
      notify    => $mcollective::manage_service_autorestart
    }
  }
  if !defined(Package[sys-proctable]) {
    package { 'sys-proctable':
      ensure    => $mcollective::manage_package,
      provider  => gem,
      notify    => $mcollective::manage_service_autorestart
    }
  }

  case $::operatingsystem {
    redhat,centos,scientific,oraclelinux : {
      require yum::repo::puppetlabs
    }
    ubuntu,debian : {
      require apt::repo::puppetlabs
    }
    default: { }
  }

}
