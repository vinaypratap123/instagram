import 'package:flutter/material.dart';
import 'package:instagram/data/response/api_response.dart';
import 'package:instagram/model/following_model.dart';
import 'package:instagram/repository/user_profile_repository.dart';

class FollowingViewModel with ChangeNotifier {
  final myRepo = UserProfileRepository();
  ApiResponse<FollowingModel> followingList = ApiResponse.loading();

  setFollowingList(ApiResponse<FollowingModel> response) {
    followingList = response;
    notifyListeners();
  }

  Future<void> fetchFollowingList() async {
    setFollowingList(ApiResponse.loading());
    myRepo.getFollowingListApi().then((value) {
      setFollowingList(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setFollowingList(ApiResponse.error(error.toString()));
    });
  }

  ApiResponse<FollowingModel> otherUserFollowingList = ApiResponse.loading();
  setOtherUserFollowingList(ApiResponse<FollowingModel> response) {
    otherUserFollowingList = response;
    notifyListeners();
  }

  Future<void> fetchOtherUserFollowingList(String userId) async {
    setOtherUserFollowingList(ApiResponse.loading());
    myRepo.getOtherUserFollowingListApi(userId).then((value) {
      setOtherUserFollowingList(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setOtherUserFollowingList(ApiResponse.error(error.toString()));
    });
  }
}
