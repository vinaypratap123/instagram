import 'package:flutter/material.dart';
import 'package:instagram/data/response/api_response.dart';
import 'package:instagram/model/comment_model.dart';
import 'package:instagram/repository/post_view_repository.dart';

class CommentListViewModel with ChangeNotifier {
  final PostRepository myRepo;

  CommentListViewModel() : myRepo = PostRepository();
  ApiResponse<CommentModel> commentList = ApiResponse.loading();
  setCommentList(ApiResponse<CommentModel> response) {
    commentList = response;
    notifyListeners();
  }

  Future<void> fetchCommentList(String postId) async {
    setCommentList(ApiResponse.loading());
    myRepo.getCommentListApi(postId).then((value) {
      setCommentList(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setCommentList(ApiResponse.error(error.toString()));
    });
  }
}
