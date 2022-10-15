import 'package:bloc_weather_api/models/google_sign_in.dart';
import 'package:bloc_weather_api/pages/main_page.dart';
import 'package:bloc_weather_api/pages/ui/register_page.dart';
import 'package:bloc_weather_api/pages/ui/splash_page.dart';
import 'package:bloc_weather_api/utils/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            AppRouter.SPLASH: (context) => const SplashPage(),
            AppRouter.AUTH_OR_HOME: (context) => const MainPage()
          },
        ));
  }
}
