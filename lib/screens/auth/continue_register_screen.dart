import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:restaurantapp/api/config.dart';
import 'package:restaurantapp/api/models/user_model.dart';
import 'package:restaurantapp/screens/home/home_page.dart';
import 'package:restaurantapp/widgets/custom_container.dart';

class ContinueRegister extends StatefulWidget {
  const ContinueRegister({super.key});

  @override
  State<ContinueRegister> createState() => _ContinueRegisterState();
}

class _ContinueRegisterState extends State<ContinueRegister> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String nameErrMsg = "";
  String locationErrMsg = "";
  String phoneErrMsg = "";
  int user_id = 0;
  bool _isProfileExist = false;
  late UserContinueRegister model;

  isIExist() async {
    // print("THIS IS RUNNGING:");
    try {
      String access_token = LocalStorage('tokens').getItem('access');
      var url = Uri.parse(ApiConstants.BASE_URL + ApiConstants.USER_ACCOUNT);
      var response = await http
          .get(url, headers: {"Authorization": "Bearer " + access_token});
      if (response.statusCode == 200) {
        return true;
      } else {
        // There is already a profile with this account
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  isProfileExist() async {
    // print("THIS IS RUNNGING:");
    try {
      String access_token = LocalStorage('tokens').getItem('access');
      var url = Uri.parse(ApiConstants.BASE_URL + ApiConstants.USER_PROFILE);
      var response = await http
          .get(url, headers: {"Authorization": "Bearer " + access_token});
      if (response.statusCode == 404) {
        setState(() {
          _isProfileExist = false;
        });
      } else {
        // There is already a profile with this account
        setState(() {
          _isProfileExist = true;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _isProfileExist = false;
      });
    }
  }

  continueRegisterUser(data) async {
    // print(data);
    try {
      var url =
          Uri.parse(ApiConstants.BASE_URL + ApiConstants.RESTAURANT_REGISTER);
      String access_token = LocalStorage('tokens').getItem('access');
      var response = await http.post(url,
          body: data, headers: {"Authorization": "Bearer " + access_token});
      // print(response.statusCode);
      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        print(jsonDecode(response.body));

        // setState(() {
        //   nameErrMsg = (jsonDecode(response.body)['name'] != null)
        //       ? jsonDecode(response.body)['name'][0]
        //       : "";
        //   locationErrMsg = (jsonDecode(response.body)['location'] != null)
        //       ? jsonDecode(response.body)['location'][0]
        //       : "";
        //   phoneErrMsg = (jsonDecode(response.body)['phone_number'] != null)
        //       ? jsonDecode(response.body)['phone_number'][0]
        //       : "";
        //   // passwordErrMsg = (jsonDecode(response.body)['user_type'] != null)
        //   //     ? jsonDecode(response.body)['user_type'][0]
        //   //     : "";
        // });
      }
    } catch (e) {
      print(e);
    }
  }

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

          body: Stack(
            children: [
              Container(
                height: height / 2 - 50,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/login.jpg"),
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
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                          Text(
                            nameErrMsg,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              letterSpacing: .8,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextField(
                              keyboardType: TextInputType.streetAddress,
                              controller: locationController,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 2, 10, 2),
                                border: OutlineInputBorder(),
                                labelText: 'Location',
                              ),
                            ),
                          ),
                          Text(
                            locationErrMsg,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              letterSpacing: .8,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              controller: phoneController,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 2, 10, 2),
                                border: OutlineInputBorder(),
                                labelText: 'Phone number',
                              ),
                            ),
                          ),
                          Text(
                            phoneErrMsg,
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
                                  final name = nameController.text;
                                  final location = locationController.text;
                                  final phone = phoneController.text;

                                  if (name == '') {
                                    setState(() {
                                      nameErrMsg =
                                          "Restaurnat name can not be empty";
                                    });
                                  } else {
                                    setState(() {
                                      nameErrMsg = "";
                                    });
                                  }

                                  if (location == '') {
                                    setState(() {
                                      locationErrMsg =
                                          "Emails can not be empty";
                                    });
                                  } else {
                                    setState(() {
                                      locationErrMsg = "";
                                    });
                                  }

                                  if (phone == '') {
                                    setState(() {
                                      phoneErrMsg = "Password can not be empty";
                                    });
                                  } else {
                                    setState(() {
                                      phoneErrMsg = "";
                                    });
                                  }

                                  // print(_isProfileExist);
                                  isProfileExist();

                                  if (_isProfileExist) {
                                    setState(() {
                                      phoneErrMsg =
                                          "you already created your account.";

                                      sleep(Duration(seconds: 3));
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage(),
                                        ),
                                      );
                                    });
                                  } else {
                                    if (name != '' &&
                                        location != '' &&
                                        phone != '') {
                                      continueRegisterUser({
                                        "name": name,
                                        "location": location,
                                        "phone_number": phone,
                                      });
                                    }
                                  }
                                }
                              },
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
