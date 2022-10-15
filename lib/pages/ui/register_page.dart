import 'package:bloc_weather_api/service/auth/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //loading
  bool _isLoading = false;
  //var _text = '';
  bool _submitted = false;
  @override
  void dispose() {
    _emailController.dispose();
    _confirmEmailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //sign up
  Future<String> signUp() async {
    var result;
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    if (_errorEmailText == null &&
        _errorConfirmEmail == null &&
        _errorPassword == null) {
      result = await AuthService().signUp(
          _emailController.text.trim(), _passwordController.text.trim());
    }
    setState(() => _isLoading = false);
    return result;
  }

  //error email
  String? get _errorEmailText {
    final email = _emailController.text.trim();
    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
    if (emailValid == false) {
      return "Vui lòng nhập địa chỉ email!";
    }
    return null;
  }

  //error confirm mail
  String? get _errorConfirmEmail {
    final email = _emailController.text.trim();
    final emailConfimated = _confirmEmailController.text.trim();
    if (email != emailConfimated) {
      return "email chưa trùng khớp";
    }
    return null;
  }

  //error password
  String? get _errorPassword {
    final password = _passwordController.text.trim();
    if (password.length < 8) {
      return "Mật khẩu phải trên 8 ký tự";
    } else if (password.isEmpty) {
      return "Vui lòng điền mật khẩu!";
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
                    height: 110.0,
                  ),
                  Text(
                    "Weather App",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Xem dự báo thời tiết trên khắp thế giới và theo dõi biến đổi khí hậu",
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 300.0,
          child: Container(
            height: 420.0,
            width: MediaQuery.of(context).size.width - 40,
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18.0),
                border: Border.all(color: Colors.white, width: 1.5),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.38),
                      spreadRadius: 5,
                      blurRadius: 15)
                ]),
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.all(10.0)),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Đăng ký',
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade500)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade500),
                                borderRadius: BorderRadius.circular(25.0)),
                            contentPadding: const EdgeInsets.all(10.0),
                            errorText: _submitted ? _errorEmailText : null,
                            errorBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            hintText: "Email",
                            hintStyle: const TextStyle(fontSize: 14.0)),
                        // onChanged: (text) => setState(() {
                        //   _text;
                        // }),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: _confirmEmailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade500)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade500),
                                borderRadius: BorderRadius.circular(25.0)),
                            contentPadding: const EdgeInsets.all(10.0),
                            errorText: _submitted ? _errorConfirmEmail : null,
                            errorBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            hintText: "Confirm email",
                            hintStyle: const TextStyle(fontSize: 14.0)),
                        // onChanged: (text) => setState(() {
                        //   _text;
                        // }),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        //obscureText: true,
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.password),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade500)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade500),
                                borderRadius: BorderRadius.circular(25.0)),
                            contentPadding: const EdgeInsets.all(10.0),
                            errorBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            errorText: _submitted ? _errorPassword : null,
                            hintText: "Password",
                            hintStyle: const TextStyle(fontSize: 14.0)),
                        // onChanged: (text) => setState(() {
                        //   _text;
                        // }),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.deepPurple.withOpacity(0.7),
                                  spreadRadius: 5,
                                  blurRadius: 15)
                            ]),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : ElevatedButton(
                                onPressed: () async {
                                  final result = await signUp();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        result,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Đăng ký",
                                  style: TextStyle(color: Colors.white),
                                )),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Bạn có chắc chắn việc đăng ký ?"),
                          const SizedBox(
                            width: 5.0,
                          ),
                          GestureDetector(
                            onTap: widget.showLoginPage,
                            child: const Text("Login",
                                style: TextStyle(
                                  color: Colors.blue,
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
