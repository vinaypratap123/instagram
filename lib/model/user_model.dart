class UserModel {
  UserModel({
    required this.statusCode,
    required this.type,
    required this.data,
  });
  late final String statusCode;
  late final String type;
  late final Data data;

  UserModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    type = json['type'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final userData = <String, dynamic>{};
    userData['statusCode'] = statusCode;
    userData['type'] = type;
    userData['data'] = data.toJson();
    return userData;
  }
}

class Data {
  Data({
    required this.userId,
    required this.token,
  });
  late final String userId;
  late final String token;

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final userData = <String, dynamic>{};
    userData['userId'] = userId;
    userData['token'] = token;
    return userData;
  }
}
