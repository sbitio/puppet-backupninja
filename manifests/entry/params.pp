class backupninja::entry::params () {

  require backupninja::params

  case $::osfamily {
    'Debian': {
      $duplicity_package_name = 'duplicity'
      $mysql_package_name     = 'mysql-client'
    }
    'RedHat': {
      $duplicity_package_name = 'duplicity'
      if $::lsbmajdistrelease < 7 {
        $mysql_package_name   = 'mysql'
      }
      else {
        $mysql_package_name   = 'mariadb'
      }
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} only support osfamily Debian and RedHat")
    }
  }
}

