import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:restaurantapp/screens/menu/menu_page.dart';
import 'package:restaurantapp/screens/order/order_page.dart';

import '../screens/table/table_page.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 30, 134, 220),
              // image: new DecorationImage(
              //   image: AssetImage("assets/images/bg_banner.jpg"),
              //   fit: BoxFit.cover,
              // ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Rest Name',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                Text('Rest Location',
                    style: TextStyle(fontSize: 17, color: Colors.white)),
                Text('+2513747588',
                    style: TextStyle(fontSize: 17, color: Colors.white)),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.restaurant_menu,
              size: 30,
            ),
            title: const Text(
              'Menus',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MenuList()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.table_bar,
              size: 30,
            ),
            title: const Text(
              'Tables',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TableList()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.bakery_dining_sharp,
              size: 30,
            ),
            title: const Text(
              'Orders',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrderList()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.inventory,
              size: 30,
            ),
            title: const Text(
              'Inventories',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.payment,
              size: 30,
            ),
            title: const Text(
              'Payments',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              size: 30,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
