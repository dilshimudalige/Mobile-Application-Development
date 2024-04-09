import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coastal_heaven/commons/appColors.dart';
import 'package:coastal_heaven/commons/appfonts.dart';
import 'package:coastal_heaven/commons/pageNavigations.dart';
import 'package:coastal_heaven/components/chatbox.dart';
import 'package:coastal_heaven/components/customTextField%20copy.dart';
import 'package:coastal_heaven/components/customTextField.dart';
import 'package:coastal_heaven/components/requestCard%20copy.dart';
import 'package:coastal_heaven/components/snackBar.dart';
import 'package:coastal_heaven/screens/myBookings.dart';
import 'package:coastal_heaven/screens/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    return Scaffold(
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
          "Contact Us",
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        color: AppColors.backcolor,
        child: Padding(
          padding: const EdgeInsets.all(38.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Get in Touch",
                  style: TextStyle(
                    color: AppColors.pureblack, // Text color
                    fontSize: AppFonts.pofilefontsize, // Font size
                    height: 1.2,
                    fontWeight: FontWeight.bold, // Font weight
                    fontFamily: AppFonts.titlefont,
                    //fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "If you have any inquaries get in touch with us.We’ll be happy to help you.",
                  style: TextStyle(
                    color: AppColors.pureblack, // Text color
                    fontSize: AppFonts.smalltextsize, // Font size
                    height: 1.2,

                    fontFamily: AppFonts.titlefont,
                    //fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 50.0,
                ),
                GestureDetector(
                  onTap: () async {
                    final Uri url = Uri(
                      scheme: 'tel',
                      path: "+94771060730",
                    );
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      print("Can't launch this url");
                      SnackbarUtils.showDefaultSnackBar(context,
                          "Can't launch this url", AppColors.errorcolor);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: AppColors.buttontextcolor,
                      borderRadius: BorderRadius.circular(
                          30), // Adjust the radius value as needed
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 28.0),
                            child: Icon(
                              Icons.call_outlined, // Icon to display
                              size: 25.0, // Size of the icon
                              color: AppColors.pureblack, // Color of the icon
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 28.0),
                            child: Text(
                              "+94771060730",
                              style: TextStyle(
                                color: AppColors.pureblack, // Text color
                                fontSize: AppFonts.smalltextsize, // Font size

                                fontFamily: AppFonts.titlefont,
                                //fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                GestureDetector(
                  onTap: () async {
                    final Uri emailUri = Uri(
                      scheme: 'mailto',
                      path: "coastalheaven@gmail.com",
                    );
                    if (await canLaunchUrl(emailUri)) {
                      await launchUrl(emailUri);
                    } else {
                      print("Can't launch this url");
                      SnackbarUtils.showDefaultSnackBar(context,
                          "Can't launch this url", AppColors.errorcolor);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: AppColors.buttontextcolor,
                      borderRadius: BorderRadius.circular(
                          30), // Adjust the radius value as needed
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 28.0),
                            child: Icon(
                              Icons.mail_outline, // Icon to display
                              size: 25.0, // Size of the icon
                              color: AppColors.pureblack, // Color of the icon
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 28.0),
                            child: Text(
                              "coastalheaven@gmail.com",
                              style: TextStyle(
                                color: AppColors.pureblack, // Text color
                                fontSize: AppFonts.smalltextsize, // Font size

                                fontFamily: AppFonts.titlefont,
                                //fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                Text(
                  "Social Media",
                  style: TextStyle(
                    color: AppColors.pureblack, // Text color
                    fontSize: AppFonts.popupTitfontsize, // Font size
                    height: 1.2,
                    fontWeight: FontWeight.bold, // Font weight
                    fontFamily: AppFonts.titlefont,
                    //fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: GestureDetector(
                        onTap: () async {
                          final web = Uri.parse('https://www.facebook.com/');
                          launchUrl(
                            web,
                            mode: LaunchMode.inAppWebView,
                          );
                        },
                        child: Container(
                          width: 37, // Adjust width as needed
                          height: 37, // Adjust height as needed
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/fb.png'),
                              fit: BoxFit.cover, // Adjust the fit as needed
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            "Stay updated, connected and engage with",
                            style: TextStyle(
                              color: AppColors.pureblack, // Text color
                              fontSize: AppFonts.midtext, // Font size

                              fontFamily: AppFonts.titlefont,
                              //fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            "us on Facebook.",
                            style: TextStyle(
                              color: AppColors.pureblack, // Text color
                              fontSize: AppFonts.midtext, // Font size

                              fontFamily: AppFonts.titlefont,
                              //fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: GestureDetector(
                        onTap: () async {
                          final web = Uri.parse('https://www.instagram.com/');
                          launchUrl(
                            web,
                            mode: LaunchMode.inAppWebView,
                          );
                        },
                        child: Container(
                          width: 37, // Adjust width as needed
                          height: 37, // Adjust height as needed
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/soc.png'),
                              fit: BoxFit.cover, // Adjust the fit as needed
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            "Explore our visual world and discover",
                            style: TextStyle(
                              color: AppColors.pureblack, // Text color
                              fontSize: AppFonts.midtext, // Font size

                              fontFamily: AppFonts.titlefont,
                              //fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            "beauty of our brand.",
                            style: TextStyle(
                              color: AppColors.pureblack, // Text color
                              fontSize: AppFonts.midtext, // Font size

                              fontFamily: AppFonts.titlefont,
                              //fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
