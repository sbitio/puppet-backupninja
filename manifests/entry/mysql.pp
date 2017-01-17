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
  $nodata_any     = [],
  $vsname         = '',
  $handler        = 'mysql',
) {

  require backupninja::params
  require backupninja::entry::params

  # Allow for stringified arrays.
  # Arrays may come stringified from hiera, if using lookup functions.
  # See https://docs.puppetlabs.com/hiera/1/variables.html#using-lookup-functions
  if is_string($nodata_any) {
    $nodata_any_real = parseyaml($nodata_any)
  }
  else {
    $nodata_any_real = $nodata_any
  }
  validate_array($nodata_any_real)

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
