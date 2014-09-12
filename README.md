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
      hotcopy : false
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

NOTES :
=======

* mysql_updated is upstream backupninja mysql handler (commit "8b6b607") since table ignore support is broken on some system packages (namely wheezy).

TO-DOs
======
