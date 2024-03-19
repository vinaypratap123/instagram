class FeedModel {
  FeedModel({
    required this.statusCode,
    required this.type,
    required this.data,
  });
  late final dynamic statusCode;
  late final dynamic type;
  late final Data data;

  FeedModel.fromJson(Map<dynamic, dynamic> json) {
    statusCode = json['statusCode'];
    type = json['type'];
    data = Data.fromJson(json['data']);
  }

  Map<dynamic, dynamic> toJson() {
    final userData = <dynamic, dynamic>{};
    userData['statusCode'] = statusCode;
    userData['type'] = type;
    userData['data'] = data.toJson();
    return userData;
  }
}

class Data {
  Data({
    required this.feed,
  });
  late final List<Feed> feed;

  Data.fromJson(Map<dynamic, dynamic> json) {
    feed = List.from(json['feed']).map((e) => Feed.fromJson(e)).toList();
  }

  Map<dynamic, dynamic> toJson() {
    final userData = <dynamic, dynamic>{};
    userData['feed'] = feed.map((e) => e.toJson()).toList();
    return userData;
  }
}

class Feed {
  Feed({
    required this.id,
    required this.userId,
    required this.followingId,
    required this.followedPosts,
    required this.user,
    required this.liked,
    required this.numberOfLikes,
    required this.numberOfComments,
  });
  late final dynamic id;
  late final dynamic userId;
  late final dynamic followingId;
  late final FollowedPosts followedPosts;
  late final User user;
  late final dynamic liked;
  late final dynamic numberOfLikes;
  late final dynamic numberOfComments;

  Feed.fromJson(Map<dynamic, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    followingId = json['followingId'];
    followedPosts = FollowedPosts.fromJson(json['followedPosts']);
    user = User.fromJson(json['user']);
    liked = json['liked'];
    numberOfLikes = json['numberOfLikes'];
    numberOfComments = json['numberOfComments'];
  }

  Map<dynamic, dynamic> toJson() {
    final userData = <dynamic, dynamic>{};
    userData['_id'] = id;
    userData['userId'] = userId;
    userData['followingId'] = followingId;
    userData['followedPosts'] = followedPosts.toJson();
    userData['user'] = user.toJson();
    userData['liked'] = liked;
    userData['numberOfLikes'] = numberOfLikes;
    userData['numberOfComments'] = numberOfComments;
    return userData;
  }
}

class FollowedPosts {
  FollowedPosts({
    required this.userId,
    required this.content,
    required this.caption,
    required this.createdAt,
    required this.postId,
  });
  late final dynamic userId;
  late final dynamic content;
  late final dynamic caption;
  late final dynamic createdAt;
  late final dynamic postId;

  FollowedPosts.fromJson(Map<dynamic, dynamic> json) {
    userId = json['userId'];
    content = json['content'];
    caption = json['caption'];
    createdAt = json['createdAt'];
    postId = json['postId'];
  }

  Map<dynamic, dynamic> toJson() {
    final userData = <dynamic, dynamic>{};
    userData['userId'] = userId;
    userData['content'] = content;
    userData['caption'] = caption;
    userData['createdAt'] = createdAt;
    userData['postId'] = postId;
    return userData;
  }
}

class User {
  User({
    required this.id,
    required this.name,
    required this.userName,
    required this.displayPicture,
    required this.V,
  });
  late final dynamic id;
  late final dynamic name;
  late final dynamic userName;
  late final dynamic displayPicture;
  late final dynamic V;

  User.fromJson(Map<dynamic, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    userName = json['userName'];
    displayPicture = json['displayPicture'];
    V = json['_V'];
  }

  Map<dynamic, dynamic> toJson() {
    final userData = <dynamic, dynamic>{};
    userData['_id'] = id;
    userData['name'] = name;
    userData['userName'] = userName;
    userData['displayPicture'] = displayPicture;
    userData['_V'] = V;
    return userData;
  }
}
