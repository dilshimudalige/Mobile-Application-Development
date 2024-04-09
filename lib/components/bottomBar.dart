import 'package:coastal_heaven/commons/appColors.dart';
import 'package:coastal_heaven/screens/analysis.dart';
import 'package:coastal_heaven/screens/contactUs.dart';
import 'package:coastal_heaven/screens/dashboard.dart';
import 'package:coastal_heaven/screens/feedbackScreen.dart';
import 'package:coastal_heaven/screens/homePage.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    const Dashboard(),
    const Analysis(),
    const ContactUs(),
    const FeedbackScreen(),
  ];

  Future<void> _onItemTapped(int index) async {
    //final myModel = Provider.of<MyModel>(context, listen: false);
    if (index == 6) {
      /*setState(() {
        _selectedIndex = index;
      });*/
      // Navigate to logout page
      /*final myModel = Provider.of<MyModel>(context, listen: false);

      myModel.password = '';
      myModel.email = '';
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('username', '');
      prefs.setString('password', '');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => logIn()),
      );*/
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: AppColors.botbarcolor,
            icon: Icon(Icons.home_outlined,
                color: _selectedIndex == 0
                    ? AppColors.buttontextcolor
                    : AppColors.pureblack),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined,
                color: _selectedIndex == 1
                    ? AppColors.buttontextcolor
                    : AppColors.pureblack),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined,
                color: _selectedIndex == 2
                    ? AppColors.buttontextcolor
                    : AppColors.pureblack),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_outlined,
                color: _selectedIndex == 3
                    ? AppColors.buttontextcolor
                    : AppColors.pureblack),
            label: 'Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback_outlined,
                //Icons.dark_mode_outlined
                color: _selectedIndex == 4
                    ? AppColors.buttontextcolor
                    : AppColors.pureblack),
            label: 'Mode',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.themecolor,
        onTap: _onItemTapped,
        showSelectedLabels: false, // hide labels for selected items
        showUnselectedLabels: false, // hide labels for unselected items
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Profile Page'),
    );
  }
}

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Message Page'),
    );
  }
}

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Book Page'),
    );
  }
}

class ModePage extends StatelessWidget {
  const ModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Mode Page'),
    );
  }
}
