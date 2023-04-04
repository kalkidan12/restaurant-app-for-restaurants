import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:restaurantapp/screens/inventory/inventory_page.dart';
import 'package:restaurantapp/screens/menu/menu_page.dart';
import 'package:restaurantapp/screens/order/order_page.dart';

import '../screens/table/table_page.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 238, 238, 238),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 30, 134, 220),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  LocalStorage('restaurant').getItem('name'),
                  style: const TextStyle(fontSize: 23, color: Colors.white),
                ),
                Text(LocalStorage('restaurant').getItem('location'),
                    style: const TextStyle(fontSize: 17, color: Colors.white)),
                Text(LocalStorage('restaurant').getItem('phone_number'),
                    style: const TextStyle(fontSize: 17, color: Colors.white)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.restaurant_menu,
                size: 30, color: Color.fromARGB(255, 1, 128, 187)),
            title: const Text(
              'Menus',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MenuList()));
            },
          ),
          const Divider(
            height: 1,
            color: Color.fromARGB(255, 2, 148, 197),
          ),
          ListTile(
            leading: const Icon(Icons.table_bar,
                size: 30, color: Color.fromARGB(255, 1, 128, 187)),
            title: const Text(
              'Tables',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TableList()));
            },
          ),
          const Divider(
            height: 1,
            color: Color.fromARGB(255, 2, 148, 197),
          ),
          ListTile(
            leading: Icon(Icons.bakery_dining_sharp,
                size: 30, color: Color.fromARGB(255, 1, 128, 187)),
            title: const Text(
              'Orders',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrderList()));
            },
          ),
          const Divider(
            height: 1,
            color: Color.fromARGB(255, 2, 148, 197),
          ),
          ListTile(
            leading: Icon(Icons.inventory,
                size: 30, color: Color.fromARGB(255, 1, 128, 187)),
            title: const Text(
              'Inventories',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InventoryList()));
            },
          ),
          const Divider(
            height: 1,
            color: Color.fromARGB(255, 2, 148, 197),
          ),
          ListTile(
            leading: Icon(Icons.payment,
                size: 30, color: Color.fromARGB(255, 1, 128, 187)),
            title: const Text(
              'Payments',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(
            height: 1,
            color: Color.fromARGB(255, 2, 148, 197),
          ),
          ListTile(
            leading: Icon(Icons.logout,
                size: 30, color: Color.fromARGB(255, 1, 128, 187)),
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
