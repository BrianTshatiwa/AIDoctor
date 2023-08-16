import 'package:app/screens/diagnose_screen.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import './screens/forgotPassword_screen.dart';
import 'screens/login_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/registrationScreen':(context) => RegistrationPage(),
        '/loginScreen': (context) => LoginPage(),
        '/homeScreen': (context) => HomePage(),
        '/diagnoseScreen': (context) => DiagnosePage(),
        '/forgotPasswordScreen':(context) => forgotPasswordScreen(),
      },
      home: Builder(builder: (context) => LoginPage(),),
    );
  }
}