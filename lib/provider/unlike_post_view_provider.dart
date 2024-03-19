import 'package:flutter/material.dart';
import 'package:instagram/repository/post_view_repository.dart';
import 'package:instagram/ui_helper/ui_helper.dart';

class UnlikePostViewModel with ChangeNotifier {
  final _myRepo = PostRepository();

// ************************* DELETE POST API ************************
  Future<void> deletePostApi(String postId, BuildContext context) async {
    _myRepo.unlikePostApi(postId).then((value) {}).onError((error, stackTrace) {
      UiHelper.toastMessage(error.toString());
    });
  }
}
