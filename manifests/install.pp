# backupninja::install
#
# This class handles the installation of the backupninja package
#
class backupninja::install () {

  require backupninja::params

  package { $backupninja::params::package_name:
    ensure          => $backupninja::package_ensure,
    install_options => $::backupninja::params::package_install_options,
  }

}
