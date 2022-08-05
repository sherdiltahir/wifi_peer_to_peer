import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wifi_p2p/controller/wifi_p2p_controller.dart';
import 'package:wifi_p2p/model/wifi_p2p_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<WifiP2PModel> _platformVersion = [];
  final _wifiP2pPlugin = WifiP2PController();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    List<WifiP2PModel> platformVersion = [];
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _wifiP2pPlugin.getWifiConnection();
    } on PlatformException {
      platformVersion = [];
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ListView.builder(
              itemCount: _platformVersion.length,
              itemBuilder: (context, int index) => ListTile(
                    title: Text(_platformVersion[index].hostName),
                    trailing: Text(_platformVersion[index].ipAddress),
                  )),
        ),
      ),
    );
  }
}
