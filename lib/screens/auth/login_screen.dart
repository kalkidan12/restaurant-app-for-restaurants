import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:restaurantapp/api/config.dart';
import 'package:restaurantapp/api/models/user_model.dart';
import 'package:restaurantapp/api/service/api_service.dart';
import 'package:restaurantapp/screens/auth/register_screen.dart';
import 'package:restaurantapp/screens/home/home_page.dart';
import 'package:restaurantapp/widgets/app_bar_for_auth.dart';
import 'package:restaurantapp/widgets/custom_button.dart';
import 'package:restaurantapp/widgets/custom_container.dart';
import 'package:restaurantapp/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String usernameErrMsg = "";
  String passwordErrMsg = "";
  UserLogin model = UserLogin(refresh: "", access: "");
  final LocalStorage tokens = LocalStorage('tokens');

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    passwordController.dispose();
  }

  loginUser(data) async {
    tokens.clear();
    try {
      var url = Uri.parse("${ApiConstants.BASE_URL}${ApiConstants.USER_LOGIN}");
      // print(url);
      // print(data);
      var response = await http.post(url, body: data);
      print(response);
      if (response.statusCode == 200) {
        setState(() {
          this.model = userLoginFromJson(response.body);
          print(model.access);
          setState(() {
            usernameErrMsg = "";
            passwordErrMsg = "";
          });
          tokens.setItem('access', model.access);
          tokens.setItem('refresh', model.refresh);
        });

        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        // debugPrint(response.body);
        print(jsonDecode(response.body));

        setState(() {
          passwordErrMsg = jsonDecode(response.body)['detail'];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Form(
      child: SizedBox(
          width: width,
          height: height,
          child: Scaffold(
              backgroundColor: const Color.fromARGB(255, 235, 235, 235),
              resizeToAvoidBottomInset: false, //new line

              body: Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/login2.jpg"),
                      fit: BoxFit.cover,
                      opacity: 0.8,
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 232, 192, 239),
                        Color.fromARGB(255, 185, 222, 237),
                      ],
                    ),
                  ),
                  child: Center(
                    child: CustomContainer(
                      padding: const EdgeInsets.all(20),
                      width: width - 50,
                      height: 350,
                      color: const Color.fromARGB(255, 255, 249, 249),
                      decoration: const BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Color(0xffeeeeee),
                            blurRadius: 10,
                            offset: Offset(0, 4))
                      ]),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                      child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: const BoxDecoration(),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0xffeeeeee),
                                          blurRadius: 10,
                                          offset: Offset(0, 4))
                                    ]),
                                margin:
                                    const EdgeInsetsDirectional.only(top: 20),
                                child: TextFormField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(255, 235, 235, 235),
                                    prefixIcon: Icon(Icons.person),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 2, 10, 2),
                                    border: InputBorder.none,
                                    labelText: 'Username',
                                  ),
                                ),
                              ),

                              // Container(

                              Text(
                                usernameErrMsg,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: .8,
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0xffeeeeee),
                                          blurRadius: 10,
                                          offset: Offset(0, 4))
                                    ]),
                                margin:
                                    const EdgeInsetsDirectional.only(top: 10),
                                child: TextFormField(
                                  obscuringCharacter: '*',
                                  obscureText: showPassword ? false : true,
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        255, 235, 235, 235),
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            showPassword = !showPassword;
                                          });
                                        },
                                        icon: Icon(
                                          showPassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        )),
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(10, 2, 10, 2),
                                    border: InputBorder.none,
                                    labelText: 'Password',
                                  ),
                                ),
                              ),
                              Text(
                                passwordErrMsg,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: .8,
                                ),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             ResetPassword()));
                                },
                                child: const Text(
                                  "Forgot Pasword?",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                width: 135,
                                height: 35,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      final username = nameController.text;
                                      final password = passwordController.text;

                                      if (username == '') {
                                        setState(() {
                                          usernameErrMsg =
                                              "Username can not be empty";
                                        });
                                      } else {
                                        setState(() {
                                          usernameErrMsg = "";
                                        });
                                      }
                                      if (password == '') {
                                        setState(() {
                                          passwordErrMsg =
                                              "Password can not be empty";
                                        });
                                      } else {
                                        setState(() {
                                          passwordErrMsg = "";
                                        });
                                      }
                                      if (username != '' && password != '') {
                                        loginUser({
                                          "username": username,
                                          "password": password
                                        });
                                      }
                                    }
                                  },
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // register screen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Create new account",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          )),
                    ),
                  )))),
    );
  }
}
