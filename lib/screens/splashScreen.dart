import 'package:coastal_heaven/commons/appColors.dart';
import 'package:coastal_heaven/commons/appfonts.dart';
import 'package:coastal_heaven/commons/pageNavigations.dart';
import 'package:coastal_heaven/components/button.dart';
import 'package:coastal_heaven/components/label.dart';
import 'package:coastal_heaven/screens/signIn.dart';
import 'package:coastal_heaven/screens/signUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Background image
            Image.asset(
              'assets/startbg.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            // Scaffold content
            Padding(
              padding:
                  const EdgeInsets.only(left: 40.0, right: 40.0, top: 100.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Label(
                    hintText: "Explore and ",
                    textColor: AppColors.pureblack,
                    fontSize: AppFonts.largeheadingsize,
                    fontFamily: AppFonts.titlefont,
                    fontWeight: FontWeight.bold,
                  ),
                  Label(
                    hintText: "Discover new places",
                    textColor: AppColors.pureblack,
                    fontSize: AppFonts.largeheadingsize,
                    fontFamily: AppFonts.titlefont,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Label(
                    hintText: "Browse a lot of interesting tourist",
                    textColor: AppColors.pureblack,
                    fontSize: AppFonts.paratextsize,
                    fontFamily: AppFonts.titlefont,
                    fontWeight: FontWeight.normal,
                  ),
                  Label(
                    hintText: "destinations and choose something for",
                    textColor: AppColors.pureblack,
                    fontSize: AppFonts.paratextsize,
                    fontFamily: AppFonts.titlefont,
                    fontWeight: FontWeight.normal,
                  ),
                  Label(
                    hintText: "yourself. The world is waiting!",
                    textColor: AppColors.pureblack,
                    fontSize: AppFonts.paratextsize,
                    fontFamily: AppFonts.titlefont,
                    fontWeight: FontWeight.normal,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Button(
                    onPressed: () {
                      NavigationUtils.frontNavigation(context, SignIn());
                    },
                    text: 'Sign in',
                    buttonColor: AppColors.themecolor,
                    width: 220.0, // Set the button width here
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      NavigationUtils.frontNavigation(context, SignUp());
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Label(
                            hintText: "Create an account",
                            textColor: AppColors.pureblack,
                            fontSize: AppFonts.paratextsize,
                            fontFamily: AppFonts.titlefont,
                            fontWeight: FontWeight.normal,
                            shouldUnderline: true,
                          ),
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
