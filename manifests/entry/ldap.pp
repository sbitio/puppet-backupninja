define backupninja::entry::ldap (
  $ensure    = $backupninja::ensure,
  $weight    = 20,
  $when      = '',
  $backupdir = '/var/backups/ldap',
  $suffixes  = 'all',
  $compress  = 'yes',
  $ldif      = 'yes',
  $restart   = 'no',
  $handler   = 'ldap',
) {

  require backupninja::params
  require backupninja::entry::params

  file { "${backupninja::params::config_dir}/${weight}_${name}.${handler}" :
    ensure  => $backupninja::ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('backupninja/entry/ldap.erb'),
  }
}
