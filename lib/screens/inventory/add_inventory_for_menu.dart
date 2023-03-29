import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/darwer_widget.dart';

class AddInventoryForMenu extends StatefulWidget {
  const AddInventoryForMenu({super.key});

  @override
  State<AddInventoryForMenu> createState() => _AddInventoryForMenuState();
}

class _AddInventoryForMenuState extends State<AddInventoryForMenu> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // drawer: const DrawerWidget(),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50.0), // here the desired height
        child: MyAppbar(),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  8 * screenWidth / 100, 20, 7 * screenWidth / 100, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: const Text(
                      "Menu Name | Inventories",
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.w300,
                          fontFamily: "Merriweather"),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.black87,
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
                      const Expanded(
                        child: Text(
                          "Inventory",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          width: MediaQuery.of(context).size.width - 30,
                          decoration: BoxDecoration(
                            color: Colors.white70,
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
                                child:
                                    Text(value, style: TextStyle(fontSize: 14)),
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
                      const Expanded(
                        child: Text(
                          "Quantity",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                          color: Colors.white,
                          width: 190,
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                hintText: "1.0",
                                border: OutlineInputBorder()),
                          )),
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
                        onPressed: (() {}), child: Text('Add Inventory'))),

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
                              width: 70,
                              child: Text(
                                'No.',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Inventory',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Quantity',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Actions',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 70,
                            child: Text(
                              '1',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Oil',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          Expanded(
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
    );
  }
}
