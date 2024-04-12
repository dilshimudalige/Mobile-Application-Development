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
import 'package:coastal_heaven/screens/signUp.dart';
import 'package:coastal_heaven/screens/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class pwReset extends StatefulWidget {
  const pwReset({super.key});

  @override
  State<pwReset> createState() => _pwResetState();
}

class _pwResetState extends State<pwReset> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      NavigationUtils.frontNavigation(context, SignIn());
      SnackbarUtils.showDefaultSnackBar(
          context,
          "We have sent password reset link to the mail",
          AppColors.successcolor);
    } on FirebaseAuthException catch (e) {
      SnackbarUtils.showDefaultSnackBar(context,
          "Something went wrong & please recheck", AppColors.errorcolor);
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
            SignIn()); // This will navigate back to the previous screen
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
                    height: MediaQuery.of(context).size.height - 300,
                    color: Colors.transparent,
                  ),
                  Container(
                    height: 300,
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
                                    hintText: "Forgot password?",
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
                                height: 15.0,
                              ),
                              SizedBox(
                                height: 40.0,
                              ),
                              Button(
                                onPressed: () {
                                  // Add your onPressed logic here
                                  passwordReset();
                                },
                                text: 'Verify',
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
