import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurantapp/api/models/menu_model.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:restaurantapp/screens/table/table_page.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/darwer_widget.dart';

class TableDetail extends StatefulWidget {
  const TableDetail({super.key});

  @override
  State<TableDetail> createState() => _TableDetailState();
}

final _tableFormKey = GlobalKey<FormState>();
String dropdownValue = 'Available';

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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TableList()));
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
                "Table > Table 1",
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
            child: Form(
              key: _tableFormKey,
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
                            'assets/images/table.png',
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
                            // Text('20223-02-28 2:00 PM'),
                            // const SizedBox(
                            //   height: 5,
                            // ),
                            Container(
                                color: Colors.white,
                                width: 202,
                                child: TextFormField(
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      hintText: 'Table 1',
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
                                    width: 125,
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
                                Text('VIP'),
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
                      // Step 3.
                      value: dropdownValue,
                      // Step 4.
                      items: <String>['Available', 'Unavailable']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 17),
                          ),
                        );
                      }).toList(),
                      // Step 5.
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 10, top: 5, bottom: 5, right: 10),
                    width: MediaQuery.of(context).size.width - 30,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Number of sits ',
                          style: TextStyle(fontSize: 17),
                        ),
                        Container(
                            color: Colors.white,
                            width: 100,
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  hintText: '4',
                                  border: OutlineInputBorder()),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width - 30,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Booked By ',
                          style: TextStyle(fontSize: 17),
                        ),
                        Text(
                          'Zelalem Getachew ',
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width - 30,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Created On ',
                          style: TextStyle(fontSize: 17),
                        ),
                        Text(
                          '2023-0208 2:00 PM ',
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
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
