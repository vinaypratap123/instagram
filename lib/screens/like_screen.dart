import 'package:flutter/material.dart';
import 'package:instagram/data/response/status.dart';
import 'package:instagram/provider/like_list_view_provider.dart';
import 'package:instagram/screens/user_profile_screen.dart';
import 'package:instagram/utils/app_string.dart';
import 'package:instagram/utils/app_style.dart';
import 'package:provider/provider.dart';

class LikeScreen extends StatefulWidget {
// ********************************* VARIABLES ********************************
  final String postId;
  final String userId;
  const LikeScreen({super.key, required this.postId, required this.userId});

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
// ********************************* LIKE LIST VIEW MODEL INSTANCE ********************************
  LikeListViewModel likeListViewModel = LikeListViewModel();
  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    likeListViewModel.fetchLikeList(widget.postId);
  }
// ********************************* INIT STATE METHOD ********************************
  @override
  void initState() {
    super.initState();
    likeListViewModel.fetchLikeList(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
// ********************************* SCAFFOLD ********************************
    return Scaffold(
// ********************************* APP BAR ********************************
      appBar: AppBar(
        title: const Text(
          AppString.likes,
          style: AppStyle.headerTextStyle,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: ChangeNotifierProvider<LikeListViewModel>(
            create: (BuildContext context) => likeListViewModel,
            child: Consumer<LikeListViewModel>(builder: (context, value, _) {
              switch (value.likeList.status) {
      // ********************************* LOADING STATUS ********************************
                case Status.loading:
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.blue,
                  ));
      // ********************************* ERROR STATUS ********************************
                case Status.error:
                  return Text(value.likeList.message.toString());
      // ********************************* COMPLETE STATUS ********************************
                case Status.complete:
                  final followers = value.likeList.data;
      
                  return SizedBox(
                    child: followers!.data.isEmpty
                        ? const Center(
                            child: Text(AppString.noLikes),
                          )
                        : ListView.builder(
                            itemCount: followers.data.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                child: ListTile(
      // ********************************* USER PROFILE PICTURE  ********************************
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserProfileScreen(
                                                    userId: followers
                                                        .data[index].id)));
                                  },
                                  leading: const CircleAvatar(
      // ********************************* PERSON ICON  ********************************
                                    child: Icon(
                                      Icons.person,
                                      size: 30,
                                    ),
                                  ),
      // ********************************* NAME TEXT  ********************************
                                  title: Text(followers.data[index].name ?? ""),
                                  subtitle:
      // ********************************* USER NAME TEXT  ********************************
                                      Text(followers.data[index].userName ?? ""),
                                ),
                              );
                            }),
                  );
                default:
                  return Container();
              }
            })),
      ),
    );
  }
}
