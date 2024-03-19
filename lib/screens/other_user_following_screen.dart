import 'package:flutter/material.dart';
import 'package:instagram/data/response/status.dart';
import 'package:instagram/provider/following_view_provider.dart';
import 'package:instagram/screens/user_profile_screen.dart';
import 'package:instagram/utils/app_image.dart';
import 'package:instagram/utils/app_string.dart';
import 'package:provider/provider.dart';

class OtherUserFollowingScreen extends StatefulWidget {
// ***************************** VARIABLES *******************************
  final String userId;
  const OtherUserFollowingScreen({super.key, required this.userId});

  @override
  State<OtherUserFollowingScreen> createState() =>
      _OtherUserFollowingScreenState();
}

class _OtherUserFollowingScreenState extends State<OtherUserFollowingScreen> {
// ***************************** FOLLOWERS VIEW MODEL INSTANCE *******************************
  FollowingViewModel followingViewModel = FollowingViewModel();
 Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    followingViewModel.fetchOtherUserFollowingList(widget.userId);
  }
// ***************************** INIT STATE METHOD *******************************
  @override
  void initState() {
    super.initState();

    followingViewModel.fetchOtherUserFollowingList(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
// ***************************** SCAFFOLD *******************************
    return Scaffold(
// ***************************** APP BAR *******************************
        appBar: AppBar(
          title: const Text(AppString.following),
        ),
        body: RefreshIndicator(
          onRefresh: onRefresh,
          child: ChangeNotifierProvider<FollowingViewModel>(
              create: (BuildContext context) => followingViewModel,
              child: Consumer<FollowingViewModel>(builder: (context, value, _) {
                switch (value.otherUserFollowingList.status) {
        // ***************************** LOADING STATUS *******************************
                  case Status.loading:
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.blue,
                    ));
        // ***************************** ERROR STATUS *******************************
                  case Status.error:
                    return Text(value.otherUserFollowingList.message.toString());
        // ***************************** COMPLETE STATUS *******************************
                  case Status.complete:
                    final followers = value.otherUserFollowingList.data;
        
                    return SizedBox(
                      child: followers!.data.isEmpty
                          ? const Center(
                              child: Text(AppString.noFollowing),
                            )
        // ***************************** LIST VIEW BUILDER *******************************
                          : ListView.builder(
                              itemCount: followers.data.length,
                              itemBuilder: (context, index) {
                                return ListTile(
        // ***************************** LIST TILE ON TAP METHOD *******************************
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
                                      backgroundImage:
                                          AssetImage(AppImage.profilePic),
                                    ),
        // ***************************** NAME TEXT *******************************
                                    title: Text(followers.data[index].name ?? ""),
        // ***************************** USER NAME TEXT *******************************
                                    subtitle: Text(
                                        followers.data[index].userName ?? ""),
                                    trailing: const SizedBox(
                                      height: 35,
                                      width: 90,
                                    ));
                              }),
                    );
                  default:
                    return Container();
                }
              })),
        ));
  }
}
