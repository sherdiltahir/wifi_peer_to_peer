class WifiNetworkModel {
  String? name;
  String? macAddress;
  int? frequency;
  int? strength;
  String? channelWidth;
  int? level;

  WifiNetworkModel(
      {this.name,
        this.macAddress,
        this.frequency,
        this.strength,
        this.channelWidth,
        this.level});

  WifiNetworkModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    macAddress = json['macAddress'];
    frequency = json['frequency'];
    strength = json['strength'];
    channelWidth = json['channelWidth'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['macAddress'] = macAddress;
    data['frequency'] = frequency;
    data['strength'] = strength;
    data['channelWidth'] = channelWidth;
    data['level'] = level;
    return data;
  }
}