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
) {

  $package_name     = 'backupninja'
  $config_file      = '/etc/backupninja.conf'
  $config_dir       = '/etc/backup.d'
  $logfile          = '/var/log/backupninja.log'
  $admingroup       = 'root'
  $scriptdirectory  = '/usr/share/backupninja'

  case $::operatingsystem {
    ubuntu, debian: {
      $libdirectory     = '/usr/lib/backupninja'
      $mysql_configfile = '/etc/mysql/debian.cnf'
    }
    redhat, centos: {
      $libdirectory     = '/usr/libexec/backupninja'
      $mysql_configfile = undef
    }
    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }

}
