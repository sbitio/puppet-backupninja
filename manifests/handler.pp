define backupninja::handler (
  $ensure         = $backupninja::ensure,
  $handler_source = '',
  $helper_source  = '',
) {

  require backupninja::params

  file { "${backupninja::params::scriptdirectory}/${name}" :
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    #content => $varnish::params::vcl_source ? {
    #  undef   => template('varnish/empty.vcl.erb'),
    #  default => undef,
    #},
    source  => $handler_source,
  }
  file { "${backupninja::params::scriptdirectory}/${name}.helper" :
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    #content => $varnish::params::vcl_source ? {
    #  undef   => template('varnish/empty.vcl.erb'),
    #  default => undef,
    #},
    source  => $helper_source,
  }


}
