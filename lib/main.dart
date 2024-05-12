import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:timer_flutter/data/localizations.dart';
import 'package:timer_flutter/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCTOGyAABOAUI0NnoClAcHOtuRB_THzgQE",
      authDomain: "timer-45eb5.firebaseapp.com",
      databaseURL: "https://timer-45eb5-default-rtdb.europe-west1.firebasedatabase.app",
      projectId: "timer-45eb5",
      storageBucket: "timer-45eb5.appspot.com",
      messagingSenderId: "898156769425",
      appId: "1:898156769425:web:40dfedda512e5067708f30",
    ),
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
