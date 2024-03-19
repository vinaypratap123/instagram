import 'package:flutter/material.dart';
import 'package:instagram/screens/home_screen.dart';
import 'package:instagram/screens/my_profile.dart';
import 'package:instagram/screens/post_screen.dart';
import 'package:instagram/screens/search_screen.dart';
import 'package:instagram/utils/app_color.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int pageIndex = 0;
  final pages = [
    const HomeScreen(),
    const PostScreen(),
    const SearchScreen(),
    const MyProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
     
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: AppColor.mobileBackgroundColor,
        boxShadow: [],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
                    Icons.home,
                    color: AppColor.blueColor,
                    size: 35,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: AppColor.blueColor,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
                    Icons.add,
                    color: AppColor.blueColor,
                    size: 35,
                  )
                : const Icon(
                    Icons.add,
                    color: AppColor.blueColor,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
                    Icons.search_off_sharp,
                    color: AppColor.blueColor,
                    size: 35,
                  )
                : const Icon(
                    Icons.search,
                    color: AppColor.blueColor,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 3;
              });
            },
            icon: pageIndex == 3
                ? const Icon(
                    Icons.person,
                    color: AppColor.blueColor,
                    size: 35,
                  )
                : const Icon(
                    Icons.person_outline,
                    color: AppColor.blueColor,
                    size: 35,
                  ),
          ),
        ],
      ),
    );
  }
}
