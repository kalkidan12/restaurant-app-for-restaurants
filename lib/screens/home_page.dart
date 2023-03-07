import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:restaurantapp/api/config.dart';
import 'package:restaurantapp/screens/continue_register_screen.dart';
import 'package:restaurantapp/screens/menu/menu_page.dart';
import 'package:restaurantapp/widgets/app_bar.dart';
import 'package:restaurantapp/widgets/darwer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  isIExist() async {
    // print("THIS IS RUNNGING:");
    try {
      String access_token = LocalStorage('tokens').getItem('access');
      var url = Uri.parse(ApiConstants.BASE_URL + ApiConstants.USER_PROFILE);
      var response = await http
          .get(url, headers: {"Authorization": "JWT " + access_token});
      if (response.statusCode == 404) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        // There is already a profile with this account
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
