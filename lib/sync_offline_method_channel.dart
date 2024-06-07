import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'sync_offline_platform_interface.dart';

/// An implementation of [SyncOfflinePlatform] that uses method channels.
class MethodChannelSyncOffline extends SyncOfflinePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('sync_offline');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
