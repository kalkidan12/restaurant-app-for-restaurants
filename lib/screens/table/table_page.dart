import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurantapp/api/models/table_model.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:restaurantapp/api/models/table_model.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/darwer_widget.dart';

class TableList extends StatefulWidget {
  const TableList({super.key});

  @override
  State<TableList> createState() => _TableListState();
}

class _TableListState extends State<TableList> {
  Future<List<TableModel>> readJSon() async {
    var jsondata = await DefaultAssetBundle.of(context)
        .loadString("assets/data/table.json");

    //decode json data as list
    List mapedData = json.decode(jsondata) as List<dynamic>;
    List<TableModel> tables =
        mapedData.map((table) => TableModel.fromJson(table)).toList();
    return tables;
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
            children: const [
              Text(
                "table",
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
          Container(
              height: MediaQuery.of(context).size.height - 200,
              child: FutureBuilder<List<TableModel>>(
                future: readJSon(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<TableModel> tables = snapshot.data!;
                    return ListView.builder(
                        itemCount: tables.length,
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
                                  padding: EdgeInsets.all(10),
                                  color: Color.fromARGB(255, 234, 234, 234),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50)),
                                    child: Image.asset(
                                      tables[index].image,
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
                                    // border: Border.all(
                                    //   color: Colors.black,
                                    // ),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  tables[index].tname,
                                                  style: const TextStyle(
                                                      fontSize: 22.0,
                                                      color: Color(0xFF000000),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily:
                                                          "Merriweather"),
                                                ),
                                                // SizedBox(height: 10,),
                                                SizedBox(
                                                  width: 130,
                                                  child: Row(
                                                    children: [
                                                      const Text(
                                                        "Number of sits: ",
                                                        softWrap: true,
                                                        style: TextStyle(
                                                            fontSize: 15.0,
                                                            color: Color(
                                                                0xFF000000),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                "Merriweather"),
                                                      ),
                                                      Text(
                                                        tables[index].numSit,
                                                        softWrap: true,
                                                        style: const TextStyle(
                                                            fontSize: 15.0,
                                                            color: Color(
                                                                0xFF000000),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                "Merriweather"),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.blue[400],
                                              size: 30,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            tables[index].price,
                                            style: const TextStyle(
                                                fontSize: 20.0,
                                                color: Color(0xFF000000),
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Merriweather"),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "VIP",
                                            style: TextStyle(
                                                decoration: tables[index].isVip
                                                    ? TextDecoration.none
                                                    : TextDecoration
                                                        .lineThrough,
                                                fontSize: 18.0,
                                                color: Colors.red,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Merriweather"),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Available",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: tables[index].availble
                                                    ? Colors.green
                                                    : Colors.red,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Merriweather"),
                                          ),
                                        ],
                                      ),
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
        ]),
      ),
    );
  }
}
