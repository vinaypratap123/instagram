import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/data/network/aws/aws_provider.dart';
import 'package:instagram/provider/post_view_provider.dart';
import 'package:instagram/utils/app_color.dart';
import 'package:instagram/utils/app_string.dart';
import 'package:instagram/utils/app_style.dart';
import 'package:instagram/widgets/rectangle_button.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
// ****************************** CAPTION CONTROLLER **********************************
  TextEditingController captionController = TextEditingController();
  bool _isLoading = false;
// ****************************** DISPOSE CAPTION CONTROLLER **********************************
  @override
  void dispose() {
    super.dispose();
    captionController.dispose();
  }

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

// ****************************** **********************************
  @override
  Widget build(BuildContext context) {
// ****************************** VARIABLES **********************************
    final postViewModel = Provider.of<PostViewModel>(context);
    final mq = MediaQuery.of(context).size;

// ****************************** SCAFFOLD **********************************
    return Stack(
      children: [
        Scaffold(
    // ****************************** APP BAR **********************************
          appBar: AppBar(
            title: const Text(AppString.post),
            bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(4.0),
                  child: _isLoading
                      ? const LinearProgressIndicator(
                          color: Colors.red,
                        )
                      : const PreferredSize(
                          preferredSize: Size.zero, child: SizedBox()),
                ),
            ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
    // ****************************** WHAT'S IN YOUR MIND TEXT **********************************
                const Text(
                  AppString.whatInYourMind,
                  style: AppStyle.regularTextStyle,
                ),
                const SizedBox(
                  height: 5,
                ),
    // ****************************** CAPTION TEXT FORM FIELD **********************************
                TextFormField(
                  controller: captionController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: AppString.writeSomething,
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.blackColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.primaryColor)),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
    // ****************************** ON TAP METHOD FOR SHOW BOTTOM SHEET FOR PICKING THE IMAGE **********************************
                InkWell(
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
                              onTap: () {
                                Navigator.pop(context);
                                _pickImageFromGallery();
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.camera),
                              title: const Text(AppString.takePhoto),
                              onTap: () {
                                Navigator.pop(context);
                                _pickImageFromCamera();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    height: mq.height * 0.30,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(border: Border.all()),
                    child: _pickedImage == null
                        ? const Center(child: Text(AppString.takePhoto))
                        : Image.file(
                            File(_pickedImage!.path),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
    // ******************** POST BUTTON ******************************
    
                RectangleButton(
                    btnName: AppString.post,
                    loading: postViewModel.postLoading,
                    btnCallBack: () async {
                      if (_pickedImage == null) {}
    setState(() {
                          _isLoading = true;
                        });
                        try{
                      final image = await fileToUint8List(_pickedImage!);
                      await ImageUpload().uploadImageWeb(image);
    
                      postViewModel.postApi(
                          captionController.text.toString(), context);
                        }
                        catch(e){}
                        finally{
                          setState(() {
                            _isLoading=false;
                          });
                        }
                    })
              ],
            ),
          ),
        ),
       _isLoading
            ? ModalBarrier(
                color: Colors.black.withOpacity(0.3),
                dismissible: false,
              )
            : const SizedBox(),
      ],
    );
  }

// ******************** SHOW BOTTOM SHEET METHOD ******************************
}
