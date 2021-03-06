define backupninja::entry::duplicity (
  $ensure             = $backupninja::ensure,
  $weight             = 90,
  $when               = '',
  $options            = '',
  $nicelevel          = 19,
  $testconnect        = false,
  $sign               = false,
  $encryptkey         = '',
  $signkey            = '',
  $password           = '',
  $include            = [
    '/var/spool/cron/crontabs',
    '/var/backups',
    '/etc',
    '/root',
    '/home',
    '/usr/local/*bin',
    '/var/lib/dpkg/status*',
    '/var/www',
  ],
  $exclude            = [
    '/home/*/.gnupg',
    '/home/*/.local/share/Trash',
    '/home/*/.Trash',
    '/home/*/.thumbnails',
    '/home/*/.beagle',
    '/home/*/.aMule',
    '/home/*/gtk-gnutella-downloads',
    '/var/cache/backupninja/duplicity',
  ],
  $incremental        = true,
  $increments         = '30',
  $keep               = '60',
  $desturl            = '',
  $awsaccesskeyid     = '',
  $awssecretaccesskey = '',
  $ftp_password       = '',
  $bandwidthlimit     = '',
  $sshoptions         = '',
  $destdir            = '',
  $desthost           = '',
  $destuser           = '',
) {

  require backupninja::entry::params

  if ! defined(Package[$backupninja::entry::params::duplicity_package_name]) {
    package { $backupninja::entry::params::duplicity_package_name:
      ensure => $backupninja::ensure,
    }
  }

  file { "${backupninja::params::config_dir}/${weight}_${name}.dup" :
    ensure  => $backupninja::ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('backupninja/entry/duplicity.erb'),
  }
}
