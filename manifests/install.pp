class backupninja::install () {

  require backupninja::params

  package { $backupninja::params::package_name:
    ensure  => $backupninja::package_ensure,
  }

}
