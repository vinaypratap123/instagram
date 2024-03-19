import 'package:flutter/material.dart';
import 'package:instagram/data/response/api_response.dart';
import 'package:instagram/model/following_model.dart';
import 'package:instagram/repository/user_profile_repository.dart';

class OtherUserFollowingViewModel with ChangeNotifier {
  final UserProfileRepository myRepo;

  // FOR OTHER USER

  OtherUserFollowingViewModel() : myRepo = UserProfileRepository();
  ApiResponse<FollowingModel> otherUserFollowingList = ApiResponse.loading();
  setOtherUserFollowingList(ApiResponse<FollowingModel> response) {
    otherUserFollowingList = response;
    notifyListeners();
  }

// FOR OTHER USER
  Future<void> fetchOtherFollowingList(String userId) async {
    setOtherUserFollowingList(ApiResponse.loading());
    myRepo.getOtherUserFollowingListApi(userId).then((value) {
      setOtherUserFollowingList(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setOtherUserFollowingList(ApiResponse.error(error.toString()));
    });
  }
}
