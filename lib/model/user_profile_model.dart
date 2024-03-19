class UserProfileModel {
  UserProfileModel({
    required this.statusCode,
    required this.type,
    required this.data,
  });
  late final dynamic statusCode;
  late final dynamic type;
  late final Data data;

  UserProfileModel.fromJson(Map<dynamic, dynamic> json) {
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
    required this.profile,
  });
  late final Profile profile;

  Data.fromJson(Map<dynamic, dynamic> json) {
    profile = Profile.fromJson(json['profile']);
  }

  Map<dynamic, dynamic> toJson() {
    final userData = <dynamic, dynamic>{};
    userData['profile'] = profile.toJson();
    return userData;
  }
}

class Profile {
  Profile({
    required this.userId,
    required this.name,
    required this.userName,
    required this.displayPicture,
    required this.about,
    required this.totalPosts,
    required this.followersCount,
    required this.followingCount,
    required this.isFollowing,
    required this.posts,
  });
  late final dynamic userId;
  late final dynamic name;
  late final dynamic userName;
  late final dynamic displayPicture;
  late final dynamic about;
  late final dynamic totalPosts;
  late final dynamic followersCount;
  late final dynamic followingCount;
  late final int isFollowing;
  late final List<Posts> posts;

  Profile.fromJson(Map<dynamic, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    userName = json['userName'];
    displayPicture = json['displayPicture'];
    about = json['about'];
    totalPosts = json['totalPosts'];
    followersCount = json['followersCount'];
    followingCount = json['followingCount'];
    isFollowing = json['isFollowing'];
    posts = List.from(json['posts']).map((e) => Posts.fromJson(e)).toList();
  }

  Map<dynamic, dynamic> toJson() {
    final userData = <dynamic, dynamic>{};
    userData['userId'] = userId;
    userData['name'] = name;
    userData['userName'] = userName;
    userData['displayPicture'] = displayPicture;
    userData['about'] = about;
    userData['totalPosts'] = totalPosts;
    userData['followersCount'] = followersCount;
    userData['followingCount'] = followingCount;
    userData['isFollowing'] = isFollowing;
    userData['posts'] = posts.map((e) => e.toJson()).toList();
    return userData;
  }
}

class Posts {
  Posts({
    required this.id,
    required this.userId,
    required this.content,
    required this.caption,
    required this.createdAt,
    required this.liked,
    required this.numberOfLikes,
    required this.numberOfComments,
  });
  late final dynamic id;
  late final dynamic userId;
  late final dynamic content;
  late final dynamic caption;
  late final dynamic createdAt;
  late final dynamic liked;
  late final dynamic numberOfLikes;
  late final dynamic numberOfComments;

  Posts.fromJson(Map<dynamic, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    content = json['content'];
    caption = json['caption'];
    createdAt = json['createdAt'];
    liked = json['liked'];
    numberOfLikes = json['numberOfLikes'];
    numberOfComments = json['numberOfComments'];
  }

  Map<dynamic, dynamic> toJson() {
    final userData = <dynamic, dynamic>{};
    userData['_id'] = id;
    userData['userId'] = userId;
    userData['content'] = content;
    userData['caption'] = caption;
    userData['createdAt'] = createdAt;
    userData['liked'] = liked;
    userData['numberOfLikes'] = numberOfLikes;
    userData['numberOfComments'] = numberOfComments;
    return userData;
  }
}
