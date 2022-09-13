package com.example.wifi_p2p;


import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
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

import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;


/** WifiP2pPlugin */
public class WifiP2pPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
    ArrayList<JSONObject> subnetDetailsArrayList = new ArrayList<>();
    SubnetDevices subnetDevices;
    Context appContext;
    boolean checkConnectivity(@NonNull Context context){
        ConnectivityManager connectivityManager =
                (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo activeNetwork = connectivityManager.getActiveNetworkInfo();

        return activeNetwork.getType() == ConnectivityManager.TYPE_WIFI;

    }



    public void findSubnetDevices(@NonNull Result result) {

        if(checkConnectivity(appContext)){
            final long startTimeMillis = System.currentTimeMillis();
            subnetDetailsArrayList.clear();
            SubnetDevices.fromLocalAddress().findDevices(new SubnetDevices.OnSubnetDeviceFound() {

                @Override
                public void onDeviceFound(Device device) {
                    SubnetDetails subnetDetails = new SubnetDetails(device.ip, device.mac, device.hostname);
                    Log.d("network", subnetDetails.toString());

                    JSONObject jsonObject = new JSONObject();
                    try {
                        jsonObject.put("ipAddress", device.ip);
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                    try {
                        jsonObject.put("hostName", device.hostname);
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }


                    Log.d("flutter", String.valueOf(jsonObject));
                    subnetDetailsArrayList.add(jsonObject);
                }

                @Override
                public void onFinished(ArrayList<Device> devicesFound) {
                    float timeTaken = (System.currentTimeMillis() - startTimeMillis) / 1000.0f;
                    System.out.print(timeTaken);
                    result.success(subnetDetailsArrayList.toString());


                }
            });
        }else{
            result.success(subnetDetailsArrayList.toString());

        }

    }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "wifi_p2p");
      appContext = flutterPluginBinding.getApplicationContext();
    channel.setMethodCallHandler(this);
  }

  @RequiresApi(api = Build.VERSION_CODES.N)
  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    }else if (call.method.equals("getPeerConnection")) {

            findSubnetDevices(result);



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

