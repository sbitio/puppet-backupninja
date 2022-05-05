# backupninja::entry
#
# This defined type is responsible for creating backupninja entries
# Depending on the type parameter it calls one of the classes in manifests/entry/*.pp
# and generates the corresponding backupninja task
#
define backupninja::entry (
  Enum['duplicity', 'ldap', 'mysql', 'pgsql', 'sh'] $type,
  Hash $options,
  Enum['present', 'absent'] $ensure = $backupninja::ensure,
  Integer $weight = -1,
  Variant[Array[String], String] $when   = '',
) {

  include backupninja::entry::params

  $real_weight = $weight ? {
    -1      => undef,
    default => $weight
  }

  $real_when = $when ? {
    ''      => undef,
    default => $when
  }

  case $type {
    'duplicity': {
      backupninja::entry::duplicity { $name:
        ensure             => $ensure,
        weight             => $real_weight,
        when               => $real_when,
        # Duplicity
        options            => $options[options],
        nicelevel          => $options[nicelevel],
        testconnect        => $options[testconnect],
        sign               => $options[sign],
        encryptkey         => $options[encryptkey],
        signkey            => $options[signkey],
        password           => $options[password],
        include            => $options[include],
        exclude            => $options[exclude],
        incremental        => $options[incremental],
        increments         => $options[increments],
        keep               => $options[keep],
        desturl            => $options[desturl],
        awsaccesskeyid     => $options[awsaccesskeyid],
        awssecretaccesskey => $options[awssecretaccesskey],
        ftp_password       => $options[ftp_password],
        bandwidthlimit     => $options[bandwidthlimit],
        sshoptions         => $options[sshoptions],
        destdir            => $options[destdir],
        desthost           => $options[desthost],
        destuser           => $options[destuser],
      }
    }
    'ldap': {
      backupninja::entry::ldap { $name:
        ensure    => $ensure,
        weight    => $real_weight,
        when      => $real_when,
        # Ldap
        backupdir => $options[backupdir],
        suffixes  => $options[suffixes],
        compress  => $options[compress],
        ldif      => $options[ldif],
        restart   => $options[restart],
      }
    }
    'mysql': {
      backupninja::entry::mysql { $name:
        ensure         => $ensure,
        weight         => $real_weight,
        when           => $real_when,
        # MySQL
        hotcopy        => $options[hotcopy],
        sqldump        => $options[sqldump],
        sqldumpoptions => $options[sqldumpoptions],
        compress       => $options[compress],
        dbhost         => $options[dbhost],
        backupdir      => $options[backupdir],
        databases      => $options[databases],
        user           => $options[user],
        dbusername     => $options[dbusername],
        dbpassword     => $options[dbpassword],
        configfile     => $options[configfile],
        nodata         => $options[nodata],
        nodata_any     => $options[nodata_any],
        vsname         => $options[vsname],
        handler        => $options[handler],
      }
    }
    'pgsql': {
      backupninja::entry::pgsql { $name:
        ensure    => $ensure,
        weight    => $real_weight,
        when      => $real_when,
        # pgsql
        compress  => $options[compress],
        backupdir => $options[backupdir],
        databases => $options[databases],
        format    => $options[format],
        handler   => $options[handler],
      }
    }
    'sh': {
      backupninja::entry::sh { $name:
        ensure   => $ensure,
        weight   => $real_weight,
        when     => $real_when,
        #sh
        commands => $options[commands],
      }
    }
    default: {
      fail "Uknown type ${type} for backupninja::entry"
    }
  }

}
