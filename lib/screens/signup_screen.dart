import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoppie_app/utils/constants.dart';
import 'package:shoppie_app/utils/utils.dart';

import '../../resources/authentication_method.dart';
import '../../widgets/custom_main_button.dart';
import '../../widgets/text_field;.dart';

import '../utils/color_themes.dart';
import 'signin_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    addressController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    shoppieLogo2,
                    height: screenSize.height * 0.10,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.7,
                    child: FittedBox(
                      child: Container(
                        height: screenSize.height * 0.7,
                        width: screenSize.width * 0.9,
                        padding: EdgeInsets.all(25),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 3),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sign-In",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 33,
                                  color: Colors.grey.shade500),
                            ),
                            TextFieldWidget(
                                hintText: 'Enter Nmae',
                                title: 'Name',
                                controller: nameController,
                                obscureText: false),
                            TextFieldWidget(
                                hintText: 'Enter Address',
                                title: 'Address',
                                controller: addressController,
                                obscureText: false),
                            TextFieldWidget(
                                hintText: 'Enter Email',
                                title: 'Email',
                                controller: emailController,
                                obscureText: false),
                            TextFieldWidget(
                                hintText: 'Enter Password',
                                title: 'Password',
                                controller: passwordController,
                                obscureText: true),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: CustomMainButton(
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        letterSpacing: 0.6,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  color: activeCyanColor,
                                  isLoading: isLoading,
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    String output =
                                        await authenticationMethods.signUpUser(
                                            name: nameController.text,
                                            address: addressController.text,
                                            email: emailController.text,
                                            password: passwordController.text);
                                    setState(() {
                                      isLoading = false;
                                    });

                                    if (output == "success") {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => SigninScreen()));
                                    } else {
                                      Utils().showSnackBar(
                                          context: context, content: output);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.5,
                    child: CustomMainButton(
                      child: Text('Back'),
                      color: Colors.green.shade600,
                      isLoading: false,
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return SigninScreen();
                        }));
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
