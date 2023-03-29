import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:restaurantapp/screens/home_page.dart';
import 'package:restaurantapp/screens/inventory/add_inventory_for_menu.dart';
import 'package:restaurantapp/screens/login_screen.dart';
import 'package:restaurantapp/screens/menu/menu_page.dart';
import 'package:restaurantapp/screens/qr_generator.dart';
import 'package:restaurantapp/screens/qr_scanner.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
