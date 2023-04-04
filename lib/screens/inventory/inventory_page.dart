import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:restaurantapp/api/config.dart';
import 'package:restaurantapp/api/models/inventory_model.dart';
import 'package:restaurantapp/screens/inventory/inventory_detail.dart';
import 'package:restaurantapp/widgets/app_bar.dart';
import 'package:restaurantapp/widgets/darwer_widget.dart';

class InventoryList extends StatefulWidget {
  @override
  State<InventoryList> createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {
  // List<Inventory> inventories;
  bool _isLoading = false;

  Future<List<Inventory>> readJSon() async {
    try {
      String access_token = LocalStorage('tokens').getItem('access');
      var url = Uri.parse(ApiConstants.BASE_URL + ApiConstants.INVENTORIES);
      var response = await http
          .get(url, headers: {"Authorization": "Bearer " + access_token});
      if (response.statusCode == 200) {
        List mapedData = json.decode(response.body) as List<dynamic>;
        List<Inventory> inventories = mapedData
            .map((inventory) => Inventory.fromJson(inventory))
            .toList();
        // print(inventories);
        // setState(() {
        //   _isLoading = true;
        // });
        return inventories;
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
                "Inventories",
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
                      builder: (context) => InventoryDetail(
                        inventory: Inventory(
                          inventoryId: 0,
                          inventoryName: "",
                          quantity: 0,
                          measurement: "",
                          noticeIfBelow: 0,
                          createdOn: DateTime.now(),
                          updatedOn: DateTime.now(),
                          updateRemark: "",
                          restaurant: 0,
                        ), // update the id value to the desired value
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
                child: FutureBuilder<List<Inventory>>(
                  future: readJSon(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Inventory> inventories = snapshot.data!;
                      return ListView.builder(
                          itemCount: inventories.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: inventories[index].noticeIfBelow >=
                                        inventories[index].quantity
                                    ? const Color.fromARGB(255, 243, 201, 143)
                                    : const Color.fromARGB(255, 241, 241, 241),
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      '${index + 1}',
                                      style: const TextStyle(
                                          fontSize: 22.0,
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Merriweather"),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const SizedBox(
                                        width: 150,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(
                                          inventories[index].inventoryName,
                                          style: const TextStyle(
                                              fontSize: 18.0,
                                              color: Color(0xFF000000),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Merriweather"),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(
                                          "${inventories[index].quantity.toString()} ${inventories[index].measurement}",
                                          style: const TextStyle(
                                              fontSize: 16.0,
                                              color: Color(0xFF000000),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Merriweather"),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${DateTime.parse(inventories[index].updatedOn.toString()).year}-${DateTime.parse(inventories[index].updatedOn.toString()).month}-${DateTime.parse(inventories[index].updatedOn.toString()).day}",
                                    style: const TextStyle(
                                        fontSize: 11.0,
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xFF000000),
                                        fontWeight: FontWeight.w300,
                                        fontFamily: "Merriweather"),
                                  ),
                                  Container(
                                      // padding: const EdgeInsets.only(left: 10),
                                      child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) =>
                                              InventoryDetail(
                                                  inventory:
                                                      inventories[index])),
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
