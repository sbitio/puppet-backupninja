# backupninja::entry
#
# This defined type is responsible for creating backupninja entries
# Depending on the type parameter it calls one of the classes in manifests/entry/*.pp
# and generates the corresponding backupninja task
#
define backupninja::entry (
  Enum['duplicity', 'ldap', 'mysql', 'pgsql', 'sh'] $type,
  Hash $options,
  Enum['present', 'absent'] $ensure      = $backupninja::ensure,
  Optional[Integer] $weight              = undef,
  Variant[Array[String], String] $when   = '',
) {

  include backupninja::entry::params

  $real_when = $when ? {
    ''      => undef,
    default => $when
  }

  $defaults = {
    'ensure' => $ensure,
    'weight' => $weight,
    'when'   => $real_when,
  }

  $params = merge($defaults, $options)
  ensure_resource("backupninja::entry::${type}", $name, $params)

}
