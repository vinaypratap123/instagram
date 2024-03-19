class OtherUserFollowersModel {
  OtherUserFollowersModel({
    required this.statusCode,
    required this.type,
    required this.data,
  });
  late final dynamic statusCode;
  late final dynamic type;
  late final List<Data> data;

  OtherUserFollowersModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    type = json['type'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final userData = <String, dynamic>{};
    userData['statusCode'] = statusCode;
    userData['type'] = type;
    userData['data'] = data.map((e) => e.toJson()).toList();
    return userData;
  }
}

class Data {
  Data({
    required this.userId,
    required this.userName,
    required this.name,
    required this.displayPicture,
  });
  late final dynamic userId;
  late final dynamic userName;
  late final dynamic name;
  late final dynamic displayPicture;

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    name = json['name'];
    displayPicture = json['displayPicture'];
  }

  Map<String, dynamic> toJson() {
    final userData = <String, dynamic>{};
    userData['userId '] = userId;
    userData['userName'] = userName;
    userData['name'] = name;
    userData['displayPicture'] = displayPicture;
    return userData;
  }
}
