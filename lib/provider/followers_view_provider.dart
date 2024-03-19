import 'package:flutter/material.dart';
import 'package:instagram/data/response/api_response.dart';
import 'package:instagram/model/followers_model.dart';
import 'package:instagram/repository/user_profile_repository.dart';

class FollowersViewModel with ChangeNotifier {
  final UserProfileRepository myRepo;

  FollowersViewModel() : myRepo = UserProfileRepository();
  ApiResponse<FollowersModel> followerList = ApiResponse.loading();
  setFollowersList(ApiResponse<FollowersModel> response) {
    followerList = response;
    notifyListeners();
  }

  Future<void> fetchFollowersList() async {
    setFollowersList(ApiResponse.loading());
    myRepo.getFollowersListApi().then((value) {
      setFollowersList(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setFollowersList(ApiResponse.error(error.toString()));
    });
  }
  // FOR OTHER USER

  ApiResponse<FollowersModel> otherUserFollowerList = ApiResponse.loading();
  setOtherUserFollowerList(ApiResponse<FollowersModel> response) {
    otherUserFollowerList = response;
    notifyListeners();
  }

// FOR OTHER USER
  Future<void> fetchOtherFollowersList(String userId) async {
    setOtherUserFollowerList(ApiResponse.loading());
    myRepo.getOtherUserFollowersListApi(userId).then((value) {
      setOtherUserFollowerList(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setOtherUserFollowerList(ApiResponse.error(error.toString()));
    });
  }
}
