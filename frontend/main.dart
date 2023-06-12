import 'package:flutter/material.dart';
import 'package:devpara/screens/splash.dart';
import 'package:devpara/screens/home.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:devpara/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(home: Splash());
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "testRandomData",
      initialRoute: '/home',
      routes: {
        '/': (context) => const Splash(),
        '/home': (context) => const Home(),
        // '/user': (context) => const UserProfile(),
      },
    );
  }
}