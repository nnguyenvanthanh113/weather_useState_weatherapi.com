import 'package:bloc_weather_api/service/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  Future<void> resetPassword() async {
    try {
      await AuthService().resetPassword(_emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("lien ket thay đổi password đã dc gởi đi"),
            );
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(backgroundColor: Colors.deepPurple),
      body: Column(
        children: [
          const SizedBox(
            height: 30.0,
          ),
          const Text("Nhập email của bạn và chúng tôi sẽ gửi ",
              textAlign: TextAlign.center),
          const Text("một liên kết đến email của bạn!",
              textAlign: TextAlign.center),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
            child: TextField(
              controller: _emailController,
              obscureText: false,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500),
                    borderRadius: BorderRadius.circular(25.0)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade500),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                contentPadding: const EdgeInsets.all(10.0),
                hintText: "điền email cần xác nhận...",
                hintStyle: const TextStyle(fontSize: 14.0),
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
              onPressed: () {
                resetPassword();
              },
              child: const Text('Đổi mật khẩu'))
        ],
      ),
    );
  }
}
