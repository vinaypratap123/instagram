import 'package:flutter/material.dart';
import 'package:instagram/provider/auth_view_provider.dart';
import 'package:instagram/provider/check_last_screen.dart';
import 'package:instagram/provider/delete_comment_view_provider.dart';
import 'package:instagram/provider/delete_post_view_provider.dart';
import 'package:instagram/provider/feed_view_model.dart';
import 'package:instagram/provider/follow_user_view_provider.dart';
import 'package:instagram/provider/like_post_view_provider.dart';
import 'package:instagram/provider/other_user_profile.dart';
import 'package:instagram/provider/post_view_provider.dart';
import 'package:instagram/provider/report_post_view_provider.dart';
import 'package:instagram/provider/search_view_provider.dart';
import 'package:instagram/provider/unfollow_user_view_provider.dart';
import 'package:instagram/provider/unlike_post_view_provider.dart';
import 'package:instagram/provider/user_profile_provider.dart';
import 'package:instagram/provider/user_view_provider.dart';
import 'package:instagram/utils/app_color.dart';
import 'package:instagram/utils/app_string.dart';
import 'package:instagram/utils/routes/routes.dart';
import 'package:instagram/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CheckLastScreenProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => PostViewModel()),
        ChangeNotifierProvider(create: (_) => LikePostViewModel()),
        ChangeNotifierProvider(create: (_) => UnlikePostViewModel()),
        ChangeNotifierProvider(create: (_) => ReportPostViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => FollowUserViewModel()),
        ChangeNotifierProvider(create: (_) => OtherUserProfileViewModel()),
        ChangeNotifierProvider(create: (_) => FeedViewModel()),
        ChangeNotifierProvider(create: (_) => DeletePostViewModel()),
        ChangeNotifierProvider(create: (_) => UnFollowUserViewModel()),
        ChangeNotifierProvider(create: (_) => SearchViewModel()),
        ChangeNotifierProvider(create: (_) => DeleteCommentViewModel()),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppString.appName,
          theme: ThemeData.light().copyWith(
              scaffoldBackgroundColor: AppColor.mobileBackgroundColor),
          initialRoute: RoutesName.splashScreen,
          onGenerateRoute: Routes.generateRoute,
        );
      },
    );
  }
}
