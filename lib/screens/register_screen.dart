import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:restaurantapp/screens/continue_register_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Container(
        width: width,
        height: height,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 235, 235, 235),
          resizeToAvoidBottomInset: false, //new line

          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              centerTitle: false,
              title: const Text(
                'Fast Track | Restaurant',
                style: TextStyle(color: Colors.black),
              )),
          body: Stack(
            children: [
              Container(
                height: height / 2 - 50,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg_banner.jpg"),
                    fit: BoxFit.cover,
                    opacity: 0.7,
                  ),
                ),
                child: null /* add child content here */,
              ),
              Center(
                child: CustomContainer(
                  padding: const EdgeInsets.all(15),
                  width: width - 50,
                  height: 400,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Register',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: const EdgeInsetsDirectional.only(top: 20),
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 2, 10, 2),
                                border: OutlineInputBorder(),
                                labelText: 'Username',
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 2, 10, 2),
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 2, 10, 2),
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            height: 35,
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: ElevatedButton(
                              onPressed: (() => {
                                    // print(nameController.text);
                                    // print(passwordController.text);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ContinueREgister(),
                                      ),
                                    ),
                                  }),
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
              )
            ],
          ),
        ));
  }
}
