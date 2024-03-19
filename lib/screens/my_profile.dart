import 'package:flutter/material.dart';
import 'package:instagram/data/response/status.dart';
import 'package:instagram/provider/delete_post_view_provider.dart';
import 'package:instagram/provider/like_post_view_provider.dart';
import 'package:instagram/provider/post_view_provider.dart';
import 'package:instagram/provider/unlike_post_view_provider.dart';
import 'package:instagram/provider/user_profile_provider.dart';
import 'package:instagram/provider/user_view_provider.dart';
import 'package:instagram/screens/comment_screen.dart';
import 'package:instagram/screens/like_screen.dart';
import 'package:instagram/ui_helper/ui_helper.dart';
import 'package:instagram/utils/app_color.dart';
import 'package:instagram/utils/app_image.dart';
import 'package:instagram/utils/app_string.dart';
import 'package:instagram/utils/app_style.dart';
import 'package:instagram/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
// ************************************ INSTANCES *****************************
  UserProfileViewModel userProfileViewModel = UserProfileViewModel();
  LikePostViewModel likePostViewModel = LikePostViewModel();
  UnlikePostViewModel unlikePostViewModel = UnlikePostViewModel();
  
// ************************************ INIT STATE METHOD *****************************
  @override
  void initState() {
    super.initState();
    userProfileViewModel.fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
// ************************************ SCAFFOLD *****************************
    return Scaffold(
// ************************************ APP BAR *****************************
        appBar: AppBar(
          title: const Text(AppString.appName),
        ),
// ************************************ DRAWER *****************************
        endDrawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.65,
          backgroundColor: AppColor.mobileBackgroundColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 150,
// ************************************ DRAWER HEADER *****************************
                child: DrawerHeader(
                  decoration: BoxDecoration(color: AppColor.blueColor),
                  child: Center(
// ************************************ APP NAME TEXT *****************************

                    child: Text(
                      AppString.appName,
                      style: AppStyle.appNameStyle,
                    ),
                  ),
                ),
              ),

// ************************************ HOME ICON *****************************
              ListTile(
                leading: const Icon(
                  Icons.home,
                  color: AppColor.blueColor,
                ),
// ************************************ HOME TEXT *****************************
                title: const Text(
                  AppString.home,
                  style: AppStyle.regularTextStyle,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RoutesName.bottomNavbar,
                    (route) => false,
                  );
                },
              ),
              ListTile(
// ************************************ CONTACTS ICON *****************************
                leading: const Icon(
                  Icons.contacts,
                  color: AppColor.blueColor,
                ),
// ************************************ CONTACTS TEXT *****************************
                title: const Text(
                  AppString.contacts,
                  style: AppStyle.regularTextStyle,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, RoutesName.contacts);
                },
              ),

              ListTile(
// ************************************ LOGOUT ICON *****************************
                leading: const Icon(Icons.logout, color: AppColor.red),
// ************************************ LOGOUT TEXT *****************************
                title: const Text(
                  AppString.logOut,
                  style: AppStyle.smallRedTextStyle,
                ),
// ************************************ LOGOUT ON TAP METHOD *****************************
                onTap: () {
                  showLogoutConfirmationDialog(context);
                },
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return userProfileViewModel.fetchUserProfile();
          },
          child: ChangeNotifierProvider<UserProfileViewModel>(
            create: (BuildContext context) => userProfileViewModel,
            child: Consumer<UserProfileViewModel>(builder: (context, value, _) {
              switch (value.userProfile.status) {
                // ************************************ LOADING STATUS *****************************
                case Status.loading:
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.blue,
                  ));
                // ************************************ ERROR STATUS *****************************
                case Status.error:
                  return Text(value.userProfile.message.toString());
                // ************************************ COMPLETE STATUS *****************************
                case Status.complete:
                  final profile = value.userProfile.data?.data.profile;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ************************************ NAME TEXT *****************************
                                  Text(
                                    profile!.name ?? "",
                                    style: AppStyle.userNameStyle,
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  // ************************************ ABOUT TEXT *****************************
                                  Text(
                                    profile.about ?? "",
                                    style: AppStyle.regularTextStyle,
                                  ),
                                ],
                              ),
                            ),
                            // ************************************ PROFILE PICTURE ON TAP METHOD *****************************
                            InkWell(
                              onTap: () {},
                              child: CircleAvatar(
                                radius: 45,
                                // backgroundImage:
                                //     AssetImage(AppImage.profilePic),
                                backgroundImage:
                                    NetworkImage(profile.displayPicture),
                                // child: const Icon(
                                //   Icons.person,
                                //   size: 80,
                                // ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // ************************************ POST COUNT TEXT *****************************
                                Text(
                                  profile.posts.length.toString(),
                                  style: AppStyle.regularTextStyle,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                // ************************************ POST TEXT *****************************
                                const Text(
                                  AppString.posts,
                                  style: AppStyle.regularTextStyle,
                                ),
                              ],
                            )),
                            // ************************************ FOLLOWERS SCREEN ON TAP METHOD *****************************
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RoutesName.follower);
                              },
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // ************************************ FOLLOWERS COUNT TEXT ****************************
                                  Text(
                                    profile.followersCount.toString(),
                                    style: AppStyle.regularTextStyle,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  // ************************************ FOLLOWERS TEXT ****************************
                                  const Text(
                                    AppString.follower,
                                    style: AppStyle.regularTextStyle,
                                  ),
                                ],
                              )),
                            ),
                            // ************************************ FOLLOWING SCREEN ON TAP METHOD *****************************
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RoutesName.following);
                              },
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // ************************************ FOLLOWING COUNT TEXT *****************************
                                  Text(
                                    profile.followingCount.toString(),
                                    style: AppStyle.regularTextStyle,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  // ************************************ FOLLOWING TEXT *****************************
                                  const Text(
                                    AppString.following,
                                    style: AppStyle.regularTextStyle,
                                  ),
                                ],
                              )),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  height: 30,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: AppColor.blueColor),
                                  child: Center(
                                      // ************************************ EDIT PROFILE ON TAP METHOD *****************************
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, RoutesName.editProfile,
                                                arguments: {
                                                  "name": profile.name,
                                                  "userName": profile.userName,
                                                  "about": profile.about,
                                                  "profilePic":
                                                      profile.displayPicture
                                                });
                                          },
                                          // ************************************ EDIT PROFILE TEXT *****************************
                                          child: const Text(
                                            AppString.editProfile,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  height: 30,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: AppColor.blueColor),
                                  child: const Center(
                                      // ************************************ MESSAGE TEXT *****************************
                                      child: Text(AppString.message,
                                          style:
                                              TextStyle(color: Colors.white))),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  height: 30,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: AppColor.blueColor),
                                  // ************************************ SHARE TEXT *****************************
                                  child: const Icon(
                                    Icons.share,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Expanded(
                            // ************************************ LIST VIEW BUILDER *****************************
                            child: profile.totalPosts.length.toString() == "0"
                                ? const Center(
                                    child: Text("Your Post will shown Here"),
                                  )
                                : ListView.builder(
                                    itemCount: profile.posts.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        color: AppColor.mobileBackgroundColor,
                                        child: Column(
                                          children: [
                                            // ******************************************* USER LIST TILE ***********************************************
                                            ListTile(
                                              leading: CircleAvatar(
                                                child: profile.displayPicture ==
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
                                                          profile.displayPicture
                                                              .toString(),
                                                          width: 57,
                                                          height: 57,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),

                                                // ******************************************* PERSON ICON ***********************************************
                                                // child: Icon(
                                                //   Icons.person,
                                                //   size: 35,
                                                // ),
                                              ),
                                              // ******************************************* NAME TEXT ***********************************************
                                              title: Text(
                                                profile.name,
                                                style:
                                                    AppStyle.regularTextStyle,
                                              ),
                                              // ******************************************* USER NAME TEXT ***********************************************
                                              subtitle: Text(
                                                profile.userName,
                                                style:
                                                    AppStyle.regularTextStyle,
                                              ),
                                              // ******************************************* MORE VERT ON TAP METHOD ***********************************************
                                              trailing: InkWell(
                                                onTap: () {
                                                  showBottomSheet(
                                                      profile
                                                          .posts[index].caption,
                                                      profile.posts[index].id
                                                          .toString(),
                                                      context);
                                                },

                                                // ******************************************* MORE VERT ICON ***********************************************
                                                child: const Icon(
                                                  Icons.more_vert,
                                                  color: AppColor
                                                      .primaryBlackColor,
                                                ),
                                              ),
                                            ),
                                            // ************************************ POST CAPTION TEXT ***************************************
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      profile
                                                          .posts[index].caption,
                                                      style: AppStyle
                                                          .regularTextStyle,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // ******************************************* USER POST IMAGE ***********************************************
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.35,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              color: AppColor.blackColor,
                                              child: Image.network(
                                                profile.posts[index].content,
                                                fit: BoxFit.cover,
                                              ),
                                              // child: Image.asset(
                                              //   AppImage.posts,
                                              // fit: BoxFit.cover,
                                              // ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            // ******************************************* ICONS ROW ***********************************************
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10, left: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      // ******************************************* LIKE ICON ***********************************************

                                                      InkWell(
                                                        onTap: () async {
                                                          // SharedPreferences
                                                          //     sharedPreferences =
                                                          //     await SharedPreferences
                                                          //         .getInstance();
                                                          // String? senderId =
                                                          //     sharedPreferences
                                                          //         .getString(
                                                          //             "userId");
                                                          Map data = {
                                                            // "senderId": senderId,
                                                            // "recieverId": profile
                                                            //     .posts[index]
                                                            //     .userId,
                                                            // "notificationIcon":
                                                            //     profile
                                                            //         .displayPicture,
                                                            // "title":
                                                            //     profile.userName,
                                                            // "type": "like",
                                                            // "actionId": profile
                                                            //     .posts[index].id
                                                          };
                                                          profile.posts[index]
                                                                      .liked
                                                                      .toString() ==
                                                                  "0"
                                                              ? likePostViewModel
                                                                  .likePostApi(
                                                                      profile
                                                                          .posts[
                                                                              index]
                                                                          .id
                                                                          .toString(),
                                                                      data,
                                                                      context)
                                                              : unlikePostViewModel
                                                                  .deletePostApi(
                                                                      profile
                                                                          .posts[
                                                                              index]
                                                                          .id
                                                                          .toString(),
                                                                      context);
                                                        },
                                                        child: Icon(
                                                          profile.posts[index]
                                                                      .liked
                                                                      .toString() ==
                                                                  "0"
                                                              ? Icons
                                                                  .favorite_outline
                                                              : Icons.favorite,
                                                          color: AppColor
                                                              .blueColor,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 15,
                                                      ),
                                                      // ******************************************* COMMENT ICON ***********************************************
                                                      InkWell(
                                                        onTap: () {
                                                          Map map = {
                                                            "postId": profile
                                                                .posts[index].id
                                                                .toString(),
                                                            "caption": profile
                                                                .posts[index]
                                                                .caption,
                                                            "img": profile
                                                                .posts[index]
                                                                .content,
                                                            "Name":
                                                                profile.name,
                                                            "userName": profile
                                                                .userName,
                                                            "pic": profile
                                                                .displayPicture,
                                                          };
                                                          Navigator.pushNamed(
                                                              context,
                                                              RoutesName
                                                                  .commentOnPost,
                                                              arguments: map);
                                                        },
                                                        child: const Icon(
                                                          Icons
                                                              .chat_bubble_outline,
                                                          color: AppColor
                                                              .blueColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  // ******************************************* SAVE ICON ***********************************************
                                                  const Icon(
                                                    Icons.bookmark_outline,
                                                    color: AppColor.blueColor,
                                                  )
                                                ],
                                              ),
                                            ),

                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              // ******************************************* LIKE SCREEN ON TAP METHOD ***********************************************
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LikeScreen(
                                                                postId: profile
                                                                    .posts[
                                                                        index]
                                                                    .id,
                                                                userId: profile
                                                                    .userId,
                                                              )));
                                                },
                                                child: Row(
                                                  children: [
                                                    // ******************************************* NUMBER OF LIKE TEXT ***********************************************
                                                    Text(
                                                      profile.posts[index]
                                                          .numberOfLikes
                                                          .toString(),
                                                      style: AppStyle
                                                          .regularTextStyle,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    // *******************************************  LIKE TEXT ***********************************************
                                                    const Text(
                                                      AppString.likes,
                                                      style: AppStyle
                                                          .smallTextStyle,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              // ******************************************* COMMENT SCREEN ON TAP METHOD ***********************************************
                                              child: InkWell(
                                                onTap: () async {
                                                  SharedPreferences sp =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  String? uid =
                                                      sp.getString("userId");
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CommentScreen(
                                                                postId: profile
                                                                    .posts[
                                                                        index]
                                                                    .id,
                                                                userId: profile
                                                                    .posts[
                                                                        index]
                                                                    .id,
                                                                caption: profile
                                                                    .posts[
                                                                        index]
                                                                    .content,
                                                                img: profile
                                                                    .posts[
                                                                        index]
                                                                    .content,
                                                                uId: uid,
                                                              )));
                                                },
                                                child: Row(
                                                  children: [
                                                    // ******************************************* NUMBER OF COMMENT TEXT ***********************************************
                                                    Text(
                                                      profile.posts[index]
                                                          .numberOfComments
                                                          .toString(),
                                                      style: AppStyle
                                                          .regularTextStyle,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    // ******************************************* COMMENT TEXT ***********************************************
                                                    const Text(
                                                      AppString.comment,
                                                      style: AppStyle
                                                          .smallTextStyle,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            const Divider(
                                              thickness: 2,
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ))
                      ],
                    ),
                  );
                default:
                  return Container();
              }
            }),
          ),
        ));
  }

// ************************************ SHOW LOGOUT CONFIRMATION DIALOG METHOD *****************************
  void showLogoutConfirmationDialog(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context, listen: false);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text(AppString.confirmLogout),
              content: const Text(AppString.sureLogout),
              actions: <Widget>[
                TextButton(
                  child: const Text(AppString.cancel),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                    child: const Text(
                      AppString.logOut,
                      style: AppStyle.smallRedTextStyle,
                    ),
// ************************************ SHOW LOGOUT CONFIRMATION DIALOG ON PRESSED METHOD *****************************
                    onPressed: () async {
                      UiHelper.showProgressBar(context);
                      userPreference.remove().then((value) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RoutesName.login,
                          (route) => false,
                        );
                      });
                    }),
              ]);
        });
  }

// ************************************ SHOW DELETE POST CONFIRMATION DIALOG METHOD *****************************
  void showDeletePostConfirmationDialog(String postId, BuildContext context) {
    final deletePostViewModel =
        Provider.of<DeletePostViewModel>(context, listen: false);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text(AppString.confirmDelete),
              content: const Text(AppString.sureDelete),
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
// ************************************ SHOW DELETE POST CONFIRMATION DIALOG ON PRESSED METHOD *****************************
                    onPressed: () async {
                      Navigator.pop(context);
                      await deletePostViewModel.deletePostApi(postId, context);
                      userProfileViewModel.fetchUserProfile();
                      UiHelper.flushBarMessage(
                          context, "Post Deleted Successfully");
                    }),
              ]);
        });
  }

// ************************************ SHOW BOTTOM SHEET METHOD *****************************
  void showBottomSheet(String caption, String postId, BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Column(
            children: <Widget>[
              SizedBox(
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
                  AppString.delete,
                  style: AppStyle.smallRedTextStyle,
                ),
// ************************************ SHOW BOTTOM SHEET ON TAP METHOD *****************************
                onTap: () {
                  Navigator.pop(context);
                  showDeletePostConfirmationDialog(postId, context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
                title: const Text(
                  AppString.editPost,
                ),
// ************************************ SHOW BOTTOM SHEET ON TAP METHOD *****************************
                onTap: () {
                  Navigator.pop(context);
                  _showPostUpdateDialog(postId, caption);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ================================ _showMessageUpdateDialog() function ===================================
  void _showPostUpdateDialog(
    String postId,
    String caption,
  ) {
    final postViewModel = Provider.of<PostViewModel>(context, listen: false);
    String updateMessage = caption;
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
                  Text(AppString.updatePost)
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
                      await postViewModel.editPostApi(
                          postId, updateMessage, context);
                      userProfileViewModel.fetchUserProfile();
                    },
                    child: const Text(AppString.updatePost,
                        style: TextStyle(color: Colors.blue)))
              ],
            ));
  }
}
