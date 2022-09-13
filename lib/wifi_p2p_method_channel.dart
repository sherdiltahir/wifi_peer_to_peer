import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'wifi_p2p_platform_interface.dart';

/// An implementation of [WifiP2pPlatform] that uses method channels.
class MethodChannelWifiP2p extends WifiP2pPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('wifi_p2p');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> wifiNetwork() async {
    final wifiP2P =
        await methodChannel.invokeMethod<String>('getPeerConnection');
    return wifiP2P;
  }
}
