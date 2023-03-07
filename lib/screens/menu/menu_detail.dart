import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurantapp/api/models/menu_model.dart';
import 'package:flutter/services.dart' as rootBundle;

import '../../widgets/app_bar.dart';
import '../../widgets/darwer_widget.dart';
import 'menu_page.dart';

class MenuDetail extends StatefulWidget {
  const MenuDetail({super.key});

  @override
  State<MenuDetail> createState() => _MenuDetailState();
}

class _MenuDetailState extends State<MenuDetail> {
  Future<List<MenuModel>> readJSon() async {
    var jsondata = await DefaultAssetBundle.of(context)
        .loadString("assets/data/menu.json");

    //decode json data as list
    List mapedData = json.decode(jsondata) as List<dynamic>;
    List<MenuModel> menus =
        mapedData.map((menu) => MenuModel.fromJson(menu)).toList();
    return menus;
  }

  final _menuFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    readJSon();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false, //new line

      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Text(
          "Fast Track | Restaurant",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MenuList()));
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Menu > Dish 1",
                style: TextStyle(
                    fontSize: 25.0,
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
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width - 20,
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
              borderRadius: BorderRadius.circular(10),
            ),
            child: Form(
              key: _menuFormKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: Color.fromARGB(255, 240, 240, 240),
                        padding: const EdgeInsets.all(2),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          child: Image.asset(
                            'assets/images/menu7.png',
                            fit: BoxFit.fill,
                            width: 115.0,
                            height: 117.0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('20223-02-28 2:00 PM'),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                                color: Colors.white,
                                width: 202,
                                child: TextFormField(
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      hintText: 'Dish Name',
                                      border: OutlineInputBorder()),
                                )),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    color: Colors.white,
                                    width: 100,
                                    child: TextFormField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          hintText: '\$14',
                                          border: OutlineInputBorder()),
                                    )),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text('Special'),
                                Checkbox(
                                    value: true,
                                    onChanged: ((value) => setState(() {})))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    // padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      minLines: 6,
                      maxLines: 7,
                      decoration: InputDecoration(
                          hintText: 'Description',
                          border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: 200,
                      height: 40,
                      child: ElevatedButton(
                          onPressed: () {}, child: Text('Submit')))
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
