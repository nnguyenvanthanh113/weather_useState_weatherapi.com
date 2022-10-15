import 'package:bloc_weather_api/pages/ui/widgets/login_error.dart';
import 'package:bloc_weather_api/service/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthFirebaseService implements AuthService {
  // User user;
  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Future<String> signUp(String email, String password) async {
    final auth = FirebaseAuth.instance;
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credential.user == null) return 'Không tồn  tại người dùng!';

      await _saveWeatherUser(credential.user?.email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Mật khẩu được cung cấp quá yếu!';
        // errorRegister('Mật khẩu được cung cấp quá yếu!');
      } else if (e.code == 'email-already-in-use') {
        return 'Email đã tồn tại!!';
        //AuthExceptions('The account already exists for that email.');
        // const SnackBar(
        //   backgroundColor: Colors.red,
        //   content: Text(
        //     'Email đã tồn tại!',
        //     style: TextStyle(color: Colors.white),
        //   ),
        // );
        //errorRegister('Email đã tồn tại!');
      } else if (e.code == 'operation-not-allowed') {
        return 'Có một vấn đề với cấu hình dịch vụ!';
        //errorRegister('Có một vấn đề với cấu hình dịch vụ!');
      } else if (e.code == 'weak-password') {
        return 'Vui lòng nhập mật khẩu mạnh hơn';
        //errorRegister('Vui lòng nhập mật khẩu mạnh hơn');
      } else {
        return e.toString();
        // errorRegister(e.toString());
        //rethrow;
      }
    }
    return 'Đã đăng ký thành công!';
  }

  Future<void> _saveWeatherUser(email) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
        .add({'email': email})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    // final store = FirebaseFirestore.instance;

    // final docRef = store.collection('users').doc(user.uid);

    // return docRef.set({
    //   'email': user.email,
    // });
  }

  @override
  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
