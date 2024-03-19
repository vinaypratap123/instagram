import 'package:flutter/material.dart';
import 'package:instagram/repository/user_profile_repository.dart';
import 'package:instagram/ui_helper/ui_helper.dart';

class UnFollowUserViewModel with ChangeNotifier {
  bool _removeLoading = false;
  bool get removeLoading => _removeLoading;

  void loading(bool value) {
    _removeLoading = value;
    notifyListeners();
  }

  final _myRepo = UserProfileRepository();

// *************************  UN FOLLOW API ************************
  Future<void> unFollowApi(String userId, BuildContext context) async {
    loading(true);

    _myRepo.unFollowApi(userId).then((value) {
     
      loading(false);
    }).onError((error, stackTrace) {
      loading(false);
      UiHelper.toastMessage(error.toString());
    });
  }
}
