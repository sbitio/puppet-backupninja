# backupninja
#
# This class is responsible for installing and configuring the backupninja service
#
class backupninja (
  Enum['present', 'absent'] $ensure = present,
  Boolean $autoupgrade              = true,
  Array[String] $extra_handlers     = [],
) {

  case $ensure {
    /(present)/: {
      $dir_ensure = 'directory'
      $service_ensure = 'running'
      if $autoupgrade == true {
        $package_ensure = 'latest'
      } else {
        $package_ensure = 'present'
      }
    }
    /(absent)/: {
      $package_ensure = 'absent'
      $dir_ensure = 'absent'
      $service_ensure = 'stopped'
    }
    default: {
      fail('ensure parameter must be present or absent')
    }
  }

  include backupninja::install
  include backupninja::config

  if $extra_handlers != [] {
    backupninja::load_extra_handler { $extra_handlers :}
  }
}
