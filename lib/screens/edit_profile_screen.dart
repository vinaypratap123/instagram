import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/data/network/aws/aws_provider.dart';
import 'package:instagram/provider/user_profile_provider.dart';
import 'package:instagram/utils/app_color.dart';
import 'package:instagram/utils/app_image.dart';
import 'package:instagram/utils/app_string.dart';
import 'package:instagram/utils/app_style.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  const EditProfileScreen({
    super.key,
    required this.userData,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  UserProfileViewModel userProfileViewModel = UserProfileViewModel();
// ****************************** **********************************
  final ImagePicker _imagePicker = ImagePicker();
  File? _pickedImage;

  Future<void> _pickImageFromGallery() async {
    XFile? pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
    }
  }

  Future<Uint8List> fileToUint8List(File file) async {
    Uint8List uint8list = await file.readAsBytes();
    return uint8list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppString.editProfile,
          style: AppStyle.headerTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(Icons.photo),
                              title: const Text(AppString.picImageGallery),
                              onTap: () async {
                                Map data = {
                                  "name": widget.userData["name"],
                                  "userName": widget.userData["userName"],
                                  "about": widget.userData["about"],
                                };
                                Navigator.pop(context);
                                await _pickImageFromGallery();
                                _showProfileUpdateDialog(data);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.camera),
                              title: const Text(AppString.takePhoto),
                              onTap: () async {
                                Map data = {
                                  "name": widget.userData["name"],
                                  "userName": widget.userData["userName"],
                                  "about": widget.userData["about"],
                                };
                                Navigator.pop(context);
                                await _pickImageFromCamera();
                                _showProfileUpdateDialog(data);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: widget.userData["profilePic"] == "string"
                      ? const CircleAvatar(
                          backgroundImage: AssetImage(AppImage.profilePic),
                          radius: 160,
                        )
                      : ClipOval(
                          child: Image.network(
                            widget.userData["profilePic"],
                            width: 157,
                            height: 157,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
// ******************************* FULL NAME TEXT FIELD *******************************

              TextFormField(
                style: const TextStyle(color: AppColor.blackColor),
                initialValue: widget.userData["name"],
                readOnly: true,
                decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.person, color: AppColor.blueColor),
                    suffixIcon: InkWell(
                        onTap: () {
                          Map data = {
                            "userName": widget.userData["userName"],
                            "displayPicture": widget.userData["profilePic"],
                            "about": widget.userData["about"]
                          };
                          _showNameUpdateDialog(data, widget.userData["name"]);
                        },
                        child:
                            const Icon(Icons.edit, color: AppColor.blueColor)),
                    labelStyle: const TextStyle(color: AppColor.blackColor),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: AppColor.blackColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 196, 196, 196))),
                    hintText: AppString.fullName,
                    label: const Text(AppString.fullName)),
              ),
              const SizedBox(
                height: 28,
              ),

// ******************************* USER NAME TEXT FIELD *******************************
              TextFormField(
                style: const TextStyle(color: AppColor.blackColor),
                initialValue: widget.userData["userName"],
                readOnly: true,
                decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.person, color: AppColor.blueColor),
                    suffixIcon: InkWell(
                        onTap: () {
                          Map data = {
                            "name": widget.userData["name"],
                            "displayPicture": widget.userData["profilePic"],
                            "about": widget.userData["about"]
                          };
                          _showUserNameUpdateDialog(
                              data, widget.userData["userName"]);
                        },
                        child:
                            const Icon(Icons.edit, color: AppColor.blueColor)),
                    labelStyle: const TextStyle(color: AppColor.blackColor),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: AppColor.blackColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 196, 196, 196))),
                    hintText: AppString.userName,
                    label: const Text(AppString.userName)),
              ),
              const SizedBox(
                height: 28,
              ),
// ******************************* ABOUT TEXT FIELD *******************************
              TextFormField(
                style: const TextStyle(color: AppColor.blackColor),
                initialValue: widget.userData["about"],
                readOnly: true,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.info_outline_rounded,
                        color: AppColor.blueColor),
                    suffixIcon: InkWell(
                        onTap: () {
                          Map data = {
                            "name": widget.userData["name"],
                            "userName": widget.userData["userName"],
                            "displayPicture": widget.userData["profilePic"],
                          };
                          _showAboutUpdateDialog(
                              data, widget.userData["about"]);
                        },
                        child:
                            const Icon(Icons.edit, color: AppColor.blueColor)),
                    labelStyle: const TextStyle(color: AppColor.blackColor),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: AppColor.blackColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 196, 196, 196))),
                    hintText: AppString.about,
                    label: const Text(AppString.about)),
              ),
              const SizedBox(
                height: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================================ SHOW ABOUT UPDATE DIALOG FUNCTION ===================================
  void _showAboutUpdateDialog(dynamic data, String about) {
    String updateMessage = about;
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: const Row(
                children: [
                  Icon(
                    Icons.message,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(AppString.updateAbout)
                ],
              ),
              content: TextFormField(
                maxLines: null,
                onChanged: (newMessage) => updateMessage = newMessage,
                initialValue: updateMessage,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              actions: [
                MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      AppString.cancel,
                      style: TextStyle(color: Colors.blue),
                    )),
                MaterialButton(
                    onPressed: () {
                      Map map = {
                        "name": data["name"],
                        "displayPicture": widget.userData["profilePic"],
                        "about": updateMessage,
                        "userName": data["userName"]
                      };
                      Navigator.pop(context);
                      userProfileViewModel.editProfileApi(map, context);
                    },
                    child: const Text(AppString.updates,
                        style: TextStyle(color: Colors.blue)))
              ],
            ));
  }

  // ================================ _SHOW USER NAME UPDATE DIALOG() FUNCTION ===================================
  void _showUserNameUpdateDialog(dynamic data, String userName) {
    String updateMessage = userName;
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: const Row(
                children: [
                  Icon(
                    Icons.message,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(AppString.updateUserName)
                ],
              ),
              content: TextFormField(
                maxLines: null,
                onChanged: (newMessage) => updateMessage = newMessage,
                initialValue: updateMessage,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              actions: [
                MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      AppString.cancel,
                      style: TextStyle(color: Colors.blue),
                    )),
                MaterialButton(
                    onPressed: () {
                      Map map = {
                        "name": data["name"],
                        "displayPicture": widget.userData["profilePic"],
                        "about": data["about"],
                        "userName": updateMessage
                      };
                      Navigator.pop(context);
                      userProfileViewModel.editProfileApi(map, context);
                    },
                    child: const Text("Update",
                        style: TextStyle(color: Colors.blue)))
              ],
            ));
  }

  // ================================ _SHOW NAME UPDATE DIALOG FUNCTION ===================================
  void _showNameUpdateDialog(dynamic data, String name) {
    String updateMessage = name;
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: const Row(
                children: [
                  Icon(
                    Icons.message,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(AppString.updateName)
                ],
              ),
              content: TextFormField(
                maxLines: null,
                onChanged: (newMessage) => updateMessage = newMessage,
                initialValue: updateMessage,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              actions: [
                MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      AppString.cancel,
                      style: TextStyle(color: Colors.blue),
                    )),
                MaterialButton(
                    onPressed: () {
                      Map map = {
                        "name": updateMessage,
                        "displayPicture": widget.userData["profilePic"],
                        "about": data["about"],
                        "userName": data["userName"]
                      };
                      Navigator.pop(context);
                      userProfileViewModel.editProfileApi(map, context);
                    },
                    child: const Text(AppString.updates,
                        style: TextStyle(color: Colors.blue)))
              ],
            ));
  }

  // ================================ _SHOW NAME IMAGE FUNCTION ===================================
  void _showProfileUpdateDialog(dynamic data) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: const Row(
                children: [Text(AppString.updatePic)],
              ),
              content: CircleAvatar(
                radius: 50, 
                backgroundColor:
                    Colors.transparent, 
                child: ClipOval(
                  child: Image.file(
                    File(_pickedImage!.path),
                    fit: BoxFit.cover,
                    width: 100, 
                    height: 100, 
                  ),
                ),
              ),
              actions: [
                MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      AppString.cancel,
                      style: TextStyle(color: Colors.blue),
                    )),
                MaterialButton(
                    onPressed: () async {
                      final image = await fileToUint8List(_pickedImage!);
                      await ImageUpload().uploadImageWeb(image);
                      final String imageUrl = '$s3Endpoint/$fileName';
                      
                      Map map = {
                        "name": data["name"],
                        "displayPicture": imageUrl,
                        "about": data["about"],
                        "userName": data["userName"]
                      };
                      Navigator.pop(context);
                      userProfileViewModel.editProfileApi(map, context);
                    },
                    child: const Text(AppString.updates,
                        style: TextStyle(color: Colors.blue)))
              ],
            ));
  }
}
