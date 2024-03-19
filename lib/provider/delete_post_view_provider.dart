import 'package:flutter/material.dart';
import 'package:instagram/repository/user_profile_repository.dart';
import 'package:instagram/ui_helper/ui_helper.dart';

class DeletePostViewModel with ChangeNotifier {
  bool _deleteLoading = false;
  bool get deleteLoading => _deleteLoading;

  void loading(bool value) {
    _deleteLoading = value;
    notifyListeners();
  }

  final _myRepo = UserProfileRepository();

// ************************* DELETE POST API ************************
  Future<void> deletePostApi(String postId, BuildContext context) async {
    loading(true);

    _myRepo.deleteApi(postId).then((value) {
      loading(false);
    }).onError((error, stackTrace) {
      loading(false);
      UiHelper.toastMessage(error.toString());
    });
  }
}
