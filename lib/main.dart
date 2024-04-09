import 'package:coastal_heaven/firebase_options.dart';
import 'package:coastal_heaven/services/mainPage.dart';
import 'package:coastal_heaven/screens/splashScreen.dart';
import 'package:coastal_heaven/services/provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
  await Firebase
      .initializeApp(); // Initialize Firebase without specifying options
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyModel(), // Provide an instance of your model
      child: DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MyApp(), // Wrap MyApp
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
