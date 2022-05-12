# backupninja::entry::duplicity
#
# This defined type handles the duplicity backupninja task entries
#
define backupninja::entry::duplicity (
  Enum['present', 'absent'] $ensure    = $backupninja::ensure,
  Optional[Integer] $weight            = 90,
  Variant[Array[String], String] $when = '',
  String $options                      = '',
  Integer $nicelevel                   = 19,
  Boolean $testconnect                 = false,
  Boolean $sign                        = false,
  String $encryptkey                   = '',
  String $signkey                      = '',
  String $password                     = '',
  Array[String] $include               = [
    '/var/spool/cron/crontabs',
    '/var/backups',
    '/etc',
    '/root',
    '/home',
    '/usr/local/*bin',
    '/var/lib/dpkg/status*',
    '/var/www',
  ],
  Array[String] $exclude               = [
    '/home/*/.gnupg',
    '/home/*/.local/share/Trash',
    '/home/*/.Trash',
    '/home/*/.thumbnails',
    '/home/*/.beagle',
    '/home/*/.aMule',
    '/home/*/gtk-gnutella-downloads',
    '/var/cache/backupninja/duplicity',
  ],
  Boolean $incremental                 = true,
  String $increments                   = '30',
  String $keep                         = '60',
  String $desturl                      = '',
  String $awsaccesskeyid               = '',
  String $awssecretaccesskey           = '',
  String $ftp_password                 = '',
  String $bandwidthlimit               = '',
  String $sshoptions                   = '',
  String $destdir                      = '',
  String $desthost                     = '',
  String $destuser                     = '',
) {

  require backupninja::entry::params

  if $when =~ Array[String] {
    $_when_real = $when
  } else {
    $_when_real = [] << $when
  }

  if ! defined(Package[$backupninja::entry::params::duplicity_package_name]) {
    package { $backupninja::entry::params::duplicity_package_name:
      ensure => $backupninja::ensure,
    }
  }

  file { "${backupninja::params::config_dir}/${weight}_${name}.dup" :
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('backupninja/entry/duplicity.erb'),
  }
}
