puppet-backupninja
============

Puppet module to manage backupninja

Requirements
============
Puppet 3.x

Sample hiera declaration
========================
~~~
backupninja::entries :
  database :
    type    : mysql
    when    : 'everyday at 18'
    options :
      hotcopy    : false
      nodata_any : [cache, sessions, watchdog]
  files :
    type    : duplicity
    when    : 'everyday at 18'
    options :
      nicelevel : 20
      password  : 'mypass'
      include   : [
        '/var/www',
        '/var/lib/gitolite'
      ]
      desturl   : 'file:///backups/dl471'
  script :
    type    : sh
    when    : 'everyday at 18'
    options :
      commands : [
        'echo a'
      , 'echo b'
      ]
~~~

NOTES
=====

* `mysql_updated` is a patched version of mysql handler to allow `nodata_any`.

TO-DOs
======
