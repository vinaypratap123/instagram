import 'package:flutter/material.dart';
import 'package:instagram/data/response/status.dart';
import 'package:instagram/provider/follow_user_view_provider.dart';
import 'package:instagram/provider/like_post_view_provider.dart';
import 'package:instagram/provider/notification_provider.dart';
import 'package:instagram/provider/other_user_profile.dart';
import 'package:instagram/provider/unlike_post_view_provider.dart';
import 'package:instagram/provider/user_view_provider.dart';
import 'package:instagram/screens/other_user_followers_screen.dart';
import 'package:instagram/screens/other_user_following_screen.dart';
import 'package:instagram/ui_helper/ui_helper.dart';
import 'package:instagram/utils/app_color.dart';
import 'package:instagram/utils/app_string.dart';
import 'package:instagram/utils/app_style.dart';
import 'package:instagram/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileScreen extends StatefulWidget {
// ************************** VARIABLE ************************************
  final String userId;

  const UserProfileScreen({super.key, required this.userId});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
// **************************  MODEL INSTANCE ************************************
  OtherUserProfileViewModel otherUserProfileViewModel =
      OtherUserProfileViewModel();
  LikePostViewModel likePostViewModel = LikePostViewModel();
  UnlikePostViewModel unlikePostViewModel = UnlikePostViewModel();

// ************************** INIT METHOD ************************************
  @override
  void initState() {
    super.initState();

    otherUserProfileViewModel.fetchOtherUserProfile(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
// ************************** FOLLOW USER VIEW MODEL INSTANCE ************************************
    final followUserViewModel = Provider.of<FollowUserViewModel>(context);

// ************************** SCAFFOLD ************************************
    return Scaffold(
// ************************** APP BAR ************************************
        appBar: AppBar(
          title: const Text(AppString.appName),
        ),
// ************************** DRAWER ************************************
        endDrawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.65,
          backgroundColor: AppColor.mobileBackgroundColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const SizedBox(
                height: 150,
// ************************** DRAWER HEADER ************************************
                child: DrawerHeader(
                  decoration: BoxDecoration(color: AppColor.blueColor),
                  child: Center(
// ************************** APP NAME ************************************
                    child: Text(AppString.appName,
                        style: AppStyle.headerTextStyle),
                  ),
                ),
              ),
              ListTile(
// ************************** HOME ICON ************************************
                leading: const Icon(
                  Icons.home,
                  color: AppColor.blueColor,
                ),
// ************************** HOME TEXT  ************************************
                title: const Text(
                  AppString.home,
                  style: AppStyle.regularTextStyle,
                ),
// ************************** HOME ON TAP METHOD  ************************************
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, RoutesName.bottomNavbar);
                },
              ),
      
              ListTile(
// ************************** LOG OUT ICON ************************************
                leading: const Icon(Icons.logout, color: AppColor.red),
// ************************** LOG OUT TEXT ************************************
                title: const Text(
                  AppString.logOut,
                  style: AppStyle.smallRedTextStyle,
                ),
// ************************** LOG OUT ON TAP METHOD ************************************
                onTap: () {
                  showLogoutConfirmationDialog(context);
                },
              ),
            ],
          ),
        ),
// ************************** BODY ************************************
        body: ChangeNotifierProvider<OtherUserProfileViewModel>(
          create: (BuildContext context) => otherUserProfileViewModel,
          child:
              Consumer<OtherUserProfileViewModel>(builder: (context, value, _) {
            switch (value.otherUserProfile.status) {
// ************************** LOADING STATUS  ************************************
              case Status.loading:
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.blue,
                ));
// ************************** ERROR STATUS  ************************************
              case Status.error:
                return Text(value.otherUserProfile.message.toString());
// ************************** COMPLETE STATUS  ************************************
              case Status.complete:
                final profile = value.otherUserProfile.data?.data.profile;
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
// ************************** NAME TEXT ************************************
                                Text(
                                  profile!.name,
                                  style: AppStyle.userNameStyle,
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
// ************************** ABOUT TEXT ************************************
                                Text(
                                  profile.about,
                                  style: AppStyle.regularTextStyle,
                                ),
                              ],
                            ),
                          ),
// ************************** IMAGE ON TAP METHOD ************************************
                          InkWell(
                            onTap: () {},
                            child: CircleAvatar(
                              radius: 45,
                              backgroundImage:
                                  NetworkImage(profile.displayPicture),
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
// ************************** POST COUNT TEXT ************************************
                              Text(
                                profile.posts.length.toString(),
                                style: AppStyle.regularTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
// ************************** POST TEXT ************************************
                              const Text(
                                AppString.posts,
                                style: AppStyle.regularTextStyle,
                              ),
                            ],
                          )),
// ************************** OTHER USER FOLLOWERS SCREEN ON TAP METHOD ************************************
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          OtherUserFollowersScreen(
                                              userId:
                                                  profile.userId.toString())));
                            },
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
// ************************** FOLLOWERS COUNT TEXT ************************************
                                Text(
                                  profile.followersCount.toString(),
                                  style: AppStyle.regularTextStyle,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
// ************************** FOLLOWERS TEXT ************************************
                                const Text(
                                  AppString.follower,
                                  style: AppStyle.regularTextStyle,
                                ),
                              ],
                            )),
                          ),
// ************************** OTHER USER FOLLOWING SCREEN ON TAP METHOD ************************************
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          OtherUserFollowingScreen(
                                              userId:
                                                  profile.userId.toString())));
                            },
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
// ************************** FOLLOWING COUNT TEXT ************************************
                                Text(
                                  profile.followingCount.toString(),
                                  style: AppStyle.regularTextStyle,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
// ************************** FOLLOWING TEXT ************************************
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
                              child: profile.isFollowing.toString() == "0"
                                  ? Container(
                                      height: 30,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          color: AppColor.blueColor),
                                      child: Center(
// ************************** FOLLOW ON TAP METHOD ************************************
                                          child: InkWell(
                                              onTap: () async {
                                                await followUserViewModel
                                                    .followApi(
                                                        widget.userId, context);
                                                SharedPreferences
                                                    sharedPreferences =
                                                    await SharedPreferences
                                                        .getInstance();
                                                String? senderId =
                                                    sharedPreferences
                                                        .getString("userId");
                                                String? userName =
                                                    sharedPreferences
                                                        .getString("userName");

                                                Map data = {
                                                  "senderId": senderId,
                                                  "recieverId": profile.userId,
                                                  "notificationIcon":
                                                      "profilePic",
                                                  "title": userName,
                                                  "type": "startedFollowing",
                                                  "actionId": profile.userId
                                                };

                                                NotificationViewModel
                                                    notificationViewModel =
                                                    NotificationViewModel();

                                                notificationViewModel
                                                    .notificationsApi(
                                                        data, context);
                                                await otherUserProfileViewModel
                                                    .fetchOtherUserProfile(
                                                        widget.userId);
                                                await otherUserProfileViewModel
                                                    .fetchOtherUserProfile(
                                                        widget.userId);
                                              },
// ************************** FOLLOW TEXT ************************************
                                              child: const Text(
                                                AppString.follow,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ))),
                                    )
                                  : Container(
                                      height: 30,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          color: AppColor.blueColor),
                                      child: Center(
// ************************** FOLLOWING TEXT ************************************
                                          child: InkWell(
                                              onTap: ()async {
                                                 await otherUserProfileViewModel
                                                    .fetchOtherUserProfile(
                                                        widget.userId);
                                                await otherUserProfileViewModel
                                                    .fetchOtherUserProfile(
                                                        widget.userId);
                                              },
                                              child: const Text(
                                                  AppString.following,
                                                  style: TextStyle(
                                                      color: Colors.white)))),
                                    )),
                          const SizedBox(
                            width: 10,
                          ),
// ************************** MESSAGE TEXT ************************************
                          Expanded(
                              flex: 2,
                              child: Container(
                                height: 30,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: AppColor.blueColor),
                                child: const Center(
                                    child: Text(AppString.message,
                                        style: TextStyle(color: Colors.white))),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
// ************************** SHARE TEXT ************************************
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 30,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: AppColor.blueColor),
                                child: const Icon(
                                  Icons.share,
                                  color: Colors.white,
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),

// ****************************************************************
                      Expanded(
                        child: profile.posts.length.toString() == "0"
                            ? const Center(
                                child: Text("No Post"),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 0,
                                ),
                                itemCount: profile.posts.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    elevation: 5,
                                    child: Container(
                                      color: AppColor.blackColor,
                                      child: Image.network(
                                        profile.posts[index].content,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                      )
                    ],
                  ),
                );
              default:
                return Container(
                  color: Colors.red,
                  height: 100,
                );
            }
          }),
        ));
  }

// ************************** SHOW LOGOUT CONFIRMATION DIALOG METHOD ************************************
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
// ************************** SHOW LOGOUT CONFIRMATION DIALOG ON PRESSED METHOD ************************************
                    onPressed: () async {
                      UiHelper.showProgressBar(context);
                      userPreference.remove().then((value) {
                        Navigator.pushReplacementNamed(
                            context, RoutesName.login);
                      });
                    }),
              ]);
        });
  }
}
