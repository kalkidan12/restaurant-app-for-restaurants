import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurantapp/api/controllers/menu_controllers.dart';
import 'package:restaurantapp/api/models/menu_model.dart';
import 'package:flutter/services.dart' as rootBundle;

import '../../widgets/app_bar.dart';
import '../../widgets/darwer_widget.dart';

class MenuList extends StatefulWidget {
  const MenuList({super.key});

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
// List menus = new MenuController().readJSon()

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // here the desired height
        child: MyAppbar(),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(
            8 * screenWidth / 100, 20, 7 * screenWidth / 100, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Menu",
                  style: TextStyle(
                      fontSize: 28.0,
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w300,
                      fontFamily: "Merriweather"),
                ),
                Icon(
                  Icons.add,
                  color: const Color(0xFF736c6c),
                  size: 42.0,
                ),
              ],
            ),
            const Divider(
              color: Colors.black87,
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            Container(
              height: MediaQuery.of(context).size.height - 200,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  MenuListItem(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuListItem extends StatefulWidget {
  const MenuListItem({super.key});

  @override
  State<MenuListItem> createState() => _MenuListItemState();
}

class _MenuListItemState extends State<MenuListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 241, 241, 241),
        boxShadow: List.filled(
          3,
          const BoxShadow(
            blurRadius: 4,
            blurStyle: BlurStyle.outer,
            color: Colors.black12,
          ),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              child: Image.asset(
                'assets/images/menu7.png',
                fit: BoxFit.fill,
                width: 100.0,
                height: 100.0,
              ),
            ),
          ),
          Container(
            height: 120,
            // width: MediaQuery.of(context).size.width - 174,
            padding: const EdgeInsets.only(left: 10),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 243, 243, 243),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        "Menu Name",
                        style: TextStyle(
                            fontSize: 22.0,
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Merriweather"),
                      ),
                      // SizedBox(height: 10,),
                      SizedBox(
                        width: 130,
                        child: Text(
                          "This is description",
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Merriweather"),
                        ),
                      ),
                      Text(
                        "\$10.95",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Merriweather"),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Icon(
                    Icons.edit,
                    color: Colors.blue[400],
                    size: 30,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
