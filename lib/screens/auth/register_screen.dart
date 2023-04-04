import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:restaurantapp/api/config.dart';
import 'package:restaurantapp/api/models/user_model.dart';
import 'package:restaurantapp/screens/auth/continue_register_screen.dart';
import 'package:restaurantapp/widgets/custom_button.dart';
import 'package:restaurantapp/widgets/custom_container.dart';
import 'package:restaurantapp/widgets/text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String usernameErrMsg = "";
  String emailErrMsg = "";
  String passwordErrMsg = "";
  String user_type = 'R';
  late UserRegister model;
  final LocalStorage tokens = LocalStorage('tokens');

  registerUser(data) async {
    try {
      var url = Uri.parse(ApiConstants.BASE_URL + ApiConstants.USER_REGISTER);
      var response = await http.post(url, body: data);
      loginUser(data['username'], data['password']);
      if (response.statusCode == 201) {
        setState(() {
          this.model = userRegisterFromJson(response.body);
          print("USER_ID : ${model.id}");
          setState(() {
            usernameErrMsg = "";
            emailErrMsg = "";
            passwordErrMsg = "";
          });

          // loginUser(data['username'], data['password']);
          loginUser(model.username, model.password);
        });
      } else {
        // print(jsonDecode(response.body)['password'][0]);

        setState(() {
          usernameErrMsg = (jsonDecode(response.body)['username'] != null)
              ? jsonDecode(response.body)['username'][0]
              : "";
          emailErrMsg = (jsonDecode(response.body)['email'] != null)
              ? jsonDecode(response.body)['email'][0]
              : "";
          passwordErrMsg = (jsonDecode(response.body)['password'] != null)
              ? jsonDecode(response.body)['password'][0]
              : "";
          // passwordErrMsg = (jsonDecode(response.body)['user_type'] != null)
          //     ? jsonDecode(response.body)['user_type'][0]
          //     : "";
        });
      }
    } catch (e) {
      print(e);
    }
  }

  loginUser(String username, String password) async {
    tokens.clear();
    var data = {"username": username, "password": password};
    try {
      var url = Uri.parse(ApiConstants.BASE_URL + ApiConstants.USER_LOGIN);
      var response = await http.post(url, body: data);
      if (response.statusCode == 200) {
        setState(() {
          UserLogin model = userLoginFromJson(response.body);

          tokens.setItem('access', model.access);
          tokens.setItem('refresh', model.refresh);

          print("LOGIN SUCCESS : ${model.access}");

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ContinueRegister(),
            ),
          );
        });
      } else {
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

    return Container(
        width: width,
        height: height,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 235, 235, 235),
          resizeToAvoidBottomInset: false, //new line

          body: Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/login.jpg"),
                  fit: BoxFit.cover,
                  opacity: 0.9,
                ),
              ),
              child: Center(
                child: CustomContainer(
                  padding: const EdgeInsets.all(15),
                  width: width - 50,
                  height: 380,
                  color: Colors.white,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 232, 192, 239),
                        Color.fromARGB(255, 185, 222, 237),
                      ],
                    ),
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: const BoxDecoration(),
                            padding: const EdgeInsets.only(top: 1, bottom: 15),
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
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
                            child: TextFormField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 235, 235, 235),
                                prefixIcon: Icon(Icons.person),
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 2, 10, 2),
                                border: InputBorder.none,
                                labelText: 'Username',
                              ),
                            ),
                          ),
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
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 235, 235, 235),
                                prefixIcon: Icon(Icons.email),
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 2, 10, 2),
                                border: InputBorder.none,
                                labelText: 'Email',
                              ),
                            ),
                          ),
                          Text(
                            emailErrMsg,
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
                            child: TextField(
                              obscuringCharacter: '*',
                              obscureText: showPassword ? false : true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 235, 235, 235),
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
                                    EdgeInsets.fromLTRB(10, 2, 10, 2),
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
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            height: 35,
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final username = nameController.text;
                                  final email = emailController.text;
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

                                  if (email == '') {
                                    setState(() {
                                      emailErrMsg = "Emails can not be empty";
                                    });
                                  } else {
                                    setState(() {
                                      emailErrMsg = "";
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
                                  if (username != '' &&
                                      email != '' &&
                                      password != '') {
                                    registerUser({
                                      "username": username,
                                      "email": email,
                                      "password": password,
                                      "user_type": user_type,
                                    });
                                  }
                                }
                              },
                              child: const Text(
                                'Register',
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text("Already have an account?"),
                              TextButton(
                                onPressed: () {
                                  // already have an account
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 18,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              )),
        ));
  }
}
