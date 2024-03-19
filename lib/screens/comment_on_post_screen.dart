import 'package:flutter/material.dart';
import 'package:instagram/provider/post_view_provider.dart';
import 'package:instagram/ui_helper/ui_helper.dart';
import 'package:instagram/utils/app_color.dart';
import 'package:instagram/utils/app_image.dart';
import 'package:instagram/utils/app_string.dart';
import 'package:instagram/utils/app_style.dart';

class CommentOnPostScreen extends StatefulWidget {
  // final String postId;
  final Map data;

  const CommentOnPostScreen({super.key, required this.data});

  @override
  State<CommentOnPostScreen> createState() => _CommentOnPostScreenState();
}

class _CommentOnPostScreenState extends State<CommentOnPostScreen> {
  final TextEditingController _commentController = TextEditingController();
  PostViewModel postViewModel = PostViewModel();
  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppString.comment),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              // ************************************* USER PROFILE PICTURE *****************************************
              leading: CircleAvatar(
                radius: 50,
                // backgroundColor: Colors.blue,
                // child: Icon(Icons.person,size: 40,),
      
                child: widget.data["pic"] == "string"
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
                          widget.data["pic"].toString(),
                          width: 57,
                          height: 57,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              // ************************************* PERSON ICON *****************************************
      
              // ************************************* NAME TEXT *****************************************
              title: Text(
                widget.data["Name"],
                style: AppStyle.regularTextStyle,
              ),
              // ************************************* USER NAME TEXT *****************************************
              subtitle: Text(
                widget.data["userName"],
                style: AppStyle.regularTextStyle,
              ),
              // ************************************* MORE VERT ON TAP METHOD *****************************************
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.data["caption"],
                      style: AppStyle.regularTextStyle,
                    ),
                  ),
                ),
              ],
            ),
            // ******************************************* USER POST IMAGE ***********************************************
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
              color: AppColor.blackColor,
              child: Image.network(
                widget.data["img"],
                fit: BoxFit.cover,
              ),
              // child: Image.asset(
              //   AppImage.posts,
              // fit: BoxFit.cover,
              // ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: _commentController,
                        style: TextStyle(color: AppColor.blackColor),
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: AppColor.blackColor),
                          hintText: AppString.typeMessage,
                          labelText: AppString.typeMessage,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 2,),
                  Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(19)),
                child: InkWell(
                  onTap: () {
                    String comment = _commentController.text.toString();
                    if (comment.isEmpty) {
                      UiHelper.flushBarErrorMessage(
                          context, "Please Enter Some Comment");
                    } else {
                      postViewModel.commentApi(
                          widget.data["postId"], comment, context);
                    }
            
                    _commentController.clear();
                    FocusScope.of(context).unfocus(); // Close the keyboard
                  },
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ),
                ],
              ),
            ),
            
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
