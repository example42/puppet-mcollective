class mcollective::dependencies {

  include mcollective

  package {
    [ 'net-ping', 'sys-proctable', 'json' ]:
      ensure    => $mcollective::manage_package,
      provider  => gem,
      notify    => $mcollective::manage_service_autorestart
  }
}
