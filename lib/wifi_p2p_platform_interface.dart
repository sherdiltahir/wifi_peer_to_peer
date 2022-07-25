import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'wifi_p2p_method_channel.dart';

abstract class WifiP2pPlatform extends PlatformInterface {
  /// Constructs a WifiP2pPlatform.
  WifiP2pPlatform() : super(token: _token);

  static final Object _token = Object();

  static WifiP2pPlatform _instance = MethodChannelWifiP2p();

  /// The default instance of [WifiP2pPlatform] to use.
  ///
  /// Defaults to [MethodChannelWifiP2p].
  static WifiP2pPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WifiP2pPlatform] when
  /// they register themselves.
  static set instance(WifiP2pPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<String?> wifiNetwork() {
    throw UnimplementedError('wifIp2p() has not been implemented.');
  }
}
