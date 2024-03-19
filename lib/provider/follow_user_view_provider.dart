import 'package:flutter/material.dart';
import 'package:instagram/repository/user_profile_repository.dart';
import 'package:instagram/ui_helper/ui_helper.dart';

class FollowUserViewModel with ChangeNotifier {
  final _myRepo = UserProfileRepository();

// ************************* FOLLOW API ************************
  Future<void> followApi(String userId, BuildContext context) async {
    _myRepo.followApi(userId).then((value) {
      String statusCode = value["statusCode"].toString();

      if (statusCode == "200") {
        UiHelper.flushBarMessage(context, "Follow SuccessFully");
      }
    }).onError((error, stackTrace) {
      UiHelper.toastMessage(error.toString());
    });
  }
}
