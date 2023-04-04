import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
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

  String initialCountry = 'DE';
  PhoneNumber number = PhoneNumber(isoCode: 'DE');
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
                  opacity: 0.8,
                ),
              ),
              child: Center(
                child: CustomContainer(
                  padding: const EdgeInsets.all(15),
                  width: width - 50,
                  height: 320,
                  color: Colors.white,
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
                            padding: const EdgeInsets.only(top: 1, bottom: 15),
                            child: const Text(
                              'Continue registration',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
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
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xffeeeeee),
                                      blurRadius: 10,
                                      offset: Offset(0, 4))
                                ]),
                            child: TextFormField(
                              keyboardType: TextInputType.streetAddress,
                              controller: locationController,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 235, 235, 235),
                                prefixIcon: Icon(Icons.location_on),
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 2, 10, 2),
                                border: InputBorder.none,
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
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 235, 235, 235),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xffeeeeee),
                                        blurRadius: 10,
                                        offset: Offset(0, 4))
                                  ]),
                              child: InternationalPhoneNumberInput(
                                autoFocus: false,
                                onInputChanged: (PhoneNumber number) {
                                  setState(() {
                                    this.number = number;
                                  });
                                },
                                errorMessage: 'Invalid phone number',
                                onInputValidated: (bool value) {},
                                selectorConfig: const SelectorConfig(
                                  selectorType:
                                      PhoneInputSelectorType.BOTTOM_SHEET,
                                ),
                                ignoreBlank: false,
                                autoValidateMode: AutovalidateMode.disabled,
                                selectorTextStyle:
                                    const TextStyle(color: Colors.black),
                                initialValue: null,
                                textFieldController: phoneController,
                                formatInput: true,
                                keyboardType: TextInputType.phone,
                                inputBorder: InputBorder.none,
                                onSaved: (PhoneNumber number) {
                                  setState(() {
                                    this.number = number;
                                  });
                                },
                              )),

                          //  TextFormField(
                          //   keyboardType: TextInputType.phone,
                          //   controller: phoneController,
                          //   decoration: const InputDecoration(
                          //     filled: true,
                          //     fillColor: Color.fromARGB(255, 235, 235, 235),
                          //     prefixIcon: Icon(Icons.phone),
                          //     contentPadding:
                          //         EdgeInsets.fromLTRB(10, 2, 10, 2),
                          //     border: InputBorder.none,
                          //     labelText: 'Phone Number',
                          //   ),
                          // ),

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
                            margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                            width: 135,
                            height: 35,
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final name = nameController.text;
                                  final location = locationController.text;
                                  final phone = number.phoneNumber;

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
              )),
        ));
  }
}
