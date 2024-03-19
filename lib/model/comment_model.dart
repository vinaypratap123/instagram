class CommentModel {
  CommentModel({
    required this.statusCode,
    required this.type,
    required this.data,
  });
  late final int statusCode;
  late final String type;
  late final List<Data> data;

  CommentModel.fromJson(Map<String, dynamic> json) {
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
    required this.postId,
    required this.comment,
    required this.createdAt,
    required this.user,
    required this.commentId,
  });
  late final String userId;
  late final String postId;
  late final String comment;
  late final String createdAt;
  late final User user;
  late final String commentId;

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    postId = json['postId'];
    comment = json['comment'];
    createdAt = json['createdAt'];
    user = User.fromJson(json['user']);
    commentId = json['commentId'];
  }

  Map<String, dynamic> toJson() {
    final userData = <String, dynamic>{};
    userData['userId'] = userId;
    userData['postId'] = postId;
    userData['comment'] = comment;
    userData['createdAt'] = createdAt;
    userData['user'] = user.toJson();
    userData['commentId'] = commentId;
    return userData;
  }
}

class User {
  User({
    required this.name,
    required this.userName,
    required this.displayPicture,
  });
  late final String name;
  late final String userName;
  late final String displayPicture;

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userName = json['userName'];
    displayPicture = json['displayPicture'];
  }

  Map<String, dynamic> toJson() {
    final userData = <String, dynamic>{};
    userData['name'] = name;
    userData['userName'] = userName;
    userData['displayPicture'] = displayPicture;
    return userData;
  }
}
