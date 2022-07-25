
import 'wifi_p2p_platform_interface.dart';

class WifiP2p {
  Future<String?> getPlatformVersion() {
    return WifiP2pPlatform.instance.getPlatformVersion();
  }
  Future<String?> wifiNetwork() {
    return WifiP2pPlatform.instance.wifiNetwork();
  }
}

