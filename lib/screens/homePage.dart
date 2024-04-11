import 'package:coastal_heaven/commons/appColors.dart';
import 'package:coastal_heaven/commons/appfonts.dart';
import 'package:coastal_heaven/commons/pageNavigations.dart';
import 'package:coastal_heaven/components/snackBar.dart';
import 'package:coastal_heaven/screens/myBookings.dart';
import 'package:coastal_heaven/screens/signIn.dart';
import 'package:coastal_heaven/screens/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: GestureDetector(
              onTap: () {
                NavigationUtils.frontNavigation(context, myBookings());
              },
              child: Icon(
                Icons.account_circle,
                size: 30,
                color: AppColors.buttontextcolor,
              ),
            ),
          ),
          title: Text(
            "Home",
            style: TextStyle(
              color: AppColors.buttontextcolor,
              fontSize: AppFonts.popupTitfontsize,
              fontFamily: AppFonts.titlefont,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  // Sign out successful, navigate to the login page
                  NavigationUtils.backNavigation(
                      context, Splash()); // Navigate to the login page
                } catch (e) {
                  // Handle sign-out errors
                  SnackbarUtils.showDefaultSnackBar(
                      context,
                      "Something went wrong & please recheck",
                      AppColors.errorcolor);
                  // Show error message if needed
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Icon(
                  Icons.logout_outlined,
                  size: 30,
                  color: AppColors.buttontextcolor,
                ),
              ),
            ),
          ],
          backgroundColor: AppColors.appbarcolor,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Stack(children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/conback.png'),
                    fit: BoxFit.cover, // Adjust the fit as needed
                  ),
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      //color: Colors.amber,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Center(
                          child: Text(
                        "Welcome to Coastal Heaven!",
                        style: TextStyle(
                          color: AppColors.pureblack, // Text color
                          fontSize: AppFonts.largeheadingsize, // Font size
                          height: 1.2,
                          fontWeight: FontWeight.bold, // Font weight
                          fontFamily: AppFonts.mainfont,
                          //fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      //color: Colors.amber,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Center(
                          child: Text(
                        "Welcome to Coastal Heaven, your ultimate destination for coastal getaways! Discover stunning beaches, picturesque seaside towns, and hidden games along the coast with our user-friendly app. Plan your next beach vacation, explore top attractions, and view accommodations effortlessly. Your coastal paradise awaits!",
                        style: TextStyle(
                          color: AppColors.pureblack, // Text color
                          fontSize: AppFonts.Ctitlesize, // Font size
                          height: 1.5,

                          fontFamily: AppFonts.titlefont,
                          //fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      )),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 70,
                left: 40,
                child: GestureDetector(
                  onTap: () async {},
                  child: Container(
                    width: 70, // Adjust width as needed
                    height: 70, // Adjust height as needed
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/logoOrigin.png'),
                        fit: BoxFit.cover, // Adjust the fit as needed
                      ),
                    ),
                  ),
                ),
              )
            ])
          ]),
        ),
      ),
    );
  }
}
