define backupninja::entry::sh (
  $ensure         = $backupninja::ensure,
  $weight         = 95,
  $when           = '',
  $commands       = [],
) {

  require backupninja::params

  file { "${backupninja::params::config_dir}/${weight}_${name}.sh" :
    ensure  => $backupninja::ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('backupninja/entry/sh.erb'),
  }
}