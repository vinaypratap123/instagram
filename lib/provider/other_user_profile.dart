import 'package:flutter/material.dart';
import 'package:instagram/data/response/api_response.dart';
import 'package:instagram/model/other_user_model.dart';
import 'package:instagram/repository/other_user_profile.dart';

class OtherUserProfileViewModel with ChangeNotifier {
  final _myRepo = OtherUserProfileRepository();
  ApiResponse<OtherUserProfileModel> otherUserProfile = ApiResponse.loading();
  setOtherUserProfile(ApiResponse<OtherUserProfileModel> response) {
    otherUserProfile = response;
    notifyListeners();
  }

  Future<void> fetchOtherUserProfile(String userId) async {
    setOtherUserProfile(ApiResponse.loading());
    _myRepo.getOtherUserProfileApi(userId).then((value) {
      setOtherUserProfile(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setOtherUserProfile(ApiResponse.error(error.toString()));
    });
  }
}
