class backupninja::entry::params () {

  require backupninja::params

  case $::operatingsystem {
    ubuntu, debian: {
      $duplicity_package_name = 'duplicity'
      $mysql_package_name     = 'mysql-client'
    }
#    redhat, centos: {
#      $package_name    = 'backupninja'
#    }
    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }

}
