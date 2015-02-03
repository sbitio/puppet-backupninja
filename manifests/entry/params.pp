class backupninja::entry::params () {

  require backupninja::params

  case $::operatingsystem {
    ubuntu, debian: {
      $duplicity_package_name = 'duplicity'
      $mysql_package_name     = 'mysql-client'
    }
    redhat, centos: {
      $duplicity_package_name = 'duplicity'
      $mysql_package_name     = 'mysql'
    }
    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }

}
