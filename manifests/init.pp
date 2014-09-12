class backupninja (
  $ensure         = present,
  $autoupgrade    = true,
  $extra_handlers = [],
) {

  validate_bool($autoupgrade)
  validate_array($extra_handlers)

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

define backupninja::load_extra_handler () {
  backupninja::handler { $name :
    handler_source => "puppet:///modules/backupninja/handlers/${name}.in",
    helper_source  => "puppet:///modules/backupninja/handlers/${name}.helper.in",
  }
}
