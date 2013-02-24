class backupninja::config () {
  require backupninja::params
  require backupninja::install

  file { $backupninja::params::config_file :
    ensure  => $backupninja::ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('backupninja/backupninja.conf.erb'),
  }

  file { $backupninja::params::config_dir :
    ensure  => $backupninja::dir_ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0660',
    recurse => true,
    purge   => true,
  }

  file { $backupninja::params::backupdir :
    ensure  => $backupninja::dir_ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  $defaults = {
    tag => $::fqdn,
  }

  create_resources(
    backupninja::entry,
    hiera_hash('backupninja::entries', {}),
    $defaults
  )

  Backupninja::Entry <| tag == $::fqdn |>
  Backupninja::Entry <<| tag == $::fqdn |>>

}
