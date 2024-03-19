import 'package:flutter/material.dart';
import 'package:instagram/data/response/status.dart';
import 'package:instagram/provider/followers_view_provider.dart';
import 'package:instagram/screens/user_profile_screen.dart';
import 'package:instagram/utils/app_image.dart';
import 'package:instagram/utils/app_string.dart';
import 'package:provider/provider.dart';

class OtherUserFollowersScreen extends StatefulWidget {
// ***************************** VARIABLES *******************************
  final String userId;
  const OtherUserFollowersScreen({super.key, required this.userId});

  @override
  State<OtherUserFollowersScreen> createState() =>
      _OtherUserFollowersScreenState();
}

class _OtherUserFollowersScreenState extends State<OtherUserFollowersScreen> {
  // ***************************** FOLLOWERS VIEW MODEL INSTANCE *******************************
  FollowersViewModel followersViewModel = FollowersViewModel();
  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    followersViewModel.fetchOtherFollowersList(widget.userId);
  }
// ***************************** INIT STATE METHOD *******************************
  @override
  void initState() {
    super.initState();

    followersViewModel.fetchOtherFollowersList(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
// ***************************** SCAFFOLD *******************************
    return Scaffold(
// ***************************** APP BAR *******************************
        appBar: AppBar(
          title: const Text(AppString.follower),
        ),
        body: RefreshIndicator(
          onRefresh: onRefresh,
          child: ChangeNotifierProvider<FollowersViewModel>(
              create: (BuildContext context) => followersViewModel,
              child: Consumer<FollowersViewModel>(builder: (context, value, _) {
                switch (value.otherUserFollowerList.status) {
                  case Status.loading:
        // ***************************** LOADING STATUS *******************************
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.blue,
                    ));
        // ***************************** ERROR STATUS *******************************
                  case Status.error:
                    return Text(value.otherUserFollowerList.message.toString());
        // ***************************** COMPLETE STATUS *******************************
                  case Status.complete:
                    final followers = value.otherUserFollowerList.data;
        
                    return SizedBox(
                      child: followers!.data.isEmpty
                          ? const Center(
                              child: Text(AppString.noFollower),
                            )
        // ***************************** LIST VIEW BUILDER *******************************
                          : ListView.builder(
                              itemCount: followers.data.length,
                              itemBuilder: (context, index) {
                                return ListTile(
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
        // ***************************** CIRCLE AVATAR *******************************
                                  leading: const CircleAvatar(
        // ***************************** PERSON ICON *******************************
                                    backgroundImage:AssetImage(AppImage.profilePic),
                                  ),
        // ***************************** NAME TEXT *******************************
                                  title: Text(followers.data[index].name ?? ""),
        // ***************************** USER NAME TEXT *******************************
                                  subtitle:
                                      Text(followers.data[index].userName ?? ""),
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
