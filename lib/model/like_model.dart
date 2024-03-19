class LikeModel {
  LikeModel({
    required this.statusCode,
    required this.type,
    required this.data,
  });
  late final int statusCode;
  late final dynamic type;
  late final List<Data> data;

  LikeModel.fromJson(Map<dynamic, dynamic> json) {
    statusCode = json['statusCode'];
    type = json['type'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<dynamic, dynamic> toJson() {
    final userData = <dynamic, dynamic>{};
    userData['statusCode'] = statusCode;
    userData['type'] = type;
    userData['data'] = data.map((e) => e.toJson()).toList();
    return userData;
  }
}

class Data {
  Data({
    required this.id,
    required this.createdAt,
    required this.userName,
    required this.displayPicture,
    required this.name,
  });
  late final dynamic id;
  late final dynamic createdAt;
  late final dynamic userName;
  late final dynamic displayPicture;
  late final dynamic name;

  Data.fromJson(Map<dynamic, dynamic> json) {
    id = json['_id'];
    createdAt = json['createdAt'];
    userName = json['userName'];
    displayPicture = json['displayPicture'];
    name = json['name'];
  }

  Map<dynamic, dynamic> toJson() {
    final userData = <dynamic, dynamic>{};
    userData['_id'] = id;
    userData['createdAt'] = createdAt;
    userData['userName'] = userName;
    userData['displayPicture'] = displayPicture;
    userData['name'] = name;
    return userData;
  }
}
