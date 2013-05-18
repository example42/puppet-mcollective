# = Class: mcollective::stomp_server
#
# This class installs the stomp server (ActiveMQ)
# with the credentials used by the mcollective module
# It requires Example42 activemq module
# If you need more customizations of the activemq module
# use it directly and do not set
# $mcollective::install_stomp_server to true
#
# == Parameters
# All parameters are passed to the main mcollective class
#
class mcollective::stomp_server inherits mcollective {

  case $::operatingsystem {
    ubuntu,debian,mint: {
      class { 'activemq':
        install              => 'source',
        version              => '5.5.1',
        template             => $mcollective::template_stomp_server,
        install_dependencies => $mcollective::install_dependencies,
      }
    }
    default : {
      class { 'activemq':
        template             => $mcollective::template_stomp_server,
        install_dependencies => $mcollective::install_dependencies,
      }
    }
  }
}
