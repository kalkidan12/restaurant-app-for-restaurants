import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:localstorage/localstorage.dart';

import 'package:http/http.dart' as http;
import '../../api/config.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/darwer_widget.dart';

class AddInventoryForMenu extends StatefulWidget {
  final int menuId;
  AddInventoryForMenu({Key? key, required this.menuId}) : super(key: key);

  @override
  State<AddInventoryForMenu> createState() => _AddInventoryForMenuState();
}

class _AddInventoryForMenuState extends State<AddInventoryForMenu> {
  late int menuId;

  @override
  void initState() {
    super.initState();
    menuId = widget.menuId;
  }

  Future<void> createMenuInventory(data) async {
    try {
      String access_token = LocalStorage('tokens').getItem('access');
      var url = Uri.parse(
          '${ApiConstants.BASE_URL}${ApiConstants.MENUS}$menuId/inventory/');
      final response = await http.post(
        url,
        headers: {"Authorization": "Bearer " + access_token},
        body: data,
      );
      if (response.statusCode == 200) {
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Error updating menu item. please try again.")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating menu item. please try again.")),
      );
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // drawer: const DrawerWidget(),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.lightBlue,
        elevation: 0,
        title: const Text(
          "Add Inventory",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      // appBar: const PreferredSize(
      //   preferredSize: Size.fromHeight(50.0), // here the desired height
      //   child: MyAppbar(),
      // ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    8 * screenWidth / 100, 20, 7 * screenWidth / 100, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Menu Name | Inventories",
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.w300,
                          fontFamily: "Merriweather"),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 50,
                child: const Divider(
                  color: Colors.black87,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 20223-02-28 2:00 PM
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        8 * screenWidth / 100, 20, 7 * screenWidth / 100, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Inventory",
                          style: TextStyle(fontSize: 22),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 10,
                            ),
                            width: MediaQuery.of(context).size.width - 30,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(179, 227, 227, 227),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: // Step 2.
                                DropdownButton<String>(
                              value: 'Vegetable Oil',
                              items: <String>[
                                'Vegetable Oil',
                                'Milk Oil',
                                'Honey'
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style: TextStyle(fontSize: 14)),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        8 * screenWidth / 100, 20, 7 * screenWidth / 100, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Quantity",
                          style: TextStyle(fontSize: 22),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                              color: Color.fromARGB(179, 227, 227, 227),
                              width: 190,
                              child: TextFormField(
                                textAlignVertical: TextAlignVertical.center,
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    hintText: "1.0",
                                    border: InputBorder.none),
                              )),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 65,
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: (() {}),
                          child: const Text(
                            'Add Inventory',
                            style: TextStyle(color: Colors.white),
                          ))),

                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: screenWidth,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          color: Colors.lightBlueAccent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              SizedBox(
                                width: 40,
                                child: Text(
                                  'No.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Inventory',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Quantity',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Actions',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 30,
                              child: Text(
                                '1',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            const Expanded(
                              child: Text(
                                'Oil',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            const Expanded(
                              child: Text(
                                '1.3 L',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blueAccent,
                                      size: 25,
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 25,
                                    )),
                              ],
                            ))
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
