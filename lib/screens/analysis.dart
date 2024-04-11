import 'package:coastal_heaven/commons/appColors.dart';
import 'package:coastal_heaven/commons/appfonts.dart';
import 'package:coastal_heaven/commons/pageNavigations.dart';
import 'package:coastal_heaven/components/bottomBar.dart';
import 'package:coastal_heaven/components/snackBar.dart';
import 'package:coastal_heaven/screens/myBookings.dart';
import 'package:coastal_heaven/screens/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_chart/commons/data_model.dart';
import 'package:d_chart/ordinal/bar.dart';

class Analysis extends StatefulWidget {
  const Analysis({Key? key}) : super(key: key);

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  final streamChart = FirebaseFirestore.instance
      .collection("placerate")
      .snapshots(includeMetadataChanges: true);
  final streamChart1 = FirebaseFirestore.instance
      .collection("activityrate")
      .snapshots(includeMetadataChanges: true);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle the back button press here
        // You can navigate to the previous screen or perform any other action
        NavigationUtils.backNavigation(context,
            BottomBar()); // This will navigate back to the previous screen
        return false; // Return false to prevent the default back navigation
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
            "Reviews",
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
                  print("Sign out error: $e");
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
          child: Container(
            color: AppColors.backcolor,
            child: Column(
              children: [
                SizedBox(
                  height: 28.0,
                ),
                Text(
                  "Where and what is the best?",
                  style: TextStyle(
                    color: AppColors.pureblack, // Text color
                    fontSize: AppFonts.pofilefontsize, // Text size
                    fontWeight: FontWeight.bold, // Text weight
                    fontFamily: AppFonts.btcardfont,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: StreamBuilder(
                        stream: streamChart,
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          }
                          List<OrdinalData> chartData = snapshot.data!.docs.map(
                              (DocumentSnapshot<Map<String, dynamic>> doc) {
                            return OrdinalData(
                              domain: doc.data()!['place'] ?? '',
                              measure: doc.data()!['rate'] ?? 0,
                            );
                          }).toList();
                          return DChartBarO(
                            groupList: [
                              OrdinalGroup(
                                id: '1',
                                data: chartData,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                AspectRatio(
                  aspectRatio: 26 / 9,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: StreamBuilder(
                      stream: streamChart,
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        }
                        List<Map<String, dynamic>> domainDescriptions = snapshot
                            .data!.docs
                            .map<Map<String, dynamic>>(
                                (DocumentSnapshot<Map<String, dynamic>> doc) =>
                                    {
                                      'domain': doc.data()!['place'] ?? '',
                                      'description':
                                          doc.data()!['description'] ?? '',
                                    })
                            .toList();
                        return Scrollbar(
                          trackVisibility: true,
                          child: ListView.builder(
                            itemCount: domainDescriptions.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  '${domainDescriptions[index]['domain']} - ${domainDescriptions[index]['description']}',
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: StreamBuilder(
                        stream: streamChart1,
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          }
                          List<OrdinalData> chartData = snapshot.data!.docs.map(
                              (DocumentSnapshot<Map<String, dynamic>> doc) {
                            return OrdinalData(
                              domain: doc.data()!['activity'] ?? '',
                              measure: doc.data()!['rate'] ?? 0,
                            );
                          }).toList();
                          return DChartBarO(
                            groupList: [
                              OrdinalGroup(
                                id: '1',
                                data: chartData,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                AspectRatio(
                  aspectRatio: 26 / 9,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: StreamBuilder(
                      stream: streamChart1,
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        }
                        List<Map<String, dynamic>> domainDescriptions = snapshot
                            .data!.docs
                            .map<Map<String, dynamic>>(
                                (DocumentSnapshot<Map<String, dynamic>> doc) =>
                                    {
                                      'domain': doc.data()!['activity'] ?? '',
                                      'description':
                                          doc.data()!['description'] ?? '',
                                    })
                            .toList();
                        return Scrollbar(
                          trackVisibility: true,
                          child: ListView.builder(
                            itemCount: domainDescriptions.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  '${domainDescriptions[index]['domain']} - ${domainDescriptions[index]['description']}',
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
