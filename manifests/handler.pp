# backupninja::handler
#
# This class is responsible for creating the necessary handler files
#
define backupninja::handler (
  Enum['present', 'absent'] $ensure = $backupninja::ensure,
  String $handler_source            = '',
  String $helper_source             = '',
) {

  require backupninja::params

  file { "${backupninja::params::scriptdirectory}/${name}" :
    ensure => $ensure,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => $handler_source,
  }
  file { "${backupninja::params::scriptdirectory}/${name}.helper" :
    ensure => $ensure,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => $helper_source,
  }

}
