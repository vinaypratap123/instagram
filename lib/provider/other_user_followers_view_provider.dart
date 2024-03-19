import 'package:flutter/material.dart';
import 'package:instagram/data/response/api_response.dart';
import 'package:instagram/model/other_user_followers_model.dart';
import 'package:instagram/repository/other_user_profile.dart';

class OtherUserFollowersViewModel with ChangeNotifier {
  final OtherUserProfileRepository myRepo;

  OtherUserFollowersViewModel() : myRepo = OtherUserProfileRepository();
  ApiResponse<OtherUserFollowersModel> otherUserFollowerList =
      ApiResponse.loading();
  setFollowersList(ApiResponse<OtherUserFollowersModel> response) {
    otherUserFollowerList = response;
    notifyListeners();
  }

  Future<void> fetchOtherUserFollowersList() async {
    setFollowersList(ApiResponse.loading());
    myRepo.getOtherUserFollowersListApi().then((value) {
      setFollowersList(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setFollowersList(ApiResponse.error(error.toString()));
    });
  }
}
