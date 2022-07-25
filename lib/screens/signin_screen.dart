import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoppie_app/resources/authentication_method.dart';
import 'package:shoppie_app/screens/home_screen.dart';
import 'package:shoppie_app/utils/color_themes.dart';
import 'package:shoppie_app/utils/constants.dart';
import 'signup_screen.dart';
import 'package:shoppie_app/utils/utils.dart';
import 'package:shoppie_app/widgets/custom_main_button.dart';
import 'package:shoppie_app/widgets/text_field;.dart';

class SigninScreen extends StatefulWidget {
  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  bool isLoading = false;
  @override
  void dispose() {
    super.dispose();
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
                    shoppieLogo,
                    height: screenSize.height * 0.10,
                  ),
                  Container(
                    height: screenSize.height * 0.6,
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
                          child: CustomMainButton(
                            child: Text(
                              'Sign in',
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
                              Future.delayed(Duration(seconds: 1));
                              String output =
                                  await authenticationMethods.signInUser(
                                      email: emailController.text,
                                      password: passwordController.text);
                              setState(() {
                                isLoading = false;
                              });

                              if (output == 'success') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              } else {
                                Utils().showSnackBar(
                                    context: context, content: output);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'New to shoppie!',
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 18),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  CustomMainButton(
                    child: Text('Create New Account!'),
                    color: Colors.green.shade600,
                    isLoading: false,
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return SignupScreen();
                      }));
                    },
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
