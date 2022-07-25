import 'package:flutter_test/flutter_test.dart';
import 'package:wifi_p2p/wifi_p2p.dart';
import 'package:wifi_p2p/wifi_p2p_platform_interface.dart';
import 'package:wifi_p2p/wifi_p2p_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWifiP2pPlatform 
    with MockPlatformInterfaceMixin
    implements WifiP2pPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final WifiP2pPlatform initialPlatform = WifiP2pPlatform.instance;

  test('$MethodChannelWifiP2p is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWifiP2p>());
  });

  test('getPlatformVersion', () async {
    WifiP2p wifiP2pPlugin = WifiP2p();
    MockWifiP2pPlatform fakePlatform = MockWifiP2pPlatform();
    WifiP2pPlatform.instance = fakePlatform;
  
    expect(await wifiP2pPlugin.getPlatformVersion(), '42');
  });
}
