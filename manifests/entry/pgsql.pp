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
  String $databases                    = 'all',
  String $format                       = 'custom',
  String $handler                      = 'pgsql',
) {

  require backupninja::params
  require backupninja::entry::params

  if $when =~ Array[String] {
    $_when_real = $when
  } else {
    $_when_real = [] << $when
  }

  if empty($databases) {
    $db_list = ['all']
  }
  elsif $databases =~String {
    $db_list = split($databases, ' ')
  }
  else {
    $db_list = $databases
  }

  if $db_list.size > 1 and 'all' in $db_list {
    $db_list_real = ['all']
  }
  else {
    $db_list_real = $db_list.unique
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
