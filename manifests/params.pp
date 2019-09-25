class backupninja::params (
  $log_level       = 4,
  $reportemail     = 'root',
  $reportsuccess   = false,
  $reportinfo      = false,
  $reportwarning   = true,
  $reportspace     = false,
  $reporthost      = '',
  $reportuser      = 'ninja',
  $reportdirectory = '/var/lib/backupninja/reports',
  $usecolors       = true,
  $when            = 'everyday at 01:00',
  $vservers        = false,
  $backupdir       = '/var/backups',
  $package_install_options = undef,
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

