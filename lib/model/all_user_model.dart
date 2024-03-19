class AllUserModel {
  AllUserModel({
    required this.statusCode,
    required this.type,
    required this.data,
  });
  late final dynamic statusCode;
  late final dynamic type;
  late final List<Data> data;

  AllUserModel.fromJson(Map<String, dynamic> json) {
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
    required this.email,
    required this.displayPicture,
    required this.about,
  });
  late final String userId;
  late final String userName;
  late final String name;
  late final String email;
  late final String displayPicture;
  late final String about;

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    name = json['name'];
    email = json['email'];
    displayPicture = json['displayPicture'];
    about = json['about'];
  }

  Map<String, dynamic> toJson() {
    final userData = <String, dynamic>{};
    userData['userId'] = userId;
    userData['userName'] = userName;
    userData['name'] = name;
    userData['email'] = email;
    userData['displayPicture'] = displayPicture;
    userData['about'] = about;
    return userData;
  }
}
