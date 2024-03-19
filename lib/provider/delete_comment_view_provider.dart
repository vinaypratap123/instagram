import 'package:flutter/material.dart';
import 'package:instagram/repository/post_view_repository.dart';
import 'package:instagram/ui_helper/ui_helper.dart';

class DeleteCommentViewModel with ChangeNotifier {
  // bool _deleteLoading = false;
  // bool get deleteLoading => _deleteLoading;

  // void loading(bool value) {
  //   _deleteLoading = value;
  //   notifyListeners();
  // }

  final _myRepo = PostRepository();

// ************************* DELETE POST API ************************
  Future<void> deleteCommentApi(String commentId, BuildContext context) async {
    // loading(true);

    _myRepo.deleteCommentApi(commentId).then((value) {
      UiHelper.flushBarMessage(context, "Comment Deleted Successfully");
      // loading(false);
    }).onError((error, stackTrace) {
      // loading(false);
      UiHelper.toastMessage(error.toString());
    });
  }
}
