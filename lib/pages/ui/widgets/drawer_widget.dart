import 'package:bloc_weather_api/utils/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({Key? key}) : super(key: key);
  final String? userName = FirebaseAuth.instance.currentUser?.email;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      elevation: 2.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: Column(
        children: [
          AppBar(
            title: Text('' + userName.toString()),
            backgroundColor: Colors.deepPurple,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.sunny),
            iconColor: Color.fromARGB(255, 207, 188, 15),
            title: const Text('Trang chủ'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(AppRouter.WEATHER_DETAIL),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            iconColor: Colors.blue,
            title: const Text('Đăng xuất'),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushReplacementNamed(AppRouter.AUTH_OR_HOME);
            },
          ),
        ],
      ),
    );
  }
}
