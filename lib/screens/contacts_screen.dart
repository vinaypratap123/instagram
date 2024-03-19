import 'package:flutter/material.dart';
import 'package:instagram/data/response/status.dart';
import 'package:instagram/provider/all_user_view_provider.dart';
import 'package:instagram/screens/user_profile_screen.dart';
import 'package:instagram/utils/app_string.dart';
import 'package:instagram/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
// ************************************* ALL USER VIEW MODEL INSTANCE *************************************
  AllUserViewModel allUserViewModel = AllUserViewModel();

// ************************************* INIT STATE METHOD *************************************
  @override
  void initState() {
    super.initState();
    allUserViewModel.fetchAllUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppString.contacts),
        ),
        body: ChangeNotifierProvider<AllUserViewModel>(
            create: (BuildContext context) => allUserViewModel,
            child: Consumer<AllUserViewModel>(builder: (context, value, _) {
              switch (value.allUserList.status) {
// ************************************* LOADING STATUS *************************************
                case Status.loading:
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.blue,
                  ));
// ************************************* ERROR STATUS *************************************
                case Status.error:
                  return Text(value.allUserList.message.toString());
// ************************************* COMPLETE STATUS *************************************
                case Status.complete:
                  final followers = value.allUserList.data;

                  return SizedBox(
// ************************************* LIST VIEW BUILDER  *************************************
                    child: ListView.builder(
                        itemCount: followers?.data.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            child: followers!.data.isEmpty
                                ? const Center(
                                    child: Text(AppString.noContacts),
                                  )
                                : ListTile(
// ************************************* USER PROFILE PICTURE  *************************************
                                    leading: const CircleAvatar(
                                      child: Icon(
// ************************************* PERSON ICON *************************************
                                        Icons.person,
                                        size: 30,
                                      ),
                                    ),
// ************************************* NAME TEXT *************************************
                                    title: Text(followers.data[index].name),
// ************************************* USER NAME TEXT *************************************
                                    subtitle:
                                        Text(followers.data[index].userName),
// ************************************* VIEW PROFILE BUTTON ON TAP METHOD *************************************
                                    trailing: SizedBox(
                                        height: 35,
                                        width: 100,
                                        child: RoundedButton(
                                            btnName: AppString.viewProfile,
                                            btnCallBack: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UserProfileScreen(
                                                              userId: followers
                                                                  .data[index]
                                                                  .userId
                                                                  .toString())));
                                            }))),
                          );
                        }),
                  );
                default:
                  return Container();
              }
            })));
  }
}
