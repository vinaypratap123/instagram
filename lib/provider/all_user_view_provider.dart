import 'package:flutter/material.dart';
import 'package:instagram/data/response/api_response.dart';
import 'package:instagram/model/all_user_model.dart';
import 'package:instagram/repository/user_profile_repository.dart';

class AllUserViewModel with ChangeNotifier {
  final myRepo = UserProfileRepository();
  ApiResponse<AllUserModel> allUserList = ApiResponse.loading();
  setAllUserList(ApiResponse<AllUserModel> response) {
    allUserList = response;
    notifyListeners();
  }

  Future<void> fetchAllUserList() async {
    setAllUserList(ApiResponse.loading());
    myRepo.getAllUserApi().then((value) {
      setAllUserList(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setAllUserList(ApiResponse.error(error.toString()));
    });
  }
}
