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
}
