import 'package:bloc_weather_api/pages/auth_page.dart';
import 'package:bloc_weather_api/pages/ui/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          print('homepage');
          return const HomePage();
        } else {
          print('authpage');
          return const AuthPage();
        }
      }),
    ));
  }
}
