# backupninja::entry::ldap
#
# This defined type handles the ldap backupninja task entries
#
define backupninja::entry::ldap (
  $ensure    = $backupninja::ensure,
  $weight    = 20,
  Variant[Array[String], String] $when = '',
  $backupdir = '/var/backups/ldap',
  $suffixes  = 'all',
  $compress  = 'yes',
  $ldif      = 'yes',
  $restart   = 'no',
  $handler   = 'ldap',
) {

  require backupninja::params
  require backupninja::entry::params

  if $when =~ Array[String] {
    $_when_real = $when
  } else {
    $_when_real = [] << $when
  }

  file { "${backupninja::params::config_dir}/${weight}_${name}.${handler}" :
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('backupninja/entry/ldap.erb'),
  }
}
