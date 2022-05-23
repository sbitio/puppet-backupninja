# backupninja::entry::pgsql
#
# This defined type handles the postgres backupninja task entries
#
define backupninja::entry::pgsql (
  Enum['present', 'absent'] $ensure    = $backupninja::ensure,
  Optional[Integer] $weight            = 20,
  Variant[Array[String], String] $when = '',
  Boolean $compress                    = false,
  Stdlib::Absolutepath $backupdir      = "${backupninja::params::backupdir}/postgres",
  Array[String] $databases             = ['all'],
  String $format                       = 'custom',
  String $handler                      = 'pgsql',
) {

  require backupninja::params
  require backupninja::entry::params

  if $databases.size > 1 and 'all' in $databases {
    $db_list_real = ['all']
  }
  else {
    $db_list_real = $databases.unique
  }

  $formats = [ 'plain', 'tar', 'custom' ]
  if ! ($format in $formats) {
    fail("'${format}' is not a valid value for format. Valid values: ${formats}.")
  }

  file { "${backupninja::params::config_dir}/${weight}_${name}.${handler}" :
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('backupninja/entry/pgsql.erb'),
  }
}
