import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
