# backupninja::entry::mysql
#
# This defined type handles the mysql backupninja task entries
#
define backupninja::entry::mysql (
  Enum['present', 'absent'] $ensure = $backupninja::ensure,
  Optional[Integer] $weight            = 20,
  Variant[Array[String], String] $when = '',
  Boolean $hotcopy          = false,
  Boolean $sqldump          = true,
  String $sqldumpoptions    = '--lock-tables --complete-insert --add-drop-table --quick --quote-names',
  Boolean $compress         = false,
  String $dbhost            = '',
  Stdlib::Absolutepath $backupdir = "${backupninja::params::backupdir}/mysql",
  Variant[Array[String], String] $databases         = 'all',
  String $user              = '',
  String $dbusername        = '',
  String $dbpassword        = '',
  Stdlib::Absolutepath $configfile = $backupninja::params::mysql_configfile,
  String $nodata            = '',
  Array[String] $nodata_any = [],
  String $vsname            = '',
  String $handler           = 'mysql',
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
  elsif is_string($databases) {
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


  file { "${backupninja::params::config_dir}/${weight}_${name}.${handler}" :
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('backupninja/entry/mysql.erb'),
  }
}
