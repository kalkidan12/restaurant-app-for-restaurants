import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:restaurantapp/api/config.dart';
import 'package:restaurantapp/api/models/menu_model.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:restaurantapp/screens/menu/menu_detail.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/darwer_widget.dart';

class MenuList extends StatefulWidget {
  const MenuList({super.key});

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  bool _isLoading = false;
  Future<List<MenuModel>> readJSon() async {
    try {
      String access_token = LocalStorage('tokens').getItem('access');
      var url = Uri.parse(ApiConstants.BASE_URL + ApiConstants.MENUS);
      var response = await http
          .get(url, headers: {"Authorization": "Bearer " + access_token});
      if (response.statusCode == 200) {
        List mapedData = json.decode(response.body) as List<dynamic>;
        List<MenuModel> menus =
            mapedData.map((menu) => MenuModel.fromJson(menu)).toList();
        // print(menus);
        // setState(() {
        //   _isLoading = true;
        // });
        return menus;
      } else {
        // There is already a profile with this account
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
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
        padding: EdgeInsets.fromLTRB(
            8 * screenWidth / 100, 20, 7 * screenWidth / 100, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Menus",
                style: TextStyle(
                    fontSize: 28.0,
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.w300,
                    fontFamily: "Merriweather"),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MenuDetail(
                        key: UniqueKey(),
                        id: 0, // update the id value to the desired value
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.lightBlue,
                  size: 42.0,
                ),
              )
            ],
          ),
          const Divider(
            color: Colors.black87,
          ),
          const SizedBox(height: 10),
          RefreshIndicator(
            onRefresh: () async {
              if (!_isLoading) {
                // check if an API request is not already in progress
                setState(() {
                  _isLoading =
                      true; // set the flag to true before starting the API request
                });
                await readJSon();
                setState(() {
                  _isLoading =
                      false; // set the flag to false after the API request is completed
                });
              }
            },
            child: Container(
                height: MediaQuery.of(context).size.height - 200,
                child: FutureBuilder<List<MenuModel>>(
                  future: readJSon(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<MenuModel> menus = snapshot.data!;
                      return ListView.builder(
                          itemCount: menus.length,
                          itemBuilder: (context, index) {
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
                                    color: const Color.fromARGB(
                                        255, 234, 234, 234),
                                    padding: const EdgeInsets.all(10),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                      child: Image.network(
                                        menus[index].image,
                                        fit: BoxFit.contain,
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
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              menus[index].name,
                                              style: const TextStyle(
                                                  fontSize: 22.0,
                                                  color: Color(0xFF000000),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Merriweather"),
                                            ),
                                            // SizedBox(height: 10,),
                                            SizedBox(
                                              width: 110,
                                              child: Text(
                                                menus[index].description,
                                                softWrap: true,
                                                style: const TextStyle(
                                                    fontSize: 15.0,
                                                    color: Color(0xFF000000),
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Merriweather"),
                                              ),
                                            ),
                                            Text(
                                              menus[index].price.toString(),
                                              style: const TextStyle(
                                                  fontSize: 20.0,
                                                  color: Color(0xFF000000),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Merriweather"),
                                            ),
                                          ],
                                        ),
                                        Container(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: ((context) =>
                                                        MenuDetail(
                                                            key: UniqueKey(),
                                                            id: menus[index]
                                                                .dishId)),
                                                  ),
                                                );
                                              },
                                              icon: Icon(
                                                Icons.edit,
                                                color: Colors.lightBlue[400],
                                                size: 30,
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    } else {
                      return Center(
                          child: Container(
                              width: 40,
                              height: 40,
                              child: const CircularProgressIndicator()));
                    }
                  },
                )),
          ),
        ]),
      ),
    );
  }
}
