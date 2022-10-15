import 'dart:io';

import 'package:bloc_weather_api/service/auth/auth_service_firebase.dart';

abstract class AuthService {
  Future<String> signUp(
    String email,
    String password,
  );

  Future<void> login(
    String email,
    String password,
  );
  Future<void> resetPassword(String email);

  Future<void> logout();

  factory AuthService() {
    return AuthFirebaseService();
  }
}
