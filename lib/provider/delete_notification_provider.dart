import 'package:flutter/material.dart';
import 'package:instagram/repository/notification_repository.dart';
import 'package:instagram/ui_helper/ui_helper.dart';

class DeleteNotificationViewModel with ChangeNotifier {
  // bool _deleteLoading = false;
  // bool get deleteLoading => _deleteLoading;

  // void loading(bool value) {
  //   _deleteLoading = value;
  //   notifyListeners();
  // }

  final _myRepo = NotificationRepository();

// ************************* DELETE POST API ************************
  Future<void> deleteNotificationApi(String notificationId, BuildContext context) async {
    // loading(true);

    _myRepo.deleteNotificationApi(notificationId).then((value) {
      UiHelper.flushBarMessage(context, "Notification Deleted Successfully");
      // loading(false);
    }).onError((error, stackTrace) {
      // loading(false);
      UiHelper.toastMessage(error.toString());
    });
  }
}