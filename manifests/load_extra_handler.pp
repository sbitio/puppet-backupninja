# backupninja::load_extra_handlers
#
# This defined type is responsible for loading the extra backupninja handlers.
# It calls another class backupninja::handler, and passes it the necessary parameters to load the handlers
#
define backupninja::load_extra_handler () {
  backupninja::handler { $name :
    handler_source => "puppet:///modules/backupninja/handlers/${name}.in",
    helper_source  => "puppet:///modules/backupninja/handlers/${name}.helper.in",
  }
}
