import 'package:flutter/material.dart';
import 'package:instagram/data/response/status.dart';
import 'package:instagram/provider/followers_view_provider.dart';
import 'package:instagram/screens/user_profile_screen.dart';
import 'package:instagram/utils/app_image.dart';
import 'package:instagram/utils/app_string.dart';
import 'package:provider/provider.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({super.key});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  // ************************************* FOLLOWERS VIEW MODEL INSTANCE *************************************
  FollowersViewModel followersViewModel = FollowersViewModel();
  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    followersViewModel.fetchFollowersList();
    followersViewModel.fetchFollowersList();
  }

// ************************************* INIT METHOD *************************************
  @override
  void initState() {
    super.initState();

    followersViewModel.fetchFollowersList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppString.follower),
        ),
        body: RefreshIndicator(
          onRefresh: onRefresh,
          child: ChangeNotifierProvider<FollowersViewModel>(
              create: (BuildContext context) => followersViewModel,
              child: Consumer<FollowersViewModel>(builder: (context, value, _) {
                switch (value.followerList.status) {
                  // ************************************* LOADING STATUS *************************************
                  case Status.loading:
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.blue,
                    ));
                  // ************************************* ERROR STATUS *************************************
                  case Status.error:
                    return Text(value.followerList.message.toString());
                  // ************************************* COMPLETE STATUS *************************************
                  case Status.complete:
                    final followers = value.followerList.data;

                    return SizedBox(
                      child: followers!.data.isEmpty
                          ? const Center(
                              child: Text(AppString.noFollower),
                            )
                          : ListView.builder(
                              itemCount: followers.data.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  // ************************************* USER PROFILE SCREEN ON TAP METHOD *************************************
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserProfileScreen(
                                                    userId: followers
                                                        .data[index].userId
                                                        .toString())));
                                  },
                                  // ************************************* USER PROFILE PICTURE *************************************
                                  leading: CircleAvatar(
                                    child:
                                        followers.data[index].displayPicture ==
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
                                                  followers.data[index]
                                                      .displayPicture
                                                      .toString(),
                                                  width: 57,
                                                  height: 57,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                  ),
                                  // ************************************* NAME TEXT *************************************
                                  title: Text(followers.data[index].name ?? ""),
                                  // ************************************* USER NAME TEXT *************************************
                                  subtitle: Text(
                                      followers.data[index].userName ?? ""),
                                );
                              }),
                    );
                  default:
                    return Container();
                }
              })),
        ));
  }
}
