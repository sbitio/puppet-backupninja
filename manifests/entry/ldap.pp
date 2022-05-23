# backupninja::entry::ldap
#
# This defined type handles the ldap backupninja task entries
#
define backupninja::entry::ldap (
  Enum['present', 'absent'] $ensure    = $backupninja::ensure,
  Optional[Integer] $weight            = 20,
  Variant[Array[String], String] $when = '',
  Stdlib::Absolutepath $backupdir      = '/var/backups/ldap',
  String $suffixes                     = 'all',
  String $compress                     = 'yes',
  String $ldif                         = 'yes',
  String $restart                      = 'no',
  String $handler                      = 'ldap',
) {

  require backupninja::params
  require backupninja::entry::params

  file { "${backupninja::params::config_dir}/${weight}_${name}.${handler}" :
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('backupninja/entry/ldap.erb'),
  }
}
