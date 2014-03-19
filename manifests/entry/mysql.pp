define backupninja::entry::mysql (
  $ensure         = $backupninja::ensure,
  $weight         = 20,
  $when           = '',
  $hotcopy        = false,
  $sqldump        = true,
  $sqldumpoptions = '--lock-tables --complete-insert --add-drop-table --quick --quote-names',
  $compress       = false,
  $dbhost         = '',
  $backupdir      = "${backupninja::params::backupdir}/mysql",
  $databases      = 'all',
  $user           = '',
  $dbusername     = '',
  $dbpassword     = '',
  $configfile     = $backupninja::params::mysql_configfile,
  $nodata         = '',
  $nodata_every   = [],
  $vsname         = '',
  $handler        = 'mysql',
) {

  require backupninja::params
  require backupninja::entry::params

  if ! defined(Package[$backupninja::entry::params::mysql_package_name]) {
    package { $backupninja::entry::params::mysql_package_name:
      ensure => $backupninja::ensure,
    }
  }

  # TODO: do some validations
  $db_array = split($databases, ' ')

  file { "${backupninja::params::config_dir}/${weight}_${name}.${handler}" :
    ensure  => $backupninja::ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('backupninja/entry/mysql.erb'),
  }
}
