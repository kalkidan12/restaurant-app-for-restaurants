import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:restaurantapp/screens/register_screen.dart';
import 'package:restaurantapp/widgets/custom_button.dart';
import 'package:restaurantapp/widgets/custom_container.dart';
import 'package:restaurantapp/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Container(
        width: width,
        height: height,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 235, 235, 235),
          resizeToAvoidBottomInset: false, //new line

          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: Text(
                'Fast Track Restaurant',
                style: TextStyle(color: Colors.black),
              )),
          body: Stack(
            children: [
              Container(
                height: height / 2 - 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg_banner.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: null /* add child content here */,
              ),
              Center(
                child: CustomContainer(
                  padding: EdgeInsets.all(15),
                  width: width - 50,
                  height: 300,
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
                            'Login',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                            keyboardType: TextInputType.text,
                            hintText: 'Username',
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          CustomTextField(
                            keyboardType: TextInputType.text,
                            hintText: 'Password',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 120,
                            child: CustomButton(
                              onPressed: (() => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterScreen()))
                                  }),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              )
            ],
          ),
        ));
  }
}
