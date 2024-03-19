import 'package:flutter/material.dart';
import 'package:instagram/data/response/status.dart';
import 'package:instagram/provider/comment_view_provider.dart';
import 'package:instagram/provider/delete_comment_view_provider.dart';
import 'package:instagram/provider/post_view_provider.dart';
import 'package:instagram/screens/user_profile_screen.dart';
import 'package:instagram/ui_helper/ui_helper.dart';
import 'package:instagram/utils/app_string.dart';
import 'package:instagram/utils/app_style.dart';
import 'package:instagram/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentScreen extends StatefulWidget {
// ********************************* VARIABLES ********************************
  final String postId;
  final String userId;
  final String caption;
  final String img;
  final String? uId;

  const CommentScreen(
      {super.key,
      required this.postId,
      required this.userId,
      required this.caption,
      required this.img,
      required this.uId});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
// ********************************* LIKE LIST VIEW MODEL INSTANCE ********************************
  CommentListViewModel commentListViewModel = CommentListViewModel();
  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    commentListViewModel.fetchCommentList(widget.postId);
  }

// ********************************* INIT STATE METHOD ********************************
  @override
  void initState() {
    super.initState();
    commentListViewModel.fetchCommentList(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
// ********************************* SCAFFOLD ********************************
    return Scaffold(
// ********************************* APP BAR ********************************
      appBar: AppBar(
        title: const Text(
          AppString.comment,
          style: AppStyle.headerTextStyle,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: ChangeNotifierProvider<CommentListViewModel>(
            create: (BuildContext context) => commentListViewModel,
            child: Consumer<CommentListViewModel>(builder: (context, value, _) {
              switch (value.commentList.status) {
                // ********************************* LOADING STATUS ********************************
                case Status.loading:
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.blue,
                  ));
                // ********************************* ERROR STATUS ********************************
                case Status.error:
                  return Text(value.commentList.message.toString());
                // ********************************* COMPLETE STATUS ********************************
                case Status.complete:
                  final followers = value.commentList.data;
                  // SharedPreferences sharedPreferences  =  SharedPreferences.getInstance();

                  return SizedBox(
                    child: followers!.data.isEmpty
                        ? const Center(
                            child: Text(AppString.noComment),
                          )
                        : ListView.builder(
                            itemCount: followers.data.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                  child: ListTile(
                                      // ********************************* USER PROFILE PICTURE  ********************************
                                      onTap: () async {
                                        SharedPreferences sp =
                                            await SharedPreferences
                                                .getInstance();
                                        String? uId = sp.getString("userId");
                                        uId == followers.data[index].userId
                                            ? Navigator.pushNamed(
                                                context, RoutesName.myProfile)
                                            : Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserProfileScreen(
                                                            userId: followers
                                                                .data[index]
                                                                .userId)));
                                      },
                                      leading: const CircleAvatar(
                                        // ********************************* PERSON ICON  ********************************
                                        child: Icon(
                                          Icons.person,
                                          size: 30,
                                        ),
                                      ),
                                      // ********************************* NAME TEXT  ********************************
                                      title:
                                          Text(followers.data[index].user.name),
                                      // ********************************* COMMENT TEXT  ********************************
                                      subtitle:
                                          Text(followers.data[index].comment),
                                      trailing: widget.uId.toString() ==
                                              followers.data[index].userId
                                          ? InkWell(
                                              onTap: () async {
                                                showBottomSheet(
                                                    followers
                                                        .data[index].commentId
                                                        .toString(),
                                                    followers
                                                        .data[index].comment,
                                                    context);
                                              },
                                              child:
                                                  const Icon(Icons.more_vert))
                                          : SizedBox()));
                            }),
                  );
                default:
                  return Container();
              }
            })),
      ),
    );
  }

  // ************************************ SHOW BOTTOM SHEET METHOD *****************************
  void showBottomSheet(String commentId, String comment, BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 5,
                    width: 80,
                    color: Colors.blue,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                title: const Text(
                  AppString.deleteComment,
                  style: AppStyle.smallRedTextStyle,
                ),
// ************************************ SHOW BOTTOM SHEET ON TAP METHOD *****************************
                onTap: () {
                  Navigator.pop(context);
                  showDeleteConfirmationDialog(commentId, context);
                  // showDeletePostConfirmationDialog(postId, context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
                title: const Text(
                  AppString.editComment,
                ),
// ************************************ SHOW BOTTOM SHEET ON TAP METHOD *****************************
                onTap: () {
                  Navigator.pop(context);
                  _showCommentEditDialog(commentId, comment);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ================================ _showMessageUpdateDialog() function ===================================
  void _showCommentEditDialog(
    String postId,
    String comment,
  ) {
    final postViewModel = Provider.of<PostViewModel>(context, listen: false);
    String updateMessage = comment;

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: const Row(
                children: [
                  Icon(
                    Icons.message,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(AppString.editComment)
                ],
              ),
              content: TextFormField(
                maxLines: null,
                onChanged: (newMessage) => updateMessage = newMessage,
                initialValue: updateMessage,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              actions: [
                MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      AppString.cancel,
                      style: TextStyle(color: Colors.blue),
                    )),
                MaterialButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await postViewModel.editCommentApi(
                          postId, updateMessage, context);
                      await commentListViewModel
                          .fetchCommentList(widget.postId);
                    },
                    child: const Text(AppString.editComment,
                        style: TextStyle(color: Colors.blue)))
              ],
            ));
  }

  // ************************************ SHOW LOGOUT CONFIRMATION DIALOG METHOD *****************************
  void showDeleteConfirmationDialog(String commentId, BuildContext context) {
    final deleteCommentViewModel =
        Provider.of<DeleteCommentViewModel>(context, listen: false);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text(AppString.confirmDelete),
              content: const Text(AppString.sureDeleteComment),
              actions: <Widget>[
                TextButton(
                  child: const Text(AppString.cancel),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                    child: const Text(
                      AppString.delete,
                      style: AppStyle.smallRedTextStyle,
                    ),
// ************************************ SHOW LOGOUT CONFIRMATION DIALOG ON PRESSED METHOD *****************************
                    onPressed: () async {
                      Navigator.pop(context);
                      UiHelper.showProgressBar(context);
                      await deleteCommentViewModel.deleteCommentApi(
                          commentId, context);
                      await commentListViewModel
                          .fetchCommentList(widget.postId);
                      Navigator.pop(context);
                     
                    }),
              ]);
        });
  }
}
