package com.example.wifi_p2p;

import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;


import com.stealthcopter.networktools.SubnetDevices;
import com.stealthcopter.networktools.subnet.Device;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.CompletableFuture;

/** WifiP2pPlugin */
public class WifiP2pPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
    ArrayList<Map<String,String>> subnetDetailsArrayList = new ArrayList<>();

    public void findSubnetDevices() {
        final long startTimeMillis = System.currentTimeMillis();
        subnetDetailsArrayList.clear();
        SubnetDevices.fromLocalAddress().findDevices(new SubnetDevices.OnSubnetDeviceFound() {

            @Override
            public void onDeviceFound(Device device) {
                SubnetDetails subnetDetails = new SubnetDetails(device.ip, device.mac, device.hostname);
                Log.d("network", subnetDetails.toString());
                Map<String, String> networkData = new HashMap<>();
                networkData.put("mac", subnetDetails.macAddress);
                networkData.put("ipAddress", subnetDetails.ipAddress);
                networkData.put("hostName", subnetDetails.deviceName);
                Log.d("flutter", String.valueOf(networkData));
                subnetDetailsArrayList.add(networkData);
            }

            @Override
            public void onFinished(ArrayList<Device> devicesFound) {
                float timeTaken = (System.currentTimeMillis() - startTimeMillis) / 1000.0f;
                System.out.print(timeTaken);

            }

        });
    }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "wifi_p2p");
    channel.setMethodCallHandler(this);
  }

  @RequiresApi(api = Build.VERSION_CODES.N)
  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    }else if (call.method.equals("helloWorld")) {

       CompletableFuture.runAsync(this::findSubnetDevices).thenRunAsync(()->
               Log.d("Networks id",subnetDetailsArrayList.toString())
              ).thenRunAsync(()-> result.success(subnetDetailsArrayList.toString()));


    } else {
      result.notImplemented();
    }
  }



  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}

 class SubnetDetails{
  final String ipAddress;
  final String macAddress;
  final String deviceName;

  SubnetDetails(String ip,String mac,String devices){
    ipAddress = ip;
    macAddress = mac;
    deviceName = devices;
  }

}

