import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController authController = Get.put(AuthController());
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  static String? imagePath;

  Future<void> pickImagegallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) setState(() => imagePath = pickedFile.path);
  }

  Future<void> pickImagecamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) setState(() => imagePath = pickedFile.path);
  }

  void login() async {
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        imagePath != null) {
      await authController.saveLoginData(nameController.text,
          emailController.text, passwordController.text, imagePath!);
      Get.offNamed('/home');

      imagePath = null;
    } else {
      Get.snackbar('Error', 'Please fill all fields.',
          backgroundColor: Colors.red.shade100);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imagePath != null
                ? CircleAvatar(
                    backgroundImage: FileImage(File(imagePath!)),
                    radius: 50,
                  )
                : Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade100,
                        child: Icon(
                          CupertinoIcons.person,
                          color: Colors.black,
                          size: 50,
                        ),
                      ),
                      GestureDetector(
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.blue.shade400,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        onTap: () {
                          Get.defaultDialog(
                            title: 'Add Image',
                            titleStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            content: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton.filled(
                                      onPressed: pickImagecamera,
                                      icon: Icon(CupertinoIcons.camera_fill),
                                      color: Colors.white,
                                    ),
                                    IconButton.filled(
                                      onPressed: pickImagegallery,
                                      icon: Icon(CupertinoIcons.photo),
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
            SizedBox(
              height: 20,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     IconButton.filled(
            //       onPressed: pickImagecamera,
            //       icon: Icon(CupertinoIcons.camera_fill),
            //       focusColor: Colors.blueAccent,
            //     ),
            //     IconButton.filled(
            //       onPressed: pickImagegallery,
            //       icon: Icon(CupertinoIcons.photo),
            //     ),
            //   ],
            // ),
            TextFormField(
              textInputAction: TextInputAction.next,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              controller: nameController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 2,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: Colors.white70,
                hintText: "Enter your Name",
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
                border: const OutlineInputBorder(),
                prefixIcon: Icon(CupertinoIcons.person_solid),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              textInputAction: TextInputAction.next,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 2,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: Colors.white70,
                hintText: "Enter your Email",
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
                border: const OutlineInputBorder(),
                prefixIcon: Icon(CupertinoIcons.mail_solid),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              textInputAction: TextInputAction.done,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              keyboardType: TextInputType.visiblePassword,
              controller: passwordController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 2,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: Colors.white70,
                hintText: "Enter your Password",
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
                border: const OutlineInputBorder(),
                prefixIcon: Icon(CupertinoIcons.lock_fill),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
