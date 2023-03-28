import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:restaurantapp/screens/qr_generator.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import 'package:restaurantapp/api/models/menu_model.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:restaurantapp/api/models/table_model.dart';
import 'package:restaurantapp/screens/table/table_page.dart';

import '../../api/config.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/darwer_widget.dart';

class TableDetail extends StatefulWidget {
  final TableModel table;
  TableDetail({required this.table});

  @override
  State<TableDetail> createState() => _TableDetailState();
}

final _tableFormKey = GlobalKey<FormState>();
String dropdownValue = 'Available';

class _TableDetailState extends State<TableDetail> {
  final GlobalKey<FormState> _tableFormKey = GlobalKey<FormState>();

  late int tableId = 0;
  late int noOfSeats = 1;
  late bool isVip = false;
  late String price = '0.0';
  late bool isBooked = false;
  late int restaurant;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.table.isBooked ? 'Unavailable' : 'Available';
    if (widget.table.tableId != 0) {
      tableId = widget.table.tableId;
      noOfSeats = widget.table.noOfSeats;
      isVip = widget.table.isVip;
      price = widget.table.price;
      isBooked = widget.table.isBooked;
      restaurant = widget.table.restaurant;
    }
  }

  void _submitForm() {
    if (noOfSeats < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid number of sits.')),
      );

      return;
    }
    if (price == '0.0') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid price.')),
      );

      return;
    }

    if (price == '0.0') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid price.')),
      );

      return;
    }
    final data = {
      "no_of_seats": noOfSeats.toString(),
      "isVIP": isVip.toString(),
      "price": price.toString(),
      "isBooked": isBooked.toString(),
      "restaurant":
          LocalStorage('restaurant').getItem('restaurant_id').toString()
    };

    // print(data);
    if (tableId != 0) {
      updateTable(data);
    } else {
      createTable(data);
    }
  }

  Future<void> updateTable(data) async {
    try {
      String access_token = LocalStorage('tokens').getItem('access');
      var url =
          Uri.parse('${ApiConstants.BASE_URL}${ApiConstants.TABLES}$tableId/');
      final response = await http.put(
        url,
        headers: {"Authorization": "JWT ${access_token}"},
        body: data,
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Table $tableId updated successfully')),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to update Table $tableId. Please try again!')),
        );
        // print(response.statusCode);
      }
    } catch (error) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to update Table $tableId. Please try again!')),
        );
      });
      debugPrint(error.toString());
    }
  }

  Future<void> createTable(data) async {
    try {
      String access_token = LocalStorage('tokens').getItem('access');
      var url = Uri.parse('${ApiConstants.BASE_URL}${ApiConstants.TABLES}');
      final response = await http.post(
        url,
        headers: {"Authorization": "JWT ${access_token}"},
        body: data,
      );
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Table ${jsonDecode(response.body)['tableId']} created successfully!')),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to create this table. Please try again!')),
        );
      }
    } catch (error) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to create this table. Please try again!')),
        );
      });
      debugPrint(error.toString());
    }
  }

  Future<void> deleteTable() async {
    try {
      String access_token = LocalStorage('tokens').getItem('access');
      var url =
          Uri.parse('${ApiConstants.BASE_URL}${ApiConstants.TABLES}$tableId/');

      final response = await http.delete(
        url,
        headers: {"Authorization": "JWT ${access_token}"},
      );
      if (response.statusCode == 204) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Table $tableId deleted successfully')),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to delete table $tableId. Please try again!')),
        );
      }
    } catch (error) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to delete table $tableId. Please try again!')),
        );
      });
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (BuildContext context) => QRGenerator(
                  textQrCode:
                      "{'RestaurantID': '${LocalStorage('restaurant').getItem('restaurant_id')}', 'TableID': '$tableId'}"),
            ),
          );
        },
        child: Icon(Icons.qr_code),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Text(
          "Order Supreme | Restaurant",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TableList()));
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Table > ${tableId != 0 ? 'Table $tableId' : 'Create new table'}",
                style: const TextStyle(
                    fontSize: 25.0,
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.w300,
                    fontFamily: "Merriweather"),
              ),
              IconButton(
                onPressed: tableId != 0 ? deleteTable : null,
                icon: Icon(
                  tableId != 0 ? Icons.delete : Icons.delete_forever,
                  color: tableId != 0 ? Colors.red : Colors.grey,
                  size: 37.0,
                ),
              )
            ],
          ),
          const Divider(
            color: Colors.black87,
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width - 20,
            // height: MediaQuery.of(context).size.height - 300,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 231, 231, 231),
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
              key: _tableFormKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: const Color.fromARGB(255, 240, 240, 240),
                        padding: const EdgeInsets.all(2),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          child: Image.asset(
                            'assets/images/table.jpg',
                            fit: BoxFit.fill,
                            width: 100.0,
                            height: 100.0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              (tableId != 0)
                                  ? DateTime.parse(
                                          widget.table.createdOn.toString())
                                      .toUtc()
                                      .toString()
                                      .substring(0, 16)
                                  : DateTime.now()
                                      .toLocal()
                                      .toString()
                                      .substring(0, 16),
                              textAlign: TextAlign.end,
                              style:
                                  const TextStyle(fontStyle: FontStyle.italic),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                                color: Colors.white,
                                width: 190,
                                margin: EdgeInsets.only(left: 20),
                                child: TextFormField(
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    hintText: 'Table $tableId',
                                    border: OutlineInputBorder(),
                                  ),
                                  enabled: false,
                                )),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    color: Colors.white,
                                    width: 80,
                                    child: TextFormField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 2, horizontal: 10),
                                          hintText: '\$$price',
                                          border: OutlineInputBorder()),
                                      onChanged: (value) => setState(() {
                                        price = value;
                                      }),
                                    )),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Text('VIP'),
                                Checkbox(
                                  value: isVip,
                                  onChanged: ((value) => setState(() {
                                        isVip = value!;
                                      })),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
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
                      value: isBooked ? 'Unavailable' : 'Available',
                      items: <String>['Available', 'Unavailable']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(fontSize: 14)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          isBooked = newValue == 'Unavailable';
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    width: MediaQuery.of(context).size.width - 30,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Number of sits ',
                          style: TextStyle(fontSize: 14),
                        ),
                        Container(
                            color: Colors.white,
                            width: 100,
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 5),
                                hintText: '$noOfSeats',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) => setState(() {
                                if (int.tryParse(value) != null) {
                                  noOfSeats = int.parse(value);
                                } else {
                                  noOfSeats = 0;
                                }
                              }),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // Container(
                  //   padding: const EdgeInsets.all(15),
                  //   width: MediaQuery.of(context).size.width - 30,
                  //   decoration: BoxDecoration(
                  //     color: Colors.white70,
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         'Booked By ',
                  //         style: TextStyle(fontSize: 17),
                  //       ),
                  //       Text(
                  //         'Zelalem Getachew ',
                  //         style: TextStyle(fontSize: 17),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  // Container(
                  //   padding: const EdgeInsets.all(15),
                  //   width: MediaQuery.of(context).size.width - 30,
                  //   decoration: BoxDecoration(
                  //     color: Colors.white70,
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         'Created On ',
                  //         style: TextStyle(fontSize: 17),
                  //       ),
                  //       Text(
                  //         '2023-0208 2:00 PM ',
                  //         style: TextStyle(fontSize: 17),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  Container(
                      width: 200,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        child: Text(
                          tableId == 0 ? 'Add' : 'Edit',
                          style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Merriweather"),
                        ),
                      ))
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
