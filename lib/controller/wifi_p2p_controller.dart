import 'dart:convert';

import 'package:wifi_p2p/model/wifi_p2p_model.dart';
import 'package:wifi_p2p/wifi_p2p.dart';

class WifiP2PController {
  List<WifiP2PModel> wifiP2PModel = <WifiP2PModel>[];
  WifiP2p wifiP2p = WifiP2p();
  Future<List<WifiP2PModel>> getWifiConnection() async {
    String? wifiNetworks = await wifiP2p.connectedWifiNetwork() ?? "";
    if (wifiNetworks.isNotEmpty) {
      var data = jsonDecode(wifiNetworks);

      wifiP2PModel = List.generate(
          data.length,
          (index) => WifiP2PModel(
              hostName: data[index]["hostName"].toString(),
              ipAddress: data[index]["ipAddress"].toString()));
      return wifiP2PModel;
    } else {
      return [];
    }
  }
}
