import 'package:flutter/material.dart';
import 'package:instagram/data/response/api_response.dart';
import 'package:instagram/model/user_profile_model.dart';
import 'package:instagram/repository/user_profile_repository.dart';
import 'package:instagram/ui_helper/ui_helper.dart';

class UserProfileViewModel with ChangeNotifier {
  final _myRepo = UserProfileRepository();
  ApiResponse<UserProfileModel> userProfile = ApiResponse.loading();
  setUserProfile(ApiResponse<UserProfileModel> response) {
    userProfile = response;
    notifyListeners();
  }

  Future<void> fetchUserProfile() async {
    setUserProfile(ApiResponse.loading());
    _myRepo.getUserProfileApi().then((value) {
      setUserProfile(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setUserProfile(ApiResponse.error(error.toString()));
    });
  }

  // ************************* FOLLOW USER API ************************
  Future<void> followUser(String userId, BuildContext context) async {
    _myRepo.followApi(userId).then((value) {
      String statusCode = value["statusCode"].toString();

      if (statusCode == "200") {
        UiHelper.flushBarMessage(context, "Follow  SuccessFully");
      }
    }).onError((error, stackTrace) {
      UiHelper.toastMessage(error.toString());
    });
  }

  // ************************* Edit Profile API ************************
  Future<void> editProfileApi(dynamic data, BuildContext context) async {
    _myRepo.editProfileApi(data).then((value) {
      String statusCode = value["statusCode"].toString();

      if (statusCode == "200") {
        UiHelper.flushBarMessage(context, "Profile Edited SuccessFully");
      }
    }).onError((error, stackTrace) {
      UiHelper.toastMessage(error.toString());
    });
  }
}
