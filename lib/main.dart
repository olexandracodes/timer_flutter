import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:timer_flutter/data/localizations.dart';
import 'package:timer_flutter/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyB9EQ4LkFdYutKx4baDUIEIJIwu_oe6lf8",
        authDomain: "timer-ip-flutter.firebaseapp.com",
        projectId: "timer-ip-flutter",
        storageBucket: "timer-ip-flutter.appspot.com",
        messagingSenderId: "199670623917",
        appId: "1:199670623917:web:089b0ddae0bc6eda846024"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: HomePage(),
    );
  }
}
