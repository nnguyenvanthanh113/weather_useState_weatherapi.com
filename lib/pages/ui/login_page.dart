import 'dart:io';

import 'package:bloc_weather_api/models/google_sign_in.dart';
import 'package:bloc_weather_api/pages/ui/forgot_password_page.dart';
import 'package:bloc_weather_api/pages/ui/widgets/login_error.dart';
import 'package:bloc_weather_api/service/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _submitted = false;
  bool seePassword = true;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });

    if (_errorEmailText == null && _errorPasswordText == null) {
      try {
        await AuthService().login(
            _emailController.text.trim(), _passwordController.text.trim());
        if (UserCredential != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                "Login thanh cong!",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      } catch (e) {
        // print('loi e:' + e.toString());
        // String error = e.toString().replaceRange(0, 14, '').split(']')[1];
        // print('error e:' + error.toString());
        final endIndex = e.toString().indexOf("]", 0);
        String error = e.toString().substring(endIndex + 2);
        if (Platform.isAndroid) {
          switch (error) {
            case 'There is no user record corresponding to this identifier. The user may have been deleted.':
              errorLogin(context, widget, 'User không tồn tại!');
              break;
            case 'The password is invalid or the user does not have a password.':
              errorLogin(context, widget, 'Mật khẩu không chính xác!');
              break;
            case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
              errorLogin(context, widget, 'Vui lòng kiểm tra lại internet!');
              break;
            // // ...
            // default:
            //   errorLogin(context, widget, 'Đã xảy ra lỗi!');
          }
        } else if (Platform.isIOS) {
          switch (error) {
            case 'Error 17011':
              errorLogin(context, widget, 'User không tồn tại!');
              break;
            case 'Error 17009':
              errorLogin(context, widget, 'Mật khẩu không chính xác!');
              break;
            case 'Error 17020':
              errorLogin(context, widget, 'Vui lòng kiểm tra lại internet!');
              break;
            default:
              errorLogin(context, widget, 'Đã xảy ra lỗi!');
          }
        }
        // print('The error is $error');
      }
    }
    setState(() => _isLoading = false);
  }

  String? get _errorEmailText {
    final email = _emailController.text.trim();
    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);

    if (emailValid == false) {
      return "Kiểm tra lại email!";
    }
    return null;
  }

  String? get _errorPasswordText {
    final text = _passwordController.text.trim();
    if (text.isEmpty) {
      return 'Vui lòng điền mật khẩu!';
    }
    if (text.length < 8) {
      return 'Mật khẩu bao gồm trên 8 ký tự!';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 530,
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.deepPurple),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Weather App",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Xem dự báo thời tiết trên khắp thế giới và theo dõi biến đổi khí hậu",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 200,
            child: Container(
              height: 450,
              width: MediaQuery.of(context).size.width - 40,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.white, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.38),
                      spreadRadius: 5,
                      blurRadius: 15,
                    )
                  ]),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Đăng nhập",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _emailController,
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            errorText: _submitted ? _errorEmailText : null,
                            prefixIcon: const Icon(Icons.email),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade500),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade500),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            hintText: "E-mail",
                            hintStyle: const TextStyle(fontSize: 14)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: seePassword ? true : false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          errorText: _submitted ? _errorPasswordText : null,
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                            icon: Icon(
                              seePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              setState(() {
                                seePassword = !seePassword;
                              });
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade500),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade500),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          hintText: "mật khẩu",
                          hintStyle: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const ForgotPasswordPage();
                            }));
                          },
                          child: Text("Quên mật khẩu ?",
                              style: TextStyle(
                                  color: Colors.blue[500],
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurple.withOpacity(0.7),
                            spreadRadius: 5,
                            blurRadius: 15,
                          )
                        ]),
                    child: _isLoading
                        ? const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white))
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurple,
                            ),
                            onPressed: () {
                              signIn();
                            }, //signIn,
                            child: GestureDetector(
                              child: const Text("Login",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Bạn chưa có tài khoản ?"),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: widget.showRegisterPage,
                        child: const Text(
                          "Đăng ký ngay",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 250,
                    child: ElevatedButton.icon(
                        icon: const FaIcon(FontAwesomeIcons.google,
                            color: Colors.red),
                        onPressed: () {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.googleLogin();
                        },
                        label: const Text("Đăng ký với Gmail",
                            style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.yellow,
                            minimumSize: const Size(double.infinity, 50))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
