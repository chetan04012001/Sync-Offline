import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'sync_offline_method_channel.dart';

abstract class SyncOfflinePlatform extends PlatformInterface {
  /// Constructs a SyncOfflinePlatform.
  SyncOfflinePlatform() : super(token: _token);

  static final Object _token = Object();

  static SyncOfflinePlatform _instance = MethodChannelSyncOffline();

  /// The default instance of [SyncOfflinePlatform] to use.
  ///
  /// Defaults to [MethodChannelSyncOffline].
  static SyncOfflinePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SyncOfflinePlatform] when
  /// they register themselves.
  static set instance(SyncOfflinePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
