import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurantapp/api/models/menu_model.dart';
import 'package:flutter/services.dart' as rootBundle;

import '../../widgets/app_bar.dart';
import '../../widgets/darwer_widget.dart';

class TableDetail extends StatefulWidget {
  const TableDetail({super.key});

  @override
  State<TableDetail> createState() => _TableDetailState();
}

class _TableDetailState extends State<TableDetail> {
  Future<List<MenuModel>> readJSon() async {
    var jsondata = await DefaultAssetBundle.of(context)
        .loadString("assets/data/menu.json");

    //decode json data as list
    List mapedData = json.decode(jsondata) as List<dynamic>;
    List<MenuModel> menus =
        mapedData.map((menu) => MenuModel.fromJson(menu)).toList();
    return menus;
  }

  @override
  void initState() {
    super.initState();
    readJSon();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50.0), // here the desired height
        child: MyAppbar(),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Table > Table 1",
                style: TextStyle(
                    fontSize: 28.0,
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.w300,
                    fontFamily: "Merriweather"),
              ),
              IconButton(
                onPressed: () {
                  print('deleted');
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 37.0,
                ),
              )
            ],
          ),
          const Divider(
            color: Colors.black87,
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width - 20,
            height: MediaQuery.of(context).size.height - 300,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 231, 231, 231),
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
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text('image'),
                    Column(
                      children: [
                        Text('Table Name'),
                        Row(
                          children: [
                            Text('Price Input'),
                            Text('VIP Checkbox'),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Spacer(),
                Text('Availability status'),
                Spacer(),
                Row(
                  children: [
                    Text('Number of sits'),
                    Text('Number of sits Input'),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Text('Booked By: '),
                    Text('Zelalem Getachew'),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Text('Created On: '),
                    Text('2023-02-29 2:00 pm'),
                  ],
                ),
                Spacer(),
                Container(
                    width: 200,
                    height: 40,
                    child:
                        ElevatedButton(onPressed: () {}, child: Text('Submit')))
              ],
            ),
          )
        ]),
      ),
    );
  }
}
