import 'dart:convert';

import 'package:flutter/services.dart' as rootBundle;
import 'package:restaurantapp/api/models/menu_model.dart';

class MenuController {
  Future<List<MenuModel>> readJSon() async {
    var jsondata =
        await rootBundle.rootBundle.loadString("assets/data/menu.json");

    //decode json data as list
    final list = json.decode(jsondata) as List<dynamic>;

    //map json and initialize using DataModel
    return list.map((e) => MenuModel.fromJson(e)).toList();
  }
}
