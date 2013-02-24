class backupninja::params (
  $log_level       = 4,
  $reportemail     = 'root',
  $reportsuccess   = true,
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

  case $::operatingsystem {
    ubuntu, debian: {
      $package_name     = 'backupninja'
      $config_file      = '/etc/backupninja.conf'
      $config_dir       = '/etc/backup.d'
      $logfile          = '/var/log/backupninja.log'
      $admingroup       = 'root'
      $scriptdirectory  = '/usr/share/backupninja'
      $libdirectory     = '/usr/lib/backupninja'
      $mysql_configfile = '/etc/mysql/debian.cnf'
    }
#    redhat, centos: {
#      $package_name    = 'backupninja'
#    }
    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }

}
