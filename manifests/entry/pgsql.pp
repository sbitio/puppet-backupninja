define backupninja::entry::pgsql (
  $ensure    = $backupninja::ensure,
  $weight    = 20,
  $when      = '',
  $compress  = false,
  $backupdir = "${backupninja::params::backupdir}/postgres",
  $databases = 'all',
  $format    = 'custom',
  $handler   = 'pgsql',
) {

  require backupninja::params
  require backupninja::entry::params

  # TODO: do some validations
  $db_array = split($databases, ' ')

  $formats = [ 'plain', 'tar', 'custom' ]
  if ! ($format in $formats) {
    fail("'${format}' is not a valid value for format. Valid values: ${formats}.")
  }

  file { "${backupninja::params::config_dir}/${weight}_${name}.${handler}" :
    ensure  => $backupninja::ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('backupninja/entry/pgsql.erb'),
  }
}
