// ignore_for_file: avoid_print

import 'dart:io';

import 'package:diet_app/constants/app_bar.dart';
import 'package:diet_app/data_models/user_model.dart';
import 'package:diet_app/provider_model/user_provider_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../constants/app_drawer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File imageFile = File('');
  final fullNameInputController = TextEditingController();
  final emailInputController = TextEditingController();
  final ageInputController = TextEditingController();
  final weightInputController = TextEditingController();
  final heightInputController = TextEditingController();
  String userEmail = "";
  bool isPictureUploading = false;

  void selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      cropImage(pickedFile);
    }
  }

  void cropImage(XFile xFile) async {
    try {
      ImageCropper imageCropper = ImageCropper();
      CroppedFile? croppedImage = await imageCropper.cropImage(
        sourcePath: xFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 20,
        cropStyle: CropStyle.circle,
      );
      File? file = croppedImage?.path != null ? File(croppedImage!.path) : null;
      if (croppedImage != null) {
        setState(() {
          imageFile = file as File;
        });
        setProfilePicture(userEmail);
      }
    } catch (e) {
      print('Error cropping image: $e');
    }
  }

  void showImageOptions() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.green, width: 1),
            ),
            title: Text(
              "Upload profile picture",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontFamily: 'OpenSans',
                fontSize: 17.sp,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      selectImage(ImageSource.gallery);
                    },
                    leading: const Icon(
                      Icons.photo_album,
                      color: Colors.grey,
                    ),
                    title: Text(
                      "Select from gallery",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontFamily: 'OpenSans',
                        fontSize: 17.sp,
                      ),
                    )),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(ImageSource.camera);
                  },
                  leading:
                      const Icon(Icons.camera_alt_outlined, color: Colors.grey),
                  title: Text(
                    "Take a photo",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontFamily: 'OpenSans',
                      fontSize: 17.sp,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  Future<void> setProfilePicture(String email) async {
    setState(() {
      isPictureUploading = true;
    });
    await context.read<UserProvider>().setProfilePicture(imageFile, email);
    setState(() {
      isPictureUploading = false;
    });
  }

  Future<void> logout() async {
    await context.read<UserProvider>().logout();
  }

  @override
  Widget build(BuildContext context) {
    UserData user = context.watch<UserProvider>().user;
    setState(() {
      userEmail = user.email;
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(title: 'Profile'),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1),
            child: Column(
              children: [
                CupertinoButton(
                  child: !isPictureUploading
                      ? CircleAvatar(
                          radius: 65,
                          backgroundImage: (user.profilePictureUrl != "")
                              ? NetworkImage(user.profilePictureUrl)
                              : null,
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                          child: imageFile.path == "" &&
                                  user.profilePictureUrl == ""
                              ? Image.asset(
                                  'assets/images/user-image.png',
                                  fit: BoxFit.contain,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                )
                              : null,
                        )
                      : const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 65,
                          child: CircularProgressIndicator(
                            color: Colors.green,
                          )),
                  onPressed: () {
                    showImageOptions();
                  },
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Full name',
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green.shade200),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        cursorColor: Colors.green,
                        style: const TextStyle(color: Colors.green),
                        controller: fullNameInputController,
                        decoration: InputDecoration(
                          hintText: user.fullName,
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green.shade200),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        cursorColor: Colors.green,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.green),
                        readOnly: true,
                        controller: emailInputController,
                        decoration: InputDecoration(
                          hintText: user.email,
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Age',
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green.shade200),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        cursorColor: Colors.green,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.green),
                        controller: ageInputController,
                        decoration: InputDecoration(
                          hintText: user.age.toString(),
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Weight [kg]',
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green.shade200),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        cursorColor: Colors.green,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.green),
                        controller: weightInputController,
                        decoration: InputDecoration(
                          hintText: user.weight.toString(),
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Height [cm]',
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green.shade200),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        cursorColor: Colors.green,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.green),
                        controller: heightInputController,
                        decoration: InputDecoration(
                          hintText: user.height.toString(),
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    logout();
                    Navigator.pushReplacementNamed(context, '/sign-in-screen');
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.5,
                        MediaQuery.of(context).size.height * 0.05),
                    backgroundColor: Colors.grey.shade300,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.green, width: 1.5),
                    ),
                  ),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16.sp,
                      fontFamily: 'Cabin',
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
