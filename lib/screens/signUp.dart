import 'dart:ffi';

import 'package:coastal_heaven/commons/appColors.dart';
import 'package:coastal_heaven/commons/appfonts.dart';
import 'package:coastal_heaven/commons/pageNavigations.dart';
import 'package:coastal_heaven/components/bottomBar.dart';
import 'package:coastal_heaven/components/button.dart';
import 'package:coastal_heaven/components/customTextField.dart';
import 'package:coastal_heaven/components/label.dart';
import 'package:coastal_heaven/components/snackBar.dart';
import 'package:coastal_heaven/screens/homePage.dart';
import 'package:coastal_heaven/screens/signIn.dart';
import 'package:coastal_heaven/screens/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final passwordController1 = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signUp(BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      SnackbarUtils.showDefaultSnackBar(
          context, "Account create successfully", AppColors.successcolor);
      NavigationUtils.frontNavigation(context, BottomBar());
      // Sign up successful
      // You can navigate to another screen or perform any other actions here
    } catch (e) {
      // Handle specific FirebaseAuthException
      if (e is FirebaseAuthException) {
        print('FirebaseAuthException: ${e.message}');
        // Show error message in a popup dialog
        SnackbarUtils.showDefaultSnackBar(context,
            "Something went wrong & please recheck", AppColors.errorcolor);
      } else {
        // Handle other exceptions
        print('Error: $e');
        // Show generic error message in a popup dialog
        SnackbarUtils.showDefaultSnackBar(context,
            "Something went wrong & please recheck", AppColors.errorcolor);
      }
    }
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
              'assets/signupBG.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            // Scaffold content
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 40.0, right: 40.0, top: 100.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Label(
                          hintText: "Create Your account",
                          textColor: AppColors.themecolor,
                          fontSize: AppFonts.pofilefontsize,
                          fontFamily: AppFonts.titlefont,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.0,
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
                      hintText: 'Password with min 6 digits',
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    MyTextField(
                      obscureText: true,
                      controller: passwordController1,
                      hintText: 'Confirm password',
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Button(
                      onPressed: () {
                        if (passwordController1.text ==
                            passwordController.text) {
                          signUp(context);
                        } else {
                          SnackbarUtils.showDefaultSnackBar(
                              context,
                              "Password & confirm password are not matched",
                              AppColors.errorcolor);
                        }
                        //                        passwordReset();
                        // Add your onPressed logic here
                      },

                      text: 'Create account',
                      buttonColor: AppColors.themecolor,
                      width: 220.0, // Set the button width here
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: 270.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/botline.png'), // Your image path here
                          fit: BoxFit
                              .cover, // You can adjust the fit as per your requirement
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Stack(children: [
                      Button(
                        onPressed: () async {
                          final GoogleSignIn googleSignIn = GoogleSignIn();
                          try {
                            final GoogleSignInAccount? googleSignInAccount =
                                await googleSignIn.signIn();
                            if (googleSignInAccount != null) {
                              final GoogleSignInAuthentication
                                  googleSignInAuthentication =
                                  await googleSignInAccount.authentication;
                              final AuthCredential credential =
                                  GoogleAuthProvider.credential(
                                idToken: googleSignInAuthentication.idToken,
                                accessToken:
                                    googleSignInAuthentication.accessToken,
                              );
                              await FirebaseAuth.instance
                                  .signInWithCredential(credential);
                              NavigationUtils.frontNavigation(
                                  context, BottomBar());
                              print("success");
                            }
                          } catch (e) {
                            SnackbarUtils.showDefaultSnackBar(
                                context,
                                "Something went wrong & please recheck",
                                AppColors.errorcolor);
                          }
                        },

                        text: 'Sign up with Google',
                        buttonColor: AppColors.themecolor,
                        width: 300.0, // Set the button width here
                      ),
                      Positioned(
                        left: 30.0,
                        top: 10.0,
                        child: Container(
                          width: 25.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/google.png'), // Your image path here
                              fit: BoxFit
                                  .cover, // You can adjust the fit as per your requirement
                            ),
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Label(
                          hintText: "Already have an account? ",
                          textColor: AppColors.themecolor,
                          fontSize: AppFonts.paratextsize,
                          fontFamily: AppFonts.titlefont,
                          fontWeight: FontWeight.bold,
                        ),
                        GestureDetector(
                          onTap: () {
                            NavigationUtils.frontNavigation(context, SignIn());
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Label(
                                  hintText: "Sign in",
                                  textColor: AppColors.themecolor,
                                  fontSize: AppFonts.paratextsize,
                                  fontFamily: AppFonts.titlefont,
                                  fontWeight: FontWeight.bold,
                                  shouldUnderline: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
