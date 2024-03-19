import 'package:flutter/material.dart';
import 'package:instagram/data/response/api_response.dart';
import 'package:instagram/model/notification_model.dart';
import 'package:instagram/repository/notification_repository.dart';
import 'package:instagram/ui_helper/ui_helper.dart';

class NotificationViewModel with ChangeNotifier {
  final _myRepo = NotificationRepository();

  // ************************* LOGIN API ************************
  Future<void> notificationsApi(dynamic data, BuildContext context) async {
   
    _myRepo.notificationApi(data).then((value) {
   
    }).onError((error, stackTrace) {
    
      UiHelper.toastMessage(error.toString());
    });
  }

  ApiResponse<NotificationModel> notificationList = ApiResponse.loading();
  setNotificationList(ApiResponse<NotificationModel> response) {
    notificationList = response;
    notifyListeners();
  }

  Future<void> fetchNotificationList(int page) async {
    setNotificationList(ApiResponse.loading());

    _myRepo.getNotificationListApi(page).then((value) {
      setNotificationList(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setNotificationList(ApiResponse.error(error.toString()));
    });
  }
}
