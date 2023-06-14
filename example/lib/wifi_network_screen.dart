import 'package:flutter/material.dart';
import 'package:wifi_p2p/controller/wifi_p2p_controller.dart';
import 'package:wifi_p2p/model/wifi_network_model.dart';

class WifiNetworkScreen extends StatefulWidget {
  const WifiNetworkScreen({super.key});

  @override
  State<WifiNetworkScreen> createState() => _WifiNetworkScreenState();
}

class _WifiNetworkScreenState extends State<WifiNetworkScreen> {
  Future<List<WifiNetworkModel>> init() async {
    return await WifiP2PController.getWifiNetwork();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wifi network"),
      ),
      body: FutureBuilder(future:  init(),builder: (context,AsyncSnapshot<List<WifiNetworkModel>> snapShot) {
        if (snapShot.hasData) {
          return ListView.builder(
              itemCount: snapShot.data?.length,
              itemBuilder: (context, int index) {
                return Text(snapShot.data![index].name!);
              });
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      }),
    );
  }
}
