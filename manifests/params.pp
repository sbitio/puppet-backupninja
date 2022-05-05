# backupninja::params
#
# This class handles the module data
#
class backupninja::params (
  Integer $log_level       = 4,
  String $reportemail      = 'root',
  Boolean $reportsuccess   = false,
  Boolean $reportinfo      = false,
  Boolean $reportwarning   = true,
  Boolean $reportspace     = false,
  String $reporthost       = '',
  String $reportuser       = 'ninja',
  Stdlib::Absolutepath $reportdirectory = '/var/lib/backupninja/reports',
  Boolean $usecolors       = true,
  Variant[Array[String], String] $when = 'everyday at 01:00',
  Boolean $vservers        = false,
  Stdlib::Absolutepath $backupdir  = '/var/backups',
  Optional[String] $package_install_options = undef,
) {

  $package_name     = 'backupninja'
  $cache_dir        = '/var/cache/backupninja'
  $config_file      = '/etc/backupninja.conf'
  $config_dir       = '/etc/backup.d'
  $logfile          = '/var/log/backupninja.log'
  $admingroup       = 'root'
  $scriptdirectory  = '/usr/share/backupninja'

  case $::osfamily {
    'Debian': {
      $libdirectory     = '/usr/lib/backupninja'
      $mysql_configfile = '/etc/mysql/debian.cnf'
    }
    'RedHat': {
      $libdirectory     = '/usr/libexec/backupninja'
      $mysql_configfile = '/root/.my.cnf'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} only support osfamily Debian and RedHat")
    }
  }
}
