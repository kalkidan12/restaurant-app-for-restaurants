import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:restaurantapp/screens/register_screen.dart';
import 'package:restaurantapp/widgets/custom_button.dart';
import 'package:restaurantapp/widgets/custom_container.dart';
import 'package:restaurantapp/widgets/text_field.dart';

class ContinueREgister extends StatefulWidget {
  const ContinueREgister({super.key});

  @override
  State<ContinueREgister> createState() => _ContinueREgisterState();
}

class _ContinueREgisterState extends State<ContinueREgister> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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
                  padding: EdgeInsets.all(15),
                  width: width - 50,
                  height: 400,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Continue registration',
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
                                labelText: 'Restaurant Name',
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              keyboardType: TextInputType.streetAddress,
                              controller: nameController,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 2, 10, 2),
                                border: OutlineInputBorder(),
                                labelText: 'Location',
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              controller: nameController,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 2, 10, 2),
                                border: OutlineInputBorder(),
                                labelText: 'Phone number',
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
                                            const RegisterScreen(),
                                      ),
                                    ),
                                  }),
                              child: const Text(
                                'Submit',
                              ),
                            ),
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
