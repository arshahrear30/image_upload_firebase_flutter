import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_upload_firebase_flutter/create_account.dart';

import 'image_view_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  XFile? pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login'), centerTitle: true), // AppBar

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    pickedImage = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                    );

                    await _firebaseStorage
                        .ref('batch4')
                        .child(DateTime.now().microsecondsSinceEpoch.toString()) //eta deyar karon e prottekta image er unique name thakbey .
                        .putFile(
                          File(pickedImage!.path))
                                    //firebase storage er vitor domain hosting er moto folder acey ..
                                    //batch4 folder create korlam..image1  folder create korlam..
                                    // pickedImage path e add koira dew...eibabey firebase e put kora hoy
                         .then((value) {
                          Get.showSnackbar(const GetSnackBar(
                            message: 'Success',
                            title: 'Image uploaded',
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.green,
                          )); // GetSnackBar
                        }).onError((error, stackTrace) {
                          Get.showSnackbar(const GetSnackBar(
                            message: 'Failed',
                            title: 'Try again',
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.red,
                          )); // GetSnackBar
                        });
                  },
                  child: Text('Pick a image'),
                ), // ElevatedButton
                ElevatedButton(onPressed: (){
                  Get.to(ImageScreen());
                }, child: Text('Next Screen'))
                
              ],
            ),
          ), // Center
        ), // Padding
      ), // SafeArea
    ); // Scaffold
  }
}
