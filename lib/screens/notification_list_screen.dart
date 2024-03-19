import 'package:flutter/material.dart';
import 'package:instagram/data/response/status.dart';
import 'package:instagram/provider/delete_notification_provider.dart';
import 'package:instagram/provider/notification_provider.dart';
import 'package:instagram/screens/user_profile_screen.dart';
import 'package:instagram/ui_helper/ui_helper.dart';
import 'package:instagram/utils/app_string.dart';
import 'package:instagram/utils/app_style.dart';
import 'package:provider/provider.dart';

class NotificatonListScreen extends StatefulWidget {
  const NotificatonListScreen({super.key});

  @override
  State<NotificatonListScreen> createState() => _NotificatonListScreenState();
}

class _NotificatonListScreenState extends State<NotificatonListScreen> {
// ********************************* NOTIFICATION VIEW MODEL INSTANCE ********************************
  NotificationViewModel notificationViewModel = NotificationViewModel();
  DeleteNotificationViewModel deleteNotificationViewModel =
      DeleteNotificationViewModel();

// ********************************* INIT STATE METHOD ********************************
  @override
  void initState() {
    super.initState();

    notificationViewModel.fetchNotificationList(1);
  }

  @override
  Widget build(BuildContext context) {
// ********************************* SCAFFOLD ********************************
    return Scaffold(
// ********************************* APP BAR ********************************
      appBar: AppBar(
        title: const Text(
          AppString.notification,
          style: AppStyle.headerTextStyle,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return notificationViewModel.fetchNotificationList(1);
          
        },
        child: ChangeNotifierProvider<NotificationViewModel>(
            create: (BuildContext context) => notificationViewModel,
            child: Consumer<NotificationViewModel>(builder: (context, value, _) {
              // notificationViewModel.fetchNotificationList(1);
              switch (value.notificationList.status) {
      // ********************************* LOADING STATUS ********************************
                case Status.loading:
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.blue,
                  ));
      // ********************************* ERROR STATUS ********************************
                case Status.error:
                  return Text(value.notificationList.message.toString());
      // ********************************* COMPLETE STATUS ********************************
                case Status.complete:
                // notificationViewModel.fetchNotificationList(1);
                  final notification =
                      value.notificationList.data!.data.notifications;
      
                  return SizedBox(
                    child: notification.isEmpty
                        ? const Center(
                            child: Text(AppString.noNotification),
                          )
                        : ListView.builder(
                            itemCount: notification.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                child: ListTile(
      
                                  // tileColor:notification[index].read == true ? Colors.white:Colors.brown,
      // ********************************* USER PROFILE PICTURE  ********************************
                                    onTap: () {},
                                    leading: const CircleAvatar(
      // ********************************* PERSON ICON  ********************************
                                      child: Icon(
                                        Icons.person,
                                        size: 30,
                                      ),
                                    ),
      // ********************************* NAME TEXT  ********************************
                                   
                                    title: InkWell(
                                      onTap: () {
                                        // SharedPreferences sp = SharedPreferences.getInstance()
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>UserProfileScreen(userId: notification[index].senderId)));
                                      },
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: notification[index].notificationData.userName,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors
                                                    .black, // You can customize the color
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  ' ' +notification[index].message,
                                              style: const TextStyle(
                                                color: Colors
                                                    .black, // You can customize the color
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
      
      // ********************************* COMMENT TEXT  ********************************
      
                                    trailing: InkWell(
                                        onTap: () {
                                          showBottomSheet(
                                              notification[index].id, context);
                                        },
                                        child: const Icon(Icons.more_vert))),
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

  // ************************************ SHOW BOTTOM SHEET METHOD *****************************
  void showBottomSheet(String notificationId, BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(40.0),
      topRight: Radius.circular(40.0),
    ),
  ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Column(
            children: <Widget>[
               const SizedBox(height: 10,),
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
              SizedBox(height: 20,),
              ListTile(
                leading: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                title: const Text(
                  AppString.deleteNotification,
                  style: AppStyle.smallRedTextStyle,
                ),
// ************************************ SHOW BOTTOM SHEET ON TAP METHOD *****************************
                onTap: () {
                  Navigator.pop(context);
                  showDeleteConfirmationDialog(notificationId, context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ************************************ SHOW LOGOUT CONFIRMATION DIALOG METHOD *****************************
  void showDeleteConfirmationDialog(
      String notificationId, BuildContext context) {
    // final deleteCommentViewModel =
    //     Provider.of<DeleteCommentViewModel>(context, listen: false);

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
// ************************************ SHOW LOGOUT CONFIRMATION DIALOG ON PRESSED METHOD *****************************
                    onPressed: () async {
                      Navigator.pop(context);
                      UiHelper.showProgressBar(context);
                    await  deleteNotificationViewModel.deleteNotificationApi(
                          notificationId, context);
                 await   notificationViewModel.fetchNotificationList(1);
                      Navigator.pop(context);
                    }),
              ]);
        });
  }
}
