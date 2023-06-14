class WifiNetworkModel {
  String? name;
  String? macAddress;
  int? frequency;
  int? strength;
  String? capabilities;
  int? level;

  WifiNetworkModel(
      {this.name,
        this.macAddress,
        this.frequency,
        this.strength,
        this.capabilities,
        this.level});

  WifiNetworkModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    macAddress = json['macAddress'];
    frequency = json['frequency'];
    strength = json['strength'];
    capabilities = json['capabilities'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['macAddress'] = macAddress;
    data['frequency'] = frequency;
    data['strength'] = strength;
    data['capabilities'] = capabilities;
    data['level'] = level;
    return data;
  }
}