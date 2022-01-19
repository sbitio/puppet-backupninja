define backupninja::entry::sh (
  $ensure         = $backupninja::ensure,
  $weight         = 95,
  Variant[Array[String], String] $when = '',
  $commands       = [],
) {

  require backupninja::params

  if $when =~ Array[String] {
    $_when_real = $when
  } else {
    $_when_real = [] << $when
  }

  file { "${backupninja::params::config_dir}/${weight}_${name}.sh" :
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('backupninja/entry/sh.erb'),
  }
}
