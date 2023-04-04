import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:restaurantapp/api/config.dart';
import 'package:restaurantapp/screens/auth/continue_register_screen.dart';
import 'package:restaurantapp/screens/menu/menu_page.dart';
import 'package:restaurantapp/widgets/app_bar.dart';
import 'package:restaurantapp/widgets/darwer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocalStorage restaurantProfile = LocalStorage('restaurant');
  isIExist() async {
    // print("THIS IS RUNNGING:");
    try {
      String access_token = LocalStorage('tokens').getItem('access');
      var url = Uri.parse(ApiConstants.BASE_URL + ApiConstants.USER_PROFILE);
      var response = await http
          .get(url, headers: {"Authorization": "Bearer " + access_token});
      if (response.statusCode == 404) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ContinueRegister(),
          ),
        );
      } else {
        final restaurantData = jsonDecode(response.body);
        restaurantProfile.setItem(
            'restaurant_id', restaurantData['restaurant_id']);
        restaurantProfile.setItem('user_id', restaurantData['user_id']);
        restaurantProfile.setItem('name', restaurantData['name']);
        restaurantProfile.setItem('map_link', restaurantData['map_link']);
        restaurantProfile.setItem('location', restaurantData['location']);
        restaurantProfile.setItem(
            'phone_number', restaurantData['phone_number']);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    isIExist();
    return Scaffold(backgroundColor: Colors.white70, body: MenuList());
  }
}
