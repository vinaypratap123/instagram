import 'package:flutter/material.dart';
import 'package:instagram/data/response/status.dart';
import 'package:instagram/provider/feed_view_model.dart';
import 'package:instagram/provider/like_post_view_provider.dart';
import 'package:instagram/provider/notification_provider.dart';
import 'package:instagram/provider/report_post_view_provider.dart';
import 'package:instagram/provider/unlike_post_view_provider.dart';
import 'package:instagram/provider/user_profile_provider.dart';
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
// ************************************* INSTANCES *****************************************
  LikePostViewModel likePostViewModel = LikePostViewModel();
  UnlikePostViewModel unlikePostViewModel = UnlikePostViewModel();
  FeedViewModel feedViewModel = FeedViewModel();
  ReportPostViewModel reportPost = ReportPostViewModel();
  UserProfileViewModel userProfileViewModel = UserProfileViewModel();

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    feedViewModel.fetchFeedList();
  }

// ************************************* INIT STATE METHOD *****************************************
  @override
  void initState() {
    super.initState();

    feedViewModel.fetchFeedList();
    feedViewModel.setRefresh(true);
  }

  @override
  Widget build(BuildContext context) {
// ************************************* SCAFFOLD *****************************************
    return Scaffold(
// ************************************* APP BAR *****************************************
        appBar: AppBar(
          title: const Text(AppString.appName),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: () async {
                  Navigator.pushNamed(
                      context, RoutesName.notificationListScreen);
                },
                child: const Icon(
                  Icons.notifications_outlined,
                  size: 30,
                ),
              ),
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: onRefresh,
          child: ChangeNotifierProvider<FeedViewModel>(
              create: (BuildContext context) => feedViewModel,
              child: Consumer<FeedViewModel>(builder: (context, value, _) {
                switch (value.feedList.status) {
                  // ************************************* LOADING STATUS *****************************************
                  case Status.loading:
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.blue,
                    ));
                  // ************************************* ERROR STATUS *****************************************
                  case Status.error:
                    return Text(value.feedList.message.toString());
                  // ************************************* COMPLETE STATUS *****************************************
                  case Status.complete:
                    final feeds = value.feedList.data!.data.feed;

                    return SizedBox(
                      child: feeds.isEmpty
                          ? const Center(
                              child: Text(AppString.noFeeds),
                            )
                          // ************************************* LIST VIEW BUILDER *****************************************
                          : ListView.builder(
                              itemCount: feeds.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  color: AppColor.mobileBackgroundColor,
                                  child: Column(
                                    children: [
                                      // ************************************* USER LIST TILE *****************************************
                                      ListTile(
                                        // ************************************* USER PROFILE PICTURE *****************************************
                                        leading: CircleAvatar(
                                          radius: 50,
                                          // backgroundColor: Colors.blue,
                                          // child: Icon(Icons.person,size: 40,),

                                          child: value
                                                      .feedList
                                                      .data!
                                                      .data
                                                      .feed[index]
                                                      .user
                                                      .displayPicture ==
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
                                                    value
                                                        .feedList
                                                        .data!
                                                        .data
                                                        .feed[index]
                                                        .user
                                                        .displayPicture
                                                        .toString(),
                                                    width: 57,
                                                    height: 57,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                        ),
                                        // ************************************* PERSON ICON *****************************************

                                        // ************************************* NAME TEXT *****************************************
                                        title: Text(
                                          value.feedList.data!.data.feed[index]
                                              .user.name,
                                          style: AppStyle.regularTextStyle,
                                        ),
                                        // ************************************* USER NAME TEXT *****************************************
                                        subtitle: Text(
                                          value.feedList.data!.data.feed[index]
                                              .user.userName,
                                          style: AppStyle.regularTextStyle,
                                        ),
                                        // ************************************* MORE VERT ON TAP METHOD *****************************************
                                        trailing: InkWell(
                                          onTap: () {
                                            showBottomSheet(
                                                feeds[index]
                                                    .followedPosts
                                                    .postId
                                                    .toString(),
                                                context);
                                          },
                                          // ************************************* MORE VERT ICON *****************************************
                                          child: const Icon(
                                            Icons.more_vert,
                                            color: AppColor.primaryBlackColor,
                                          ),
                                        ),
                                      ),
                                      // ************************************ POST CAPTION TEXT ***************************************
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                feeds[index]
                                                    .followedPosts
                                                    .caption,
                                                style:
                                                    AppStyle.regularTextStyle,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // ************************************ USER POST IMAGE ****************************************
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.30,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Image.network(
                                          feeds[index].followedPosts.content,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              // If no progress is available, display the child (the image)
                                              return child;
                                            } else {
                                              // If there's progress, display a loading indicator
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          (loadingProgress
                                                                  .expectedTotalBytes ??
                                                              1)
                                                      : null,
                                                ),
                                              );
                                            }
                                          },
                                          errorBuilder: (BuildContext context,
                                              Object error,
                                              StackTrace? stackTrace) {
                                            return const Center(
                                                child: Text(AppString
                                                    .errorLoadingImage));
                                          },
                                        ),
                                      ),
                                      // ************************************ USER POST IMAGE ****************************************

                                      const SizedBox(
                                        height: 10,
                                      ),

                                      // ************************************ ICONS ROW ****************************************
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, left: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                // ************************************ LIKE ICON ****************************************

                                                InkWell(
                                                  onTap: () async {
                                                    Map data = {
                                                      "recieverId":
                                                          feeds[index].user.id,
                                                      "type": "like",
                                                      "actionId":
                                                          feeds[index].id
                                                    };

                                                    feeds[index]
                                                                .liked
                                                                .toString() ==
                                                            "0"
                                                        ? likePostViewModel
                                                            .likePostApi(
                                                                feeds[index]
                                                                    .followedPosts
                                                                    .postId
                                                                    .toString(),
                                                                data,
                                                                context)
                                                        : unlikePostViewModel
                                                            .deletePostApi(
                                                                feeds[index]
                                                                    .followedPosts
                                                                    .postId
                                                                    .toString(),
                                                                context);
                                                  },
                                                  child: Icon(
                                                    feeds[index]
                                                                .liked
                                                                .toString() ==
                                                            "0"
                                                        ? Icons.favorite_outline
                                                        : Icons.favorite,
                                                    color: AppColor.blueColor,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                // ************************************ COMMENT ICON ****************************************
                                                InkWell(
                                                  onTap: () async {
                                                    SharedPreferences sp =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    String? id =
                                                        sp.getString("userId");
                                                    Map map = {
                                                      "postId": feeds[index]
                                                          .followedPosts
                                                          .postId
                                                          .toString(),
                                                      "caption": feeds[index]
                                                          .followedPosts
                                                          .caption,
                                                      "img": feeds[index]
                                                          .followedPosts
                                                          .content,
                                                      "Name": value
                                                          .feedList
                                                          .data!
                                                          .data
                                                          .feed[index]
                                                          .user
                                                          .name,
                                                      "userName": value
                                                          .feedList
                                                          .data!
                                                          .data
                                                          .feed[index]
                                                          .user
                                                          .name,
                                                      "pic": value
                                                          .feedList
                                                          .data!
                                                          .data
                                                          .feed[index]
                                                          .user
                                                          .displayPicture,
                                                    };
                                                    Navigator.pushNamed(
                                                        context,
                                                        RoutesName
                                                            .commentOnPost,
                                                        arguments: map);
                                                    // Navigator.pushNamed(
                                                    //     context,
                                                    //     RoutesName
                                                    //         .commentOnPost,
                                                    //     arguments: feeds[index]
                                                    //         .followedPosts
                                                    //         .postId
                                                    //         .toString());

                                                    Map data = {
                                                      "recieverId":
                                                          feeds[index].user.id,
                                                      "type": "comment",
                                                      "actionId":
                                                          feeds[index].id
                                                    };

                                                    NotificationViewModel
                                                        notificationViewModel =
                                                        NotificationViewModel();
                                                    if (id !=
                                                        data["recieverId"]) {
                                                      notificationViewModel
                                                          .notificationsApi(
                                                              data, context);
                                                    }
                                                  },
                                                  child: const Icon(
                                                    Icons.chat_bubble_outline,
                                                    color: AppColor.blueColor,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                //
                                              ],
                                            ),
                                            // ************************************ SAVE ICON ****************************************
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
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: InkWell(
                                          onTap: () {
                                            // ************************************ LIKE SCREEN ON TAP METHOD ***************************************
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LikeScreen(
                                                            postId: feeds[index]
                                                                .followedPosts
                                                                .postId,
                                                            userId: feeds[index]
                                                                .id)));
                                          },
                                          child: Row(
                                            children: [
                                              // ************************************ NUMBER OF LIKE TEXT ***************************************
                                              Text(
                                                feeds[index]
                                                    .numberOfLikes
                                                    .toString(),
                                                style:
                                                    AppStyle.regularTextStyle,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              // ************************************ LIKE TEXT ***************************************
                                              const Text(
                                                AppString.likes,
                                                style: AppStyle.smallTextStyle,
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
                                        // ************************************ COMMENT SCREEN ON TAP METHOD***************************************
                                        child: InkWell(
                                          onTap: () async {
                                            SharedPreferences sp =
                                                await SharedPreferences
                                                    .getInstance();
                                            String? uId =
                                                sp.getString("userId");
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CommentScreen(
                                                          postId: feeds[index]
                                                              .followedPosts
                                                              .postId,
                                                          userId:
                                                              feeds[index].id,
                                                          caption: feeds[index]
                                                              .followedPosts
                                                              .caption,
                                                          img: feeds[index]
                                                              .followedPosts
                                                              .content,
                                                          uId: uId,
                                                        )));
                                          },
                                          child: Row(
                                            children: [
                                              // ************************************ NUMBER OF COMMENT TEXT ***************************************
                                              Text(
                                                feeds[index]
                                                    .numberOfComments
                                                    .toString(),
                                                style:
                                                    AppStyle.regularTextStyle,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              // ************************************ COMMENT TEXT ***************************************
                                              const Text(
                                                AppString.comment,
                                                style: AppStyle.smallTextStyle,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Divider(
                                        thickness: 1,
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                    );
                  default:
                    return Container();
                }
              })),
        ));
  }

// ************************************ SHOW BOTTOM SHEET METHOD ***************************************
  void showBottomSheet(String postId, BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      
      builder: (BuildContext context) {
        return SizedBox(
          height: 150,
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
                  Icons.report,
                  color: Colors.red,
                ),
                title: const Text(
                  AppString.reportPost,
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  showReportPostConfirmationDialog(postId, context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

// ************************************ SHOW REPORT POST CONFIRMATION DIALOG METHOD ***************************************
  void showReportPostConfirmationDialog(String postId, BuildContext context) {
    final reportPostViewModel =
        Provider.of<ReportPostViewModel>(context, listen: false);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text(AppString.confirmReport),
              content: const Text(AppString.sureReport),
              actions: <Widget>[
                TextButton(
                  child: const Text(AppString.cancel),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                    child: const Text(
                      AppString.report,
                      style: AppStyle.smallRedTextStyle,
                    ),
                    onPressed: () async {
                      Navigator.pop(context);

                      await reportPostViewModel.reportPostApi(postId, context);
                      feedViewModel.fetchFeedList();
                      UiHelper.flushBarMessage(
                          context, "Post Reported Successfully");
                    }),
              ]);
        });
  }
}
