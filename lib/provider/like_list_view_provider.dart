import 'package:flutter/material.dart';
import 'package:instagram/data/response/api_response.dart';
import 'package:instagram/model/like_model.dart';
import 'package:instagram/repository/post_view_repository.dart';

class LikeListViewModel with ChangeNotifier {
  final PostRepository myRepo;

  LikeListViewModel() : myRepo = PostRepository();
  ApiResponse<LikeModel> likeList = ApiResponse.loading();
  setLikeList(ApiResponse<LikeModel> response) {
    likeList = response;
    notifyListeners();
  }

  Future<void> fetchLikeList(String postId) async {
    setLikeList(ApiResponse.loading());
    myRepo.getLikeListApi(postId).then((value) {
      setLikeList(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setLikeList(ApiResponse.error(error.toString()));
    });
  }
}
