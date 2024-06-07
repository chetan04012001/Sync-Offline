#ifndef FLUTTER_PLUGIN_SYNC_OFFLINE_PLUGIN_H_
#define FLUTTER_PLUGIN_SYNC_OFFLINE_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace sync_offline {

class SyncOfflinePlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  SyncOfflinePlugin();

  virtual ~SyncOfflinePlugin();

  // Disallow copy and assign.
  SyncOfflinePlugin(const SyncOfflinePlugin&) = delete;
  SyncOfflinePlugin& operator=(const SyncOfflinePlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace sync_offline

#endif  // FLUTTER_PLUGIN_SYNC_OFFLINE_PLUGIN_H_
