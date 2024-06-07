// import 'package:flutter_test/flutter_test.dart';
// import 'package:sync_offline/sync_offline.dart';
// import 'package:sync_offline/sync_offline_platform_interface.dart';
// import 'package:sync_offline/sync_offline_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockSyncOfflinePlatform
//     with MockPlatformInterfaceMixin
//     implements SyncOfflinePlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final SyncOfflinePlatform initialPlatform = SyncOfflinePlatform.instance;
//
//   test('$MethodChannelSyncOffline is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelSyncOffline>());
//   });
//
//   test('getPlatformVersion', () async {
//     SyncOffline syncOfflinePlugin = SyncOffline();
//     MockSyncOfflinePlatform fakePlatform = MockSyncOfflinePlatform();
//     SyncOfflinePlatform.instance = fakePlatform;
//
//     expect(await syncOfflinePlugin.getPlatformVersion(), '42');
//   });
// }
