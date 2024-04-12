import 'package:coastal_heaven/commons/appColors.dart';
import 'package:coastal_heaven/commons/appfonts.dart';
import 'package:coastal_heaven/commons/pageNavigations.dart';
import 'package:coastal_heaven/components/bottomBar.dart';
import 'package:coastal_heaven/components/button.dart';
import 'package:coastal_heaven/components/customTextField.dart';
import 'package:coastal_heaven/components/label.dart';
import 'package:coastal_heaven/components/snackBar.dart';
import 'package:coastal_heaven/screens/homePage.dart';
import 'package:coastal_heaven/screens/pwReset.dart';
import 'package:coastal_heaven/screens/signUp.dart';
import 'package:coastal_heaven/screens/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signIn(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // Login successful, navigate to the sign-up page
      NavigationUtils.frontNavigation(context, BottomBar());
    } catch (e) {
      // Handle FirebaseAuthException
      if (e is FirebaseAuthException) {
        String errorMessage = 'An error occurred';
        if (e.code == 'firebase_auth/channel-error') {
          errorMessage = 'Unable to establish connection on channel.';
        } else {
          errorMessage = e.message ?? errorMessage;
        }
        // Show error popup
        SnackbarUtils.showDefaultSnackBar(
            context, errorMessage, AppColors.errorcolor);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle the back button press here
        // You can navigate to the previous screen or perform any other action
        NavigationUtils.backNavigation(context,
            Splash()); // This will navigate back to the previous screen
        return false; // Return false to prevent the default back navigation
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Background image
            Image.asset(
              'assets/loginBG.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            // Scaffold content
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 400,
                    color: Colors.transparent,
                  ),
                  Container(
                    height: 400,
                    //height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      color: AppColors.shadowedtextcol,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(
                            40), // Set top-right corner radius here
                      ), // Set border radius here
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 40.0,
                        right: 40.0,
                      ), // Added bottom padding
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .end, // Align children to the bottom
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Content at the top
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Label(
                                    hintText: "Welcome!",
                                    textColor: AppColors.botpadtitcolor,
                                    fontSize: AppFonts.titlesize,
                                    fontFamily: AppFonts.titlefont,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              MyTextField(
                                controller: emailController,
                                hintText: 'Email',
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              MyTextField(
                                obscureText: true,
                                controller: passwordController,
                                hintText: 'Password',
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      NavigationUtils.frontNavigation(
                                          context, pwReset());
                                    },
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Label(
                                            hintText: "Forgot password?",
                                            textColor: AppColors.botpadtitcolor,
                                            fontSize: AppFonts.smalltextsize,
                                            fontFamily: AppFonts.titlefont,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 40.0,
                              ),
                              Button(
                                onPressed: () {
                                  // Add your onPressed logic here
                                  signIn(context);
                                },
                                text: 'Sign in',
                                buttonColor: AppColors.themecolor,
                                width: 220.0, // Set the button width here
                              ),
                              SizedBox(
                                height: 40.0,
                              ),
                            ],
                          ),
                          // Content at the bottom
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
