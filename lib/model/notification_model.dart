class NotificationModel {
  NotificationModel({
    required this.statusCode,
    required this.type,
    required this.data,
  });
  late final int statusCode;
  late final dynamic type;
  late final Data data;
  
  NotificationModel.fromJson(Map<dynamic, dynamic> json){
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
    required this.notifications,
  });
  late final List<Notifications> notifications;
  
  Data.fromJson(Map<dynamic, dynamic> json){
    notifications = List.from(json['notifications']).map((e)=>Notifications.fromJson(e)).toList();
  }

  Map<dynamic, dynamic> toJson() {
    final userData = <dynamic, dynamic>{};
    userData['notifications'] = notifications.map((e)=>e.toJson()).toList();
    return userData;
  }
}

class Notifications {
  Notifications({
    required this.id,
    required this.senderId,
    required this.recieverId,
    required this.message,
    required this.type,
    required this.status,
    required this.read,
    required this.createdAt,
    required this.notificationData,
  });
  late final dynamic id;
  late final dynamic senderId;
  late final dynamic recieverId;
  late final dynamic message;
  late final dynamic type;
  late final bool status;
  late final bool read;
  late final dynamic createdAt;
  late final NotificationData notificationData;
  
  Notifications.fromJson(Map<dynamic, dynamic> json){
    id = json['_id'];
    senderId = json['senderId'];
    recieverId = json['recieverId'];
    message = json['message'];
    type = json['type'];
    status = json['status'];
    read = json['read'];
    createdAt = json['createdAt'];
    notificationData = NotificationData.fromJson(json['notification_data']);
  }

  Map<dynamic, dynamic> toJson() {
    final userData = <dynamic, dynamic>{};
    userData['_id'] = id;
    userData['senderId'] = senderId;
    userData['recieverId'] = recieverId;
    userData['message'] = message;
    userData['type'] = type;
    userData['status'] = status;
    userData['read'] = read;
    userData['createdAt'] = createdAt;
    userData['notification_data'] = notificationData.toJson();
    return userData;
  }
}

class NotificationData {
  NotificationData({
    required this.name,
    required this.userName,
    required this.displayPicture,
    required this.V,
  });
  late final dynamic name;
  late final dynamic userName;
  late final dynamic displayPicture;
  late final int V;
  
  NotificationData.fromJson(Map<dynamic, dynamic> json){
    name = json['name'];
    userName = json['userName'];
    displayPicture = json['displayPicture'];
    V = json['__v'];
  }

  Map<dynamic, dynamic> toJson() {
    final userData = <dynamic, dynamic>{};
    userData['name'] = name;
    userData['userName'] = userName;
    userData['displayPicture'] = displayPicture;
    userData['__v'] = V;
    return userData;
  }
}


// class NotificationModel {
//   NotificationModel({
//     required this.statusCode,
//     required this.type,
//     required this.data,
//   });
//   late final int statusCode;
//   late final dynamic type;
//   late final Data data;
  
//   NotificationModel.fromJson(Map<dynamic, dynamic> json){
//     statusCode = json['statusCode'];
//     type = json['type'];
//     data = Data.fromJson(json['data']);
//   }

//   Map<dynamic, dynamic> toJson() {
//     final userData = <dynamic, dynamic>{};
//     userData['statusCode'] = statusCode;
//     userData['type'] = type;
//     userData['data'] = data.toJson();
//     return userData;
//   }
// }

// class Data {
//   Data({
//     required this.notifications,
//   });
//   late final List<Notifications> notifications;
  
//   Data.fromJson(Map<dynamic, dynamic> json){
//     notifications = List.from(json['notifications']).map((e)=>Notifications.fromJson(e)).toList();
//   }

//   Map<dynamic, dynamic> toJson() {
//     final userData = <dynamic, dynamic>{};
//     userData['notifications'] = notifications.map((e)=>e.toJson()).toList();
//     return userData;
//   }
// }

// class Notifications {
//   Notifications({
//     required this.id,
//     required this.senderId,
//     required this.recieverId,
//     required this.title,
//     required this.message,
//     required this.type,
//     required this.actionId,
//     required this.status,
//     required this.read,
//     required this.createdAt,
//     required this.notificationData,
//   });
//   late final dynamic id;
//   late final dynamic senderId;
//   late final dynamic recieverId;
//   late final dynamic title;
//   late final dynamic message;
//   late final dynamic type;
//   late final dynamic actionId;
//   late final bool? status;
//   late final bool read;
//   late final dynamic? createdAt;
//   late final NotificationData? notificationData;
  
//   Notifications.fromJson(Map<dynamic, dynamic> json){
//     id = json['_id'];
//     senderId = json['senderId'];
//     recieverId = json['recieverId'];
//     title = json['title'];
//     message = json['message'];
//     type = json['type'];
//     actionId = json['actionId'];
//     status = json['status'];
//     read = json['read'];
//     createdAt = json['createdAt'];
//     notificationData = json['notificationuserData'];
//   }

//   Map<dynamic, dynamic> toJson() {
//     final userData = <dynamic, dynamic>{};
//     userData['_id'] = id;
//     userData['senderId'] = senderId;
//     userData['recieverId'] = recieverId;
//     userData['title'] = title;
//     userData['message'] = message;
//     userData['type'] = type;
//     userData['actionId'] = actionId;
//     userData['status'] = status;
//     userData['read'] = read;
//     userData['createdAt'] = createdAt;
//     userData['notificationuserData'] = notificationData;
//     return userData;
//   }
// }

// class NotificationData {
//   NotificationData({
//     required this.name,
//     required this.userName,
//     required this.displayPicture,
//     required this.V,
//   });
//   late final dynamic name;
//   late final dynamic userName;
//   late final dynamic displayPicture;
//   late final int V;
  
//   NotificationData.fromJson(Map<dynamic, dynamic> json){
//     name = json['name'];
//     userName = json['userName'];
//     displayPicture = json['displayPicture'];
//     V = json['__v'];
//   }

//   Map<dynamic, dynamic> toJson() {
//     final userData = <dynamic, dynamic>{};
//     userData['name'] = name;
//     userData['userName'] = userName;
//     userData['displayPicture'] = displayPicture;
//     userData['__v'] = V;
//     return userData;
//   }
// }

// class NotificationModel {
//   NotificationModel({
//     required this.statusCode,
//     required this.type,
//     required this.data,
//   });
//   late final int statusCode;
//   late final dynamic type;
//   late final Data data;
  
//   NotificationModel.fromJson(Map<dynamic, dynamic> json){
//     statusCode = json['statusCode'];
//     type = json['type'];
//     data = Data.fromJson(json['data']);
//   }

//   Map<dynamic, dynamic> toJson() {
//     final notication = <dynamic, dynamic>{};
//     notication['statusCode'] = statusCode;
//     notication['type'] = type;
//     notication['data'] = data.toJson();
//     return notication;
//   }
// }

// class Data {
//   Data({
//     required this.notifications,
//   });
//   late final List<Notifications> notifications;
  
//   Data.fromJson(Map<dynamic, dynamic> json){
//     notifications = List.from(json['notifications']).map((e)=>Notifications.fromJson(e)).toList();
//   }

//   Map<dynamic, dynamic> toJson() {
//     final notication = <dynamic, dynamic>{};
//     notication['notifications'] = notifications.map((e)=>e.toJson()).toList();
//     return notication;
//   }
// }

// class Notifications {
//   Notifications({
//     required this.id,
//     required this.senderId,
//     required this.recieverId,
//     required this.notificationIcon,
//     required this.title,
//     required this.message,
//     required this.type,
//     required this.actionId,
//     required this.status,
//     required this.read,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.V,
//   });
//   late final dynamic id;
//   late final dynamic senderId;
//   late final dynamic recieverId;
//   late final dynamic notificationIcon;
//   late final dynamic title;
//   late final dynamic message;
//   late final dynamic type;
//   late final dynamic actionId;
//   late final bool status;
//   late final bool read;
//   late final dynamic createdAt;
//   late final dynamic updatedAt;
//   late final int V;
  
//   Notifications.fromJson(Map<dynamic, dynamic> json){
//     id = json['_id'];
//     senderId = json['senderId'];
//     recieverId = json['recieverId'];
//     notificationIcon = json['notificationIcon'];
//     title = json['title'];
//     message = json['message'];
//     type = json['type'];
//     actionId = json['actionId'];
//     status = json['status'];
//     read = json['read'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     V = json['__v'];
//   }
//   Map<dynamic, dynamic> toJson() {
//     final notication = <dynamic, dynamic>{};
//     notication['_id'] = id;
//     notication['senderId'] = senderId;
//     notication['recieverId'] = recieverId;
//     notication['notificationIcon'] = notificationIcon;
//     notication['title'] = title;
//     notication['message'] = message;
//     notication['type'] = type;
//     notication['actionId'] = actionId;
//     notication['status'] = status;
//     notication['read'] = read;
//     notication['createdAt'] = createdAt;
//     notication['updatedAt'] = updatedAt;
//     notication['__v'] = V;
//     return notication;
//   }
// }