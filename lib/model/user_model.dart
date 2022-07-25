class userDetailModel {
  final String name;
  final String address;
  userDetailModel({
    required this.name,
    required this.address,
  });

  Map<String, dynamic> getJson() => {
        "name": name,
        "address": address,
      };

  factory userDetailModel.getModelFromJson(Map<String, dynamic> json) {
    return userDetailModel(name: json['name'], address: json['address']);
  }
}
