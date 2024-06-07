#include "include/sync_offline/sync_offline_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "sync_offline_plugin.h"

void SyncOfflinePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  sync_offline::SyncOfflinePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
