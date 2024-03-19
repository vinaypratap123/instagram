import 'package:flutter/material.dart';
import 'package:instagram/data/response/status.dart';
import 'package:instagram/provider/following_view_provider.dart';
import 'package:instagram/provider/unfollow_user_view_provider.dart';
import 'package:instagram/provider/user_profile_provider.dart';
import 'package:instagram/screens/user_profile_screen.dart';
import 'package:instagram/utils/app_image.dart';
import 'package:instagram/utils/app_string.dart';
import 'package:instagram/utils/app_style.dart';
import 'package:instagram/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({super.key});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
// ************************************* FOLLOWING VIEW MODEL INSTANCE *************************************
  FollowingViewModel followingViewModel = FollowingViewModel();
  UserProfileViewModel userProfileViewModel = UserProfileViewModel();
  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    followingViewModel.fetchFollowingList();
  }

// ************************************* INIT METHOD *************************************
  @override
  void initState() {
    super.initState();
    followingViewModel.fetchFollowingList();
  }

  @override
  Widget build(BuildContext context) {
// ************************************* UN FOLLOW USER VIEW MODEL INSTANCE *************************************
    final unFollowUserViewModel = Provider.of<UnFollowUserViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppString.following),
        ),
        body: RefreshIndicator(
          onRefresh: onRefresh,
          child: ChangeNotifierProvider<FollowingViewModel>(
              create: (BuildContext context) => followingViewModel,
              child: Consumer<FollowingViewModel>(builder: (context, value, _) {
                switch (value.followingList.status) {
                  // ************************************* LOADING STATUS *************************************
                  case Status.loading:
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.blue,
                    ));
                  // ************************************* ERROR STATUS *************************************
                  case Status.error:
                    return Text(value.followingList.message.toString());
                  // ************************************* COMPLETE  STATUS *************************************
                  case Status.complete:
                    final followers = value.followingList.data;
                    return SizedBox(
                      child: followers!.data.isEmpty
                          ? const Center(
                              child: Text(AppString.noFollowing),
                            )
                          // ************************************* LIST VIEW BUILDER *************************************
                          : ListView.builder(
                              itemCount: followers.data.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    onTap: () {
                                      // ************************************* USER PROFILE SCREEN ON TAP METHOD *************************************
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UserProfileScreen(
                                                      userId: followers
                                                          .data[index].userId
                                                          .toString())));
                                      // ************************************* USER PROFILE PICTURE  *************************************
                                    },
                                    leading: CircleAvatar(
                                      child: followers
                                                  .data[index].displayPicture ==
                                              "string"
                                          ? ClipOval(
                                              child: Image.asset(
                                                AppImage.profilePic,
                                                width: 57,
                                                height: 57,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : ClipOval(
                                              child: Image.network(
                                                followers
                                                    .data[index].displayPicture
                                                    .toString(),
                                                width: 57,
                                                height: 57,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                    ),
                                    // ************************************* NAME TEXT *************************************
                                    title:
                                        Text(followers.data[index].name ?? ""),
                                    subtitle:
                                        // ************************************* USER NAME TEXT *************************************
                                        Text(followers.data[index].userName ??
                                            ""),
                                    trailing: SizedBox(
                                        height: 35,
                                        width: 90,
                                        // ************************************* REMOVE BUTTON *************************************
                                        child: RoundedButton(
                                            btnName: AppString.remove,
                                            btnCallBack: () async {
                                              showUnfollowConfirmationDialog(
                                                  followers.data[index].userId
                                                      .toString(),
                                                  context);
                                            })));
                              }),
                    );
                  default:
                    return Container();
                }
              })),
        ));
  }

  // ************************************ SHOW LOGOUT CONFIRMATION DIALOG METHOD *****************************
  void showUnfollowConfirmationDialog(String userId, BuildContext context) {
    // final deleteCommentViewModel =
    //     Provider.of<DeleteCommentViewModel>(context, listen: false);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Confirm unfollow"),
              content: const Text("are you sure you want to unfolllow? "),
              actions: <Widget>[
                TextButton(
                  child: const Text(AppString.cancel),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                    child: const Text(
                      "Remove",
                      style: AppStyle.smallRedTextStyle,
                    ),
// ************************************ SHOW LOGOUT CONFIRMATION DIALOG ON PRESSED METHOD *****************************
                    onPressed: () async {
                      UnFollowUserViewModel unFollowUserViewModel =
                          UnFollowUserViewModel();
                      Navigator.pop(context);
                      await unFollowUserViewModel.unFollowApi(userId, context);

                      await followingViewModel.fetchFollowingList();
                      //     UiHelper.showProgressBar(context);
                      //   await  deleteCommentViewModel.deleteCommentApi(
                      //         commentId, context);
                      //  await        commentListViewModel.fetchCommentList(widget.postId);
                      Navigator.pop(context);
                      // navigator.pushAndRemoveUntil()
                      //  Navigator.pushAndRemoveUntil(context, ,RoutesName.bottomNavbar,);
                      // userPreference.remove().then((value) {
                      //   Navigator.pushReplacementNamed(
                      //       context, RoutesName.login);
                      // });
                    }),
              ]);
        });
  }
}
