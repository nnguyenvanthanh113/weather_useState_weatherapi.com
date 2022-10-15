enum AuthMode { SignUp, Login }

class AuthFormData {
  String name = '';
  String email = '';
  String password = '';
  AuthMode _mode = AuthMode.Login;

  bool get isLogin {
    return _mode == AuthMode.Login;
  }

  bool get isSignUp {
    return _mode == AuthMode.SignUp;
  }

  toggleAuthMode() {
    _mode = isLogin ? AuthMode.Login : AuthMode.SignUp;
  }
}
