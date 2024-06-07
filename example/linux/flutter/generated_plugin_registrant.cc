//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <sync_offline/sync_offline_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) sync_offline_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "SyncOfflinePlugin");
  sync_offline_plugin_register_with_registrar(sync_offline_registrar);
}
