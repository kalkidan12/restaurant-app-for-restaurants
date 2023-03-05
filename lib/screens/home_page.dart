import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:restaurantapp/api/config.dart';
import 'package:restaurantapp/screens/continue_register_screen.dart';

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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ContinueREgister(),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Home Page",
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              color: Colors.black87,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      backgroundColor: Colors.white70,
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              print(
                "ACCESS_TOKEN: " + LocalStorage('tokens').getItem('access'),
              );
            },
            child: const Text("Clickme")),
      ),
    );
  }
}
