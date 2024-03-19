class SearchModel {
  SearchModel({
    required this.statusCode,
    required this.type,
    required this.data,
  });
  late final int statusCode;
  late final dynamic type;
  late final List<Data> data;

  SearchModel.fromJson(Map<dynamic, dynamic> json) {
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
    required this.name,
    required this.userName,
    required this.displayPicture,
    required this.about,
  });
  late final dynamic id;
  late final dynamic name;
  late final dynamic userName;
  late final dynamic displayPicture;
  late final dynamic about;

  Data.fromJson(Map<dynamic, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    userName = json['userName'];
    displayPicture = json['displayPicture'];
    about = json['about'];
  }

  Map<dynamic, dynamic> toJson() {
    final userData = <dynamic, dynamic>{};
    userData['_id'] = id;
    userData['name'] = name;
    userData['userName'] = userName;
    userData['displayPicture'] = displayPicture;
    userData['about'] = about;
    return userData;
  }
}
