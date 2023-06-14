
import 'wifi_p2p_platform_interface.dart';

class WifiP2p {
  Future<String?> getPlatformVersion() {
    return WifiP2pPlatform.instance.getPlatformVersion();
  }
  Future<String?> connectedWifiNetwork() {
    return WifiP2pPlatform.instance.connectedWifiNetwork();
  }

  Future<String?> getWifiRouters(){
    return WifiP2pPlatform.instance.getWifiRouters();
}
}

