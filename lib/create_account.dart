
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_upload_firebase_flutter/login_screen.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> createaccount() async {

    await FirebaseAuth.instance.createUserWithEmailAndPassword( //create er ta use korar karon e ekon data firebase e jaibo
      email: emailController.text,
      password: passwordController.text,
    ).then((value) { //jdi success  hoy
      Get.showSnackbar(
          GetSnackBar(
            message: 'Create Successful',
            title: 'Create Success',
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,

          ));
      Get.to(LoginScreen());

    }).onError((error, stackTrace) { //jdi fail hoy //that mean data firebase e send hoy nai
      Get.showSnackbar(
          GetSnackBar(
            message: error.toString(),
            title: 'Create Failed',
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,

          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
        centerTitle: true,
      ), // AppBar

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.green)
                          ) // OutlineInputBorder
                      ) // InputDecoration
                  ), // TextFormField


                  SizedBox(height: 10),


                  TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.green)
                          ) // OutlineInputBorder
                      ) // InputDecoration
                  ), // TextFormField

                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        createaccount();
                      }
                    },

                    child: Text('Create Account'),

                  ), // ElevatedButton




                ],
              ),
            ), // Column
          ), // Center
        ), // Padding
      ), // SafeArea
    ); // Scaffold
  }
}